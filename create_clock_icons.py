"""Create clock icons for the plugin"""
from PIL import Image, ImageDraw, ImageFont

def create_clock_icon(size=72):
    """Create a simple clock icon"""
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    # Background circle
    margin = 8
    draw.ellipse([margin, margin, size-margin, size-margin], fill='#1a1a1a', outline='#5865F2', width=3)

    # Clock center
    center = size // 2

    # Hour hand (pointing to 3)
    hand_length = size // 4
    draw.line([center, center, center + hand_length, center], fill='#FFFFFF', width=3)

    # Minute hand (pointing to 12)
    hand_length = size // 3
    draw.line([center, center, center, center - hand_length], fill='#5865F2', width=2)

    # Center dot
    dot_size = 4
    draw.ellipse([center-dot_size, center-dot_size, center+dot_size, center+dot_size], fill='#FFFFFF')

    return img

def create_category_icon(size=28):
    """Create a category icon"""
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    # Simple DL icon
    try:
        font = ImageFont.truetype('arialbd.ttf', 16)
    except:
        font = ImageFont.load_default()

    text = "DL"
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    x = (size - text_width) // 2
    y = (size - text_height) // 2

    draw.text((x, y), text, font=font, fill='#5865F2')

    return img

# Create icons
clock_icon = create_clock_icon(72)
clock_icon.save('com.windowcycle.streamdock.sdPlugin/static/img/clock-icon.png')
clock_icon.save('com.windowcycle.streamdock.sdPlugin/static/img/clock-icon-active.png')

category_icon = create_category_icon(28)
category_icon.save('com.windowcycle.streamdock.sdPlugin/static/img/category-icon.png')

print("[OK] Clock icons created!")
print("[OK] Category icon created!")
