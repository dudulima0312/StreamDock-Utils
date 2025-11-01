"""
Clock Action - Display customizable clock on StreamDock
Supports: HH:MM, HH only, MM only, Date
Customizable: font, color, background, outline
"""

import time
import threading
from datetime import datetime
from PIL import Image, ImageDraw, ImageFont
import io
import base64
import os
import sys
import requests
from src.core.action import Action
from src.core.logger import Logger

class Clock(Action):
    def __init__(self, action: str, context: str, settings: dict, plugin):
        super().__init__(action, context, settings, plugin)
        self.update_timer = None

        # Default settings
        default_settings = {
            'mode': 'time',  # 'time', 'hour', 'minute', 'date', 'custom', 'time_and_date'
            'font_family': 'Roboto',  # Google Font name
            'font_size': 32,
            'text_color': '#FFFFFF',
            'bg_color': '#000000',
            'outline_color': '#000000',
            'custom_format': 'HH:mm',  # Custom format string
            'two_line_mode': False,  # Two line display
            'show_am_pm_dot': False,  # Show AM/PM dot (PM only)
            'click_webhook': '',  # Webhook to trigger on click
            'webhook_timeout': 5,  # Request timeout
            'outline_width': 0,
            'bold': False,
            'use_12h': False,
            'offset_x': 0,
            'offset_y': 0
        }

        # Merge with provided settings
        default_settings.update(settings)
        self.settings = default_settings

        self.font_cache = {}
        self.last_image_cache = None
        self.last_settings_hash = None
        self.last_update_time = 0  # Throttle updates
        Logger.info(f"[Clock] Initialized with context {context}")

    def on_will_appear(self, payload: dict):
        """Start updating the clock when it appears"""
        Logger.info("[Clock] Will appear - starting updates")
        settings = payload.get('settings', {})
        self.settings.update(settings)
        self.start_updates()

    def on_will_disappear(self):
        """Stop updates when clock disappears"""
        Logger.info("[Clock] Will disappear - stopping updates")
        self.stop_updates()

    def on_settings_did_change(self, payload: dict):
        """Handle settings changes"""
        settings = payload.get('settings', {})
        self.settings.update(settings)
        # Force immediate update
        self.update_clock()

    def start_updates(self):
        """Start periodic clock updates"""
        self.stop_updates()
        self.update_clock()
        self.schedule_next_update()

    def stop_updates(self):
        """Stop periodic updates"""
        if self.update_timer:
            self.update_timer.cancel()
            self.update_timer = None

    def schedule_next_update(self):
        """Schedule next clock update"""
        # Update every second for time modes, every minute for date
        interval = 60 if self.settings['mode'] == 'date' else 1
        self.update_timer = threading.Timer(interval, self.update_and_schedule)
        self.update_timer.daemon = True
        self.update_timer.start()

    def update_and_schedule(self):
        """Update clock and schedule next update"""
        self.update_clock()
        self.schedule_next_update()

    def parse_custom_format(self, custom_format: str) -> str:
        """Convert user-friendly format to strftime format

        Args:
            custom_format: User format like "HH:mm dd/MM"

        Returns:
            strftime format like "%H:%M %d/%m"
        """
        replacements = {
            'HH': '%H',    # 24-hour (00-23)
            'hh': '%I',    # 12-hour (01-12)
            'mm': '%M',    # minutes (00-59)
            'ss': '%S',    # seconds (00-59)
            'dd': '%d',    # day of month (01-31)
            'MM': '%m',    # month (01-12)
            'yyyy': '%Y',  # full year (2025)
            'yy': '%y',    # short year (25)
            'AA': '%A',    # weekday full (Monday)
            'aa': '%a',    # weekday short (Mon)
            'BB': '%B',    # month full (January)
            'bb': '%b',    # month short (Jan)
        }

        result = custom_format
        # Replace in order from longest to shortest to avoid conflicts
        for user_format in sorted(replacements.keys(), key=len, reverse=True):
            result = result.replace(user_format, replacements[user_format])

        return result

    def get_display_text(self) -> tuple:
        """Get text to display based on mode

        Returns:
            tuple: (line1, line2) where line2 is None for single-line modes
        """
        now = datetime.now()
        mode = self.settings['mode']
        use_12h = self.settings['use_12h']

        # Two-line mode: time and date
        if mode == 'time_and_date':
            line1 = now.strftime('%I:%M' if use_12h else '%H:%M')
            line2 = now.strftime('%d/%m')
            return (line1, line2)

        # Custom format mode
        elif mode == 'custom':
            custom_format = self.settings.get('custom_format', 'HH:mm')
            strftime_format = self.parse_custom_format(custom_format)
            try:
                text = now.strftime(strftime_format)
                return (text, None)
            except Exception as e:
                Logger.error(f"[Clock] Invalid custom format: {e}")
                return ('ERR', None)

        # Standard single-line modes
        elif mode == 'time':
            if use_12h:
                return (now.strftime('%I:%M'), None)
            return (now.strftime('%H:%M'), None)

        elif mode == 'hour':
            if use_12h:
                return (now.strftime('%I'), None)
            return (now.strftime('%H'), None)

        elif mode == 'minute':
            return (now.strftime('%M'), None)

        elif mode == 'date':
            return (now.strftime('%d/%m'), None)

        # Default fallback
        return (now.strftime('%H:%M'), None)

    def download_google_font(self, font_name: str) -> str:
        """Download Google Font and return path to TTF file"""
        # For now, use system fonts
        # TODO: Implement Google Fonts API integration
        font_map = {
            'Roboto': 'arial.ttf',
            'Open Sans': 'arial.ttf',
            'Montserrat': 'arial.ttf',
            'Lato': 'arial.ttf',
            'Poppins': 'arial.ttf'
        }
        return font_map.get(font_name, 'arial.ttf')

    def get_font(self) -> ImageFont:
        """Get PIL font object"""
        font_name = self.settings['font_family']
        font_size = self.settings['font_size']
        bold = self.settings['bold']

        cache_key = f"{font_name}_{font_size}_{bold}"

        if cache_key in self.font_cache:
            return self.font_cache[cache_key]

        try:
            # Get fonts directory (works in both dev and packaged mode)
            if getattr(sys, 'frozen', False):
                # Running in PyInstaller bundle
                base_path = sys._MEIPASS
                fonts_dir = os.path.join(base_path, 'fonts')
            else:
                # Running in development
                fonts_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'fonts')

            # Map font names to font files
            font_map = {
                'Doto': 'Doto/static/Doto-Bold.ttf' if bold else 'Doto/static/Doto-Regular.ttf',
                'Sofia Sans': 'Sofia_Sans_Condensed/static/SofiaSansCondensed-Bold.ttf' if bold else 'Sofia_Sans_Condensed/static/SofiaSansCondensed-Regular.ttf',
                'Stint Ultra': 'Stint_Ultra_Condensed/StintUltraCondensed-Regular.ttf',
                'Coral Pixels': 'Coral_Pixels/CoralPixels-Regular.ttf',
                'Workbench': 'Workbench/Workbench-Regular.ttf',
                'Numbers Claimcheck': 'NumbersClaimcheck.ttf',
                'Numbers Deuce': 'NumbersDeuce.ttf',
                'Numbers Greenback': 'NumbersGreenback.ttf',
                'Numbers Premium': 'NumbersPremium.ttf',
                'Numbers Redbird': 'NumbersRedbird.ttf',
                'Numbers Revenue': 'NumbersRevenue.ttf',
                'Numbers Valuta': 'NumbersValutaOpen.ttf'
            }

            # Try custom fonts first
            if font_name in font_map:
                font_path = os.path.join(fonts_dir, font_map[font_name])
                if os.path.exists(font_path):
                    font = ImageFont.truetype(font_path, font_size)
                    self.font_cache[cache_key] = font
                    return font

            # Fall back to Windows system fonts
            windows_fonts = [
                r'C:\Windows\Fonts\arialbd.ttf' if bold else r'C:\Windows\Fonts\arial.ttf',
                r'C:\Windows\Fonts\segoeuib.ttf' if bold else r'C:\Windows\Fonts\segoeui.ttf'
            ]

            for font_path in windows_fonts:
                if os.path.exists(font_path):
                    font = ImageFont.truetype(font_path, font_size)
                    self.font_cache[cache_key] = font
                    return font

            raise Exception("No fonts found")

        except Exception as e:
            Logger.error(f"[Clock] Error loading font: {e}")
            # Use PIL's built-in bitmap font as last resort
            font = ImageFont.load_default()
            self.font_cache[cache_key] = font
            return font

    def hex_to_rgb(self, hex_color: str) -> tuple:
        """Convert hex color to RGB tuple"""
        hex_color = hex_color.lstrip('#')
        return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))

    def get_style_hash(self) -> str:
        """Generate hash of visual settings (excludes time-based text)"""
        style_keys = ['font_family', 'font_size', 'text_color', 'bg_color',
                     'outline_color', 'outline_width', 'bold', 'offset_x', 'offset_y']
        style_values = tuple(self.settings.get(k) for k in style_keys)
        return str(hash(style_values))

    def create_clock_image(self) -> str:
        """Create clock image and return as base64 data URI"""
        # StreamDock button size is typically 72x72
        size = (72, 72)

        # Get settings
        line1, line2 = self.get_display_text()
        bg_color = self.hex_to_rgb(self.settings['bg_color'])
        text_color = self.hex_to_rgb(self.settings['text_color'])
        outline_color = self.hex_to_rgb(self.settings['outline_color'])
        outline_width = self.settings['outline_width']

        # Create image
        img = Image.new('RGB', size, bg_color)
        draw = ImageDraw.Draw(img)

        # Check if two-line mode
        if line2 is not None:
            # Two-line mode: reduce font size for better fit
            original_font_size = self.settings['font_size']
            self.settings['font_size'] = int(original_font_size * 0.7)  # 70% of original

            font = self.get_font()

            # Draw line 1 (upper third)
            bbox1 = draw.textbbox((0, 0), line1, font=font)
            text_width1 = bbox1[2] - bbox1[0]
            x1 = (size[0] - text_width1) // 2 - bbox1[0]
            y1 = size[1] // 3 - (bbox1[3] - bbox1[1]) // 2 - bbox1[1]

            # Draw line 2 (lower two-thirds)
            bbox2 = draw.textbbox((0, 0), line2, font=font)
            text_width2 = bbox2[2] - bbox2[0]
            x2 = (size[0] - text_width2) // 2 - bbox2[0]
            y2 = 2 * size[1] // 3 - (bbox2[3] - bbox2[1]) // 2 - bbox2[1]

            # Draw outlines if enabled
            if outline_width > 0:
                for adj_x in range(-outline_width, outline_width + 1):
                    for adj_y in range(-outline_width, outline_width + 1):
                        if adj_x != 0 or adj_y != 0:
                            draw.text((x1 + adj_x, y1 + adj_y), line1, font=font, fill=outline_color)
                            draw.text((x2 + adj_x, y2 + adj_y), line2, font=font, fill=outline_color)

            # Draw text
            draw.text((x1, y1), line1, font=font, fill=text_color)
            draw.text((x2, y2), line2, font=font, fill=text_color)

            # Restore original font size
            self.settings['font_size'] = original_font_size

        else:
            # Single-line mode (original behavior)
            font = self.get_font()

            # Calculate text position (center)
            bbox = draw.textbbox((0, 0), line1, font=font)
            text_width = bbox[2] - bbox[0]
            text_height = bbox[3] - bbox[1]

            # Fix vertical centering by accounting for font baseline offset
            x = (size[0] - text_width) // 2 - bbox[0]
            y = (size[1] - text_height) // 2 - bbox[1]

            # Apply user-defined offsets
            x += self.settings.get('offset_x', 0)
            y += self.settings.get('offset_y', 0)

            # Draw outline if enabled
            if outline_width > 0:
                for adj_x in range(-outline_width, outline_width + 1):
                    for adj_y in range(-outline_width, outline_width + 1):
                        if adj_x != 0 or adj_y != 0:
                            draw.text((x + adj_x, y + adj_y), line1, font=font, fill=outline_color)

            # Draw text
            draw.text((x, y), line1, font=font, fill=text_color)

        # Draw AM/PM indicator dot (PM only)
        if self.settings.get('show_am_pm_dot', False):
            now = datetime.now()
            is_pm = now.hour >= 12

            if is_pm:  # Only show dot for PM
                dot_radius = 4
                dot_x = size[0] - 10  # 10px from right edge
                dot_y = 10  # 10px from top edge

                draw.ellipse(
                    [(dot_x - dot_radius, dot_y - dot_radius),
                     (dot_x + dot_radius, dot_y + dot_radius)],
                    fill=text_color  # Same color as text
                )

        # Convert to base64 with optimization
        buffer = io.BytesIO()
        img.save(buffer, format='PNG', optimize=True)
        img_str = base64.b64encode(buffer.getvalue()).decode()

        return f"data:image/png;base64,{img_str}"

    def update_clock(self, force=False):
        """Update the clock display"""
        try:
            # Throttle: prevent updates faster than every 50ms (unless periodic update)
            current_time = time.time()
            if not force and (current_time - self.last_update_time) < 0.05:
                return  # Skip this update, too fast

            self.last_update_time = current_time
            image_data = self.create_clock_image()
            self.set_image(image_data)
        except Exception as e:
            Logger.error(f"[Clock] Error updating clock: {e}")
            import traceback
            Logger.error(f"[Clock] Traceback: {traceback.format_exc()}")

    def trigger_webhook(self, webhook_url: str):
        """
        Trigger a webhook in a separate thread to avoid blocking

        Args:
            webhook_url: URL to POST to
        """
        if not webhook_url or webhook_url.strip() == '':
            Logger.info("[Clock] No webhook configured for click")
            return

        def send_request():
            try:
                Logger.info(f"[Clock] Triggering click webhook: {webhook_url}")

                # Detect webhook type and create appropriate payload
                now = datetime.now()
                timestamp = now.isoformat()
                mode = self.settings.get('mode', 'time')

                # Discord webhook detection
                if 'discord.com/api/webhooks' in webhook_url:
                    payload = {
                        'content': f'⏰ Clock clicked! Mode: {mode} | Time: {now.strftime("%H:%M:%S")}'
                    }
                else:
                    # Generic webhook (IFTTT, etc.)
                    payload = {
                        'action': 'clock_click',
                        'mode': mode,
                        'timestamp': timestamp
                    }

                response = requests.post(
                    webhook_url,
                    json=payload,
                    timeout=self.settings.get('webhook_timeout', 5)
                )

                # Discord returns 204 on success, others usually 200
                if response.status_code in [200, 204]:
                    Logger.info(f"[Clock] Webhook succeeded: {response.status_code}")
                    self.show_ok()
                else:
                    Logger.warning(f"[Clock] Webhook returned: {response.status_code}")
                    self.show_alert()

            except requests.exceptions.Timeout:
                Logger.error("[Clock] Webhook timed out")
                self.show_alert()
            except requests.exceptions.RequestException as e:
                Logger.error(f"[Clock] Webhook failed: {e}")
                self.show_alert()
            except Exception as e:
                Logger.error(f"[Clock] Unexpected error: {e}")
                self.show_alert()

        # Run in separate thread to avoid blocking
        thread = threading.Thread(target=send_request, daemon=True)
        thread.start()

    def on_key_down(self, payload: dict):
        """Handle button press - trigger webhook and force update"""
        Logger.info("[Clock] Key pressed")

        # Trigger webhook if configured
        webhook_url = self.settings.get('click_webhook', '')
        if webhook_url:
            self.trigger_webhook(webhook_url)

        # Force clock update
        self.update_clock()
