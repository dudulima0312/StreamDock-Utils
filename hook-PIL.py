# Runtime hook to ensure PIL._imaging is loaded
from PyInstaller.utils.hooks import collect_submodules, collect_data_files

hiddenimports = collect_submodules('PIL')
datas = collect_data_files('PIL')
