"""
Webhook Knob Action - Trigger webhooks on knob rotation and press
- Rotate left → webhook 1
- Rotate right → webhook 2
- Click center → webhook 3
"""

import requests
import threading
from src.core.action import Action
from src.core.logger import Logger

class WebhookKnob(Action):
    def __init__(self, action: str, context: str, settings: dict, plugin):
        super().__init__(action, context, settings, plugin)

        # Default settings
        default_settings = {
            'rotate_left_webhook': '',
            'rotate_right_webhook': '',
            'click_webhook': '',
            'timeout': 5  # Request timeout in seconds
        }

        # Merge with provided settings
        default_settings.update(settings)
        self.settings = default_settings

        Logger.info(f"[WebhookKnob] Initialized with context {context}")

    def on_will_appear(self, payload: dict):
        """Load settings when action appears"""
        settings = payload.get('settings', {})
        self.settings.update(settings)
        Logger.info("[WebhookKnob] Action appeared")

    def on_settings_did_change(self, payload: dict):
        """Handle settings changes"""
        settings = payload.get('settings', {})
        self.settings.update(settings)
        Logger.info("[WebhookKnob] Settings updated")

    def trigger_webhook(self, webhook_url: str, direction: str):
        """
        Trigger a webhook in a separate thread to avoid blocking

        Args:
            webhook_url: URL to POST to
            direction: 'left', 'right', or 'click'
        """
        if not webhook_url or webhook_url.strip() == '':
            Logger.info(f"[WebhookKnob] No webhook configured for {direction}")
            return

        def send_request():
            try:
                Logger.info(f"[WebhookKnob] Triggering {direction} webhook: {webhook_url}")

                # Send POST request with JSON payload
                payload = {
                    'action': direction,
                    'timestamp': None  # Will be set by requests
                }

                response = requests.post(
                    webhook_url,
                    json=payload,
                    timeout=self.settings.get('timeout', 5)
                )

                if response.status_code == 200:
                    Logger.info(f"[WebhookKnob] Webhook {direction} succeeded: {response.status_code}")
                    self.show_ok()
                else:
                    Logger.warning(f"[WebhookKnob] Webhook {direction} returned: {response.status_code}")
                    self.show_alert()

            except requests.exceptions.Timeout:
                Logger.error(f"[WebhookKnob] Webhook {direction} timed out")
                self.show_alert()
            except requests.exceptions.RequestException as e:
                Logger.error(f"[WebhookKnob] Webhook {direction} failed: {e}")
                self.show_alert()
            except Exception as e:
                Logger.error(f"[WebhookKnob] Unexpected error for {direction}: {e}")
                self.show_alert()

        # Run in separate thread to avoid blocking
        thread = threading.Thread(target=send_request, daemon=True)
        thread.start()

    def on_dial_rotate(self, payload: dict):
        """
        Handle knob rotation

        Payload contains:
        - ticks: Number of ticks rotated (positive = right, negative = left)
        - pressed: Whether knob was pressed while rotating
        """
        ticks = payload.get('ticks', 0)

        if ticks > 0:
            # Rotated right (clockwise)
            webhook_url = self.settings.get('rotate_right_webhook', '')
            self.trigger_webhook(webhook_url, 'right')
        elif ticks < 0:
            # Rotated left (counter-clockwise)
            webhook_url = self.settings.get('rotate_left_webhook', '')
            self.trigger_webhook(webhook_url, 'left')

    def on_dial_down(self, payload: dict):
        """Handle knob press (center button) - dialDown event for knobs"""
        webhook_url = self.settings.get('click_webhook', '')
        self.trigger_webhook(webhook_url, 'click')
