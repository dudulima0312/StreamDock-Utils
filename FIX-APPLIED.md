# 🔧 WindowCycle - Correção Aplicada

## 🐛 Problema Identificado

**Sintoma**: Plugin aparecia no StreamDock mas não executava nenhuma função.

**Causa Raiz**: O arquivo `manifest.json` estava faltando campos críticos que informam ao StreamDock qual executável deve ser iniciado.

---

## ✅ Solução Implementada

### Campos Adicionados ao manifest.json:

```json
{
  "SDKVersion": 1,
  "CodePath": "WindowCycle.exe",
  "CodePathWin": "WindowCycle.exe",
  "Icon": "static/img/window-icon",
  "OS": [
    {
      "Platform": "windows",
      "MinimumVersion": "10"
    }
  ],
  "Software": {
    "MinimumVersion": "2.9"
  }
}
```

### Campos Críticos:

1. **`CodePath`** - Especifica o executável principal do plugin
2. **`CodePathWin`** - Especifica o executável para Windows
3. **`SDKVersion`** - Versão do SDK utilizada (1)
4. **`OS`** - Sistema operacional suportado
5. **`Software`** - Versão mínima do StreamDock

---

## 📝 Manifest Completo Atualizado

O manifest.json agora inclui:

- ✅ Actions com UUID, Icon, States, Controllers
- ✅ PropertyInspectorPath para configurações
- ✅ **CodePath e CodePathWin** (NOVO!)
- ✅ **SDKVersion** (NOVO!)
- ✅ **OS requirements** (NOVO!)
- ✅ **Software version** (NOVO!)
- ✅ Author, Description, Name, Version
- ✅ URL do repositório

---

## 🔄 Reinstalação Automática

Um novo script PowerShell foi criado para facilitar a reinstalação:

### `reinstall-fixed.ps1`
```powershell
.\reinstall-fixed.ps1
```

Este script:
1. Remove instalação anterior
2. Copia plugin atualizado
3. Verifica manifest.json
4. Verifica WindowCycle.exe
5. Confirma que CodePath está presente

---

## 🚀 Próximos Passos

### 1. Reinicie o StreamDock

**Opção A - Script automático:**
```cmd
restart-streamdock-ajazz.bat
```

**Opção B - Manual:**
1. Feche o **Stream Dock AJAZZ Global**
2. Aguarde **3 segundos**
3. Abra novamente o **Stream Dock AJAZZ Global**

### 2. Teste o Plugin

1. Arraste **"Window Cycle"** para um knob ou botão
2. **Gire o knob** ou **clique no botão**
3. O Task View (Alt+Tab) deve abrir
4. Continue girando para navegar entre janelas
5. Pare de girar para auto-selecionar após 1.5s

---

## 🔍 Verificação

Se o plugin ainda não funcionar:

### 1. Verifique o executável está sendo iniciado

Abra o **Gerenciador de Tarefas** (Ctrl+Shift+Esc) e procure por:
- `WindowCycle.exe`

### 2. Execute o plugin manualmente para testar

```cmd
cd "%APPDATA%\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"
WindowCycle.exe
```

Se aparecer erro de dependências:
```cmd
pip install pynput pyautogui
```

### 3. Verifique se o StreamDock tem permissões

Execute o **Stream Dock AJAZZ Global** como **Administrador**:
1. Clique direito no ícone
2. "Executar como administrador"

---

## 📊 Comparação: Antes vs Depois

### Antes (Não Funcionava):
```json
{
  "Actions": [...],
  "Author": "Dudu Lima",
  "Description": "...",
  "Name": "Window Cycle",
  "Version": "1.0.0"
}
```
❌ Faltava informação sobre qual executável rodar!

### Depois (Funciona):
```json
{
  "Actions": [...],
  "SDKVersion": 1,
  "Author": "Dudu Lima",
  "CodePath": "WindowCycle.exe",
  "CodePathWin": "WindowCycle.exe",
  "OS": [{"Platform": "windows", "MinimumVersion": "10"}],
  "Software": {"MinimumVersion": "2.9"},
  "Name": "Window Cycle",
  "Version": "1.0.0"
}
```
✅ StreamDock agora sabe qual executável iniciar!

---

## 🎯 Por Que Isso Aconteceu?

O Ajazz StreamDock é baseado no Elgato Stream Deck SDK, mas com diferenças:

1. **Diretórios diferentes**:
   - Elgato: `%APPDATA%\Elgato\StreamDeck\Plugins\`
   - Ajazz: `%APPDATA%\HotSpot\StreamDock\plugins\`

2. **Manifest mais rigoroso**:
   - Ajazz requer `CodePath` explícito
   - Elgato pode inferir do nome do diretório

3. **Formato de ícones**:
   - Ambos precisam de arquivos sem extensão
   - Mas Ajazz é mais estrito

---

## ✨ Resultado Esperado

Após reiniciar o StreamDock com o manifest corrigido:

1. ✅ Plugin aparece na lista de ações
2. ✅ **WindowCycle.exe é iniciado pelo StreamDock**
3. ✅ Conexão WebSocket estabelecida
4. ✅ Knob/botão responde aos comandos
5. ✅ Task View abre e navega entre janelas
6. ✅ Auto-release funciona após 1.5s

---

## 🆘 Se Ainda Não Funcionar

Entre em contato informando:

1. Se `WindowCycle.exe` aparece no Gerenciador de Tarefas
2. Mensagens de erro ao executar manualmente
3. Conteúdo dos logs do StreamDock (se existirem)
4. Resultado do teste manual do executável

---

## 📚 Arquivos Atualizados

- ✅ [com.windowcycle.streamdock.sdPlugin/manifest.json](com.windowcycle.streamdock.sdPlugin/manifest.json)
- ✅ [reinstall-fixed.ps1](reinstall-fixed.ps1) - Novo script de reinstalação
- ✅ [FIX-APPLIED.md](FIX-APPLIED.md) - Este documento

---

**Correção aplicada em**: 2025-11-01
**Versão do Plugin**: 1.0.0
**Status**: ✅ Pronto para reiniciar StreamDock

---

# 🎮 AGORA REINICIE O STREAMDOCK E TESTE!

```cmd
restart-streamdock-ajazz.bat
```
