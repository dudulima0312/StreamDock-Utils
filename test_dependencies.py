#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script para testar se todas as dependências do WindowCycle estão instaladas corretamente
"""

import sys
import os

# Configurar encoding para Windows
if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

print("Python version:", sys.version)
print("-" * 50)

dependencies = [
    ('pynput', 'Controle de teclado/mouse'),
    ('pyautogui', 'Automação GUI'),
    ('PIL', 'Processamento de imagens (Pillow)'),
    ('websocket', 'WebSocket client'),
    ('requests', 'HTTP requests'),
    ('threading', 'Threading (built-in)'),
    ('json', 'JSON (built-in)'),
    ('time', 'Time (built-in)')
]

print("Testando dependências:\n")

all_ok = True
for module_name, description in dependencies:
    try:
        if module_name == 'PIL':
            from PIL import Image
            print(f"[OK] {module_name:<15} - {description:<30}")
        else:
            __import__(module_name)
            print(f"[OK] {module_name:<15} - {description:<30}")
    except ImportError as e:
        print(f"[ERRO] {module_name:<15} - {description:<30} - {e}")
        all_ok = False

print("-" * 50)

# Testar funcionalidades específicas
print("\nTestando funcionalidades específicas:\n")

try:
    from pynput.keyboard import Key, Controller
    print("[OK] pynput.keyboard importado com sucesso")
except Exception as e:
    print(f"[ERRO] pynput.keyboard: {e}")
    all_ok = False

try:
    import pyautogui
    pyautogui.FAILSAFE = False
    print("[OK] pyautogui configurado com sucesso")
except Exception as e:
    print(f"[ERRO] pyautogui: {e}")
    all_ok = False

try:
    from PIL import Image, ImageDraw
    print("[OK] PIL.Image e PIL.ImageDraw importados com sucesso")
except Exception as e:
    print(f"[ERRO] PIL components: {e}")
    all_ok = False

print("-" * 50)

if all_ok:
    print("\n>>> SUCESSO! Todas as dependencias estao instaladas corretamente!")
    print("\nVoce pode agora compilar o plugin com:")
    print("  cd WindowCycle-Dev")
    print("  build.bat")
else:
    print("\n>>> ATENCAO! Algumas dependencias estao faltando.")
    print("\nInstale as dependencias faltantes com:")
    print("  pip install pynput pyautogui Pillow websocket-client requests")

print("\n" + "=" * 50)