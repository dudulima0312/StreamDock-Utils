#!/usr/bin/env python
# Test if libraries are installed
import sys

print(f"Python: {sys.version}")
print(f"Python Path: {sys.executable}")
print()

try:
    import pynput
    print(f"[OK] pynput instalado")
    print(f"     Location: {pynput.__file__}")
except ImportError as e:
    print(f"[ERRO] pynput: {e}")

try:
    import pyautogui
    print(f"[OK] pyautogui instalado")
    print(f"     Location: {pyautogui.__file__}")
except ImportError as e:
    print(f"[ERRO] pyautogui: {e}")

try:
    import PyInstaller
    print(f"[OK] PyInstaller instalado")
except ImportError as e:
    print(f"[ERRO] PyInstaller: {e}")

print()
print("Testando import especifico do Windows...")
try:
    from pynput.keyboard import Key, Controller
    from pynput.keyboard._win32 import KeyCode
    print("[OK] pynput.keyboard._win32 importado com sucesso!")
except ImportError as e:
    print(f"[ERRO] pynput.keyboard._win32: {e}")
