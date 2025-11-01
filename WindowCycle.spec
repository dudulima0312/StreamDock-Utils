# -*- mode: python ; coding: utf-8 -*-
from PyInstaller.utils.hooks import collect_all, collect_dynamic_libs
import os
import sys

datas = [('src', 'src'), ('fonts', 'fonts')]
binaries = []
hiddenimports = [
    'pynput',
    'pynput.keyboard',
    'pynput.keyboard._win32',
    'pynput.keyboard._base',
    'pynput.mouse',
    'pynput.mouse._win32',
    'pynput.mouse._base',
    'pynput._util',
    'pynput._util.win32',
    'pyautogui',
    'PIL',
    'PIL._imaging',
    'requests',
    'urllib3',
    'certifi',
    'charset_normalizer',
    'idna'
]
tmp_ret = collect_all('pynput')
datas += tmp_ret[0]; binaries += tmp_ret[1]; hiddenimports += tmp_ret[2]
tmp_ret = collect_all('pyautogui')
datas += tmp_ret[0]; binaries += tmp_ret[1]; hiddenimports += tmp_ret[2]
tmp_ret = collect_all('PIL')
datas += tmp_ret[0]; binaries += tmp_ret[1]; hiddenimports += tmp_ret[2]
tmp_ret = collect_all('requests')
datas += tmp_ret[0]; binaries += tmp_ret[1]; hiddenimports += tmp_ret[2]

# FORCE include PIL dynamic libraries
binaries += collect_dynamic_libs('PIL')
binaries += collect_dynamic_libs('Pillow')


a = Analysis(
    ['main.py'],
    pathex=[],
    binaries=binaries,
    datas=datas,
    hiddenimports=hiddenimports,
    hookspath=['.'],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='WindowCycle',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
