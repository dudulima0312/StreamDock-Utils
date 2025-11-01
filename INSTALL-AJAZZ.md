# 🎮 Guia de Instalação - WindowCycle para Ajazz StreamDock

## ✅ Plugin Instalado!

O plugin WindowCycle já foi instalado no diretório correto do Ajazz StreamDock.

---

## 📁 Localização da Instalação

O plugin está instalado em:
```
%APPDATA%\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin\
```

Caminho completo:
```
C:\Users\Dudu Lima\AppData\Roaming\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin\
```

---

## 🔄 PRÓXIMO PASSO: Reiniciar o StreamDock

### Opção 1: Script Automático
```cmd
cd WindowCycle-Dev
restart-streamdock-ajazz.bat
```

### Opção 2: Manual
1. **Feche** o StreamDock AJAZZ Global completamente
2. **Aguarde** 3 segundos
3. **Abra** novamente o StreamDock
4. O plugin "Window Cycle" deve aparecer na lista de ações

---

## 🔍 Verificação

Após reiniciar o StreamDock:

1. Abra o **StreamDock AJAZZ Global**
2. Procure por **"Window Cycle"** na lista de ações
3. O plugin deve aparecer com o ícone colorido (DUDU LIMA)

---

## 🚨 Se o Plugin NÃO Aparecer

### 1. Verificar Instalação
```cmd
dir "%APPDATA%\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"
```

Deve mostrar:
- WindowCycle.exe (8.3 MB)
- manifest.json
- propertyInspector/
- static/
- *.json (traduções)

### 2. Verificar Logs
Abra o arquivo de log mais recente em:
```
%APPDATA%\HotSpot\StreamDock\logs\
```

Procure por:
- Erros relacionados a "windowcycle"
- Mensagens sobre "Plugin is now connected"
- Erros de carregamento

### 3. Verificar manifest.json
O arquivo deve ter este formato:
```json
{
  "Actions": [
    {
      "UUID": "com.windowcycle.streamdock.windowcycle",
      "Icon": "static/img/window-icon",
      "Name": "Window Cycle",
      "States": [{"Image": "static/img/window-icon"}],
      "Controllers": ["Keypad", "Knob"]
    }
  ],
  "Author": "Dudu Lima",
  "Description": "Navigate through open windows using Task View",
  "Name": "Window Cycle",
  "Version": "1.0.0"
}
```

### 4. Reinstalar
Se necessário, delete e copie novamente:
```cmd
rd /s /q "%APPDATA%\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"
xcopy /E /I "WindowCycle-Dev\com.windowcycle.streamdock.sdPlugin" "%APPDATA%\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"
```

---

## 🎮 Como Usar (Após Instalação)

### Com Knob:
1. **Arraste** a ação "Window Cycle" para um knob
2. **Gire**: Abre Task View e navega entre janelas
3. **Pare**: Auto-seleciona após 1.5s
4. **Pressione**: Confirma imediatamente

### Com Botão:
1. **Arraste** para um botão
2. **Clique**: Abre Task View
3. **Clique novamente**: Navega
4. **Aguarde**: Auto-seleciona

---

## ⚙️ Configurações

Clique com botão direito na ação para configurar:
- Sensibilidade de rotação
- Delay de auto-seleção
- Direção de rotação
- Comportamento da pressão

---

## 📝 Diferenças do Ajazz StreamDock

O Ajazz StreamDock tem algumas diferenças em relação ao Elgato Stream Deck:

### Diretórios:
- **Plugins do sistema**: `C:\Program Files (x86)\Stream Dock AJAZZ Global\plugins\`
- **Plugins do usuário**: `%APPDATA%\HotSpot\StreamDock\plugins\` ✅ (usar este)
- **Logs**: `%APPDATA%\HotSpot\StreamDock\logs\`
- **Configurações**: `%APPDATA%\HotSpot\StreamDock\config\`

### Manifest.json:
- Formato mais simples
- Ícones sem extensão (.png)
- Não usa CodePath/SDKVersion/OS
- Não usa PropertyInspectorPath

---

## 🔧 Solução de Problemas

### Plugin não inicia o executável

1. Execute manualmente para testar:
```cmd
cd "%APPDATA%\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"
WindowCycle.exe
```

2. Se der erro, instale dependências:
```cmd
pip install pynput pyautogui
```

### Alt+Tab não funciona

1. Execute StreamDock como **Administrador**
2. Verifique Windows Defender
3. Teste Alt+Tab manualmente

### Ícones não aparecem

1. Verifique se existem arquivos sem extensão:
```cmd
dir "%APPDATA%\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin\static\img\window-icon"
```

2. Se não existir, copie:
```cmd
cd "%APPDATA%\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin\static\img"
copy window-icon.png window-icon
copy window-icon-active.png window-icon-active
```

---

## 📊 Checklist de Instalação

- [x] Plugin copiado para `%APPDATA%\HotSpot\StreamDock\plugins\`
- [x] Ícones sem extensão criados
- [x] manifest.json atualizado para formato Ajazz
- [ ] StreamDock reiniciado
- [ ] Plugin aparece na lista de ações
- [ ] Testado com knob/botão

---

## 🎊 Tudo Pronto!

**AGORA REINICIE O STREAMDOCK** e o plugin deve aparecer!

```cmd
# Execute:
restart-streamdock-ajazz.bat
```

Após reiniciar, procure por **"Window Cycle"** na lista de ações disponíveis.

---

## 💡 Dica

O plugin funciona melhor com um **knob** do que com um botão, pois foi projetado para navegação rotativa através do Task View.

Se você tem um Ajazz AK820/AK820 Pro ou similar com knobs, use o plugin em um knob para a melhor experiência!

---

**Boa sorte e divirta-se navegando entre suas janelas!** 🎮✨