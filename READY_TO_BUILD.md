# ✅ WindowCycle Plugin - Pronto para Compilar!

## Status da Instalação

### ✓ Python e Dependências
- **Python 3.13.9** instalado e configurado
- **PATH** atualizado com Python e Scripts
- Todas as dependências instaladas:
  - ✓ pynput (controle de teclado)
  - ✓ pyautogui (automação GUI)
  - ✓ Pillow (processamento de imagens)
  - ✓ websocket-client (comunicação WebSocket)
  - ✓ requests (requisições HTTP)
  - ✓ pyinstaller (compilador)

### ✓ Arquivos do Plugin
- `windowcycle.py` - Lógica principal do Task View
- `manifest.json` - Configuração do plugin
- `propertyInspector/` - Interface de configurações
- `build.bat` - Script de compilação

## 🚀 Como Compilar

### Opção 1: Script Automático (Recomendado)
```cmd
cd WindowCycle-Dev
build.bat
```

### Opção 2: Compilação Manual
```cmd
cd WindowCycle-Dev
pyinstaller --onefile --windowed --name WindowCycle --add-data "src;src" main.py
```

### Opção 3: Usando o .spec file
```cmd
cd WindowCycle-Dev
pyinstaller WindowCycle.spec
```

## 📁 Após a Compilação

O executável compilado estará em:
- `dist/WindowCycle.exe`

Para criar o plugin completo:
1. Copie `WindowCycle.exe` para a pasta do plugin
2. Adicione os arquivos necessários:
   - manifest.json
   - propertyInspector/
   - static/ (com ícones)
   - Arquivos de tradução (.json)

## ⚠️ Antes de Compilar

### Criar Ícones (IMPORTANTE!)
Você precisa criar os ícones do plugin:
- `static/img/window-icon.png` (144x144px)
- `static/img/window-icon-active.png` (144x144px)

Veja `CREATE_ICONS.md` para instruções detalhadas.

## 🧪 Testar Dependências

Para verificar se tudo está instalado:
```cmd
py test_dependencies.py
```

## 📋 Checklist Final

- [x] Python instalado (3.13.9)
- [x] Python adicionado ao PATH
- [x] Dependências instaladas
- [x] Código do plugin configurado
- [x] Property Inspector criado
- [x] Manifest.json configurado
- [ ] Ícones criados (você precisa criar)
- [ ] Plugin compilado
- [ ] Testado no StreamDock

## 🎮 Como o Plugin Funciona

1. **Girar o Knob**: Abre Task View (Alt+Tab) e navega
2. **Parar de Girar**: Auto-seleciona após 1.5s
3. **Pressionar Knob**: Confirma seleção imediata
4. **Configurações**: Ajuste sensibilidade e delay no Property Inspector

## 💡 Dicas

- Se houver erro de compilação, tente:
  ```cmd
  pip install --upgrade pyinstaller
  pip install --upgrade setuptools
  ```

- Para debug, execute diretamente:
  ```cmd
  py main.py -port 28196 -pluginUUID test -registerEvent registerPlugin -info "{}"
  ```

## 🆘 Suporte

Se encontrar problemas:
1. Execute `py test_dependencies.py` para verificar dependências
2. Verifique os logs em `%appdata%\Elgato\StreamDeck\logs\`
3. Consulte a documentação em `README.md`

---

**Tudo pronto! Você pode agora compilar o plugin com `build.bat`** 🎉