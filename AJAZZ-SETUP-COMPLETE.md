# ✅ WindowCycle - Configuração para Ajazz StreamDock COMPLETA!

## 🎯 Status: PRONTO PARA USAR

---

## 📍 Plugin Instalado Em:

```
C:\Users\Dudu Lima\AppData\Roaming\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin\
```

---

## ✅ O Que Foi Feito:

1. ✅ Plugin compilado com sucesso (8.3 MB)
2. ✅ Manifest.json adaptado para formato Ajazz
3. ✅ Ícones configurados corretamente (com e sem extensão)
4. ✅ Plugin copiado para o diretório correto do Ajazz
5. ✅ Scripts de instalação e reinicialização criados
6. ✅ Documentação completa em INSTALL-AJAZZ.md

---

## 🚀 PRÓXIMO PASSO: REINICIE O STREAMDOCK!

### Execute este comando:

```cmd
restart-streamdock-ajazz.bat
```

**OU faça manualmente:**

1. Feche o **Stream Dock AJAZZ Global** completamente
2. Aguarde **3 segundos**
3. Abra o **Stream Dock AJAZZ Global** novamente
4. Procure por **"Window Cycle"** na lista de ações

---

## 🔍 Como Encontrar o Plugin

Após reiniciar o StreamDock:

1. Abra o **Stream Dock AJAZZ Global**
2. Na lista de ações, procure por:
   - **"Window Cycle"**
   - Ícone: Logo colorido "DUDU LIMA"
3. Arraste para um **knob** ou **botão**

---

## 🎮 Como Usar

### Com Knob (Recomendado):
- **Gire**: Abre Task View (Alt+Tab) e navega entre janelas
- **Pare de girar**: Auto-seleciona após 1.5 segundos
- **Pressione**: Confirma seleção imediatamente

### Com Botão:
- **Clique**: Abre Task View
- **Clique novamente**: Navega para próxima janela
- **Aguarde**: Auto-seleciona após delay

---

## ⚙️ Diferenças do Ajazz StreamDock

### Descobertas Importantes:

1. **Diretório de Plugins do Usuário**:
   - ✅ `%APPDATA%\HotSpot\StreamDock\plugins\`
   - ❌ Não: `C:\Program Files (x86)\Stream Dock AJAZZ Global\plugins\`

2. **Formato do manifest.json**:
   - Mais simples que o Elgato Stream Deck
   - Não usa: `CodePath`, `SDKVersion`, `OS`, `PropertyInspectorPath`
   - Usa ícones sem extensão

3. **Estrutura de Ícones**:
   - Precisa ter arquivos **com** e **sem** extensão `.png`
   - Exemplo: `window-icon.png` E `window-icon`

---

## 🔧 Se o Plugin NÃO Aparecer

### 1. Verificar Instalação:
```cmd
dir "%APPDATA%\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"
```

### 2. Reinstalar:
```cmd
install-to-ajazz.bat
```

### 3. Verificar Logs:
```cmd
cd "%APPDATA%\HotSpot\StreamDock\logs"
dir /o-d
# Abra o arquivo de log mais recente
```

### 4. Testar Executável:
```cmd
cd "%APPDATA%\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"
WindowCycle.exe
```

---

## 📊 Arquivos Criados

### Scripts:
- ✅ `install-to-ajazz.bat` - Instalação automática
- ✅ `restart-streamdock-ajazz.bat` - Reiniciar StreamDock

### Documentação:
- ✅ `INSTALL-AJAZZ.md` - Guia completo para Ajazz
- ✅ `AJAZZ-SETUP-COMPLETE.md` - Este arquivo (resumo)

### Plugin:
- ✅ `com.windowcycle.streamdock.sdPlugin/` - Plugin completo
  - WindowCycle.exe (8.3 MB)
  - manifest.json (formato Ajazz)
  - static/img/window-icon (com e sem .png)
  - propertyInspector/
  - Traduções (en, pt, zh_CN)

---

## 🎯 Checklist Final

- [x] Plugin compilado
- [x] Manifest adaptado para Ajazz
- [x] Ícones configurados
- [x] Plugin instalado no diretório correto
- [x] Scripts de instalação criados
- [x] Documentação completa
- [ ] **StreamDock reiniciado** ⬅️ VOCÊ ESTÁ AQUI!
- [ ] Plugin aparece na lista
- [ ] Testado e funcionando

---

## 🎊 PRÓXIMA AÇÃO

**REINICIE O STREAMDOCK AGORA!**

```cmd
restart-streamdock-ajazz.bat
```

Depois procure por **"Window Cycle"** nas ações disponíveis!

---

## 💡 Dica Pro

O plugin funciona **MUITO MELHOR** com um **knob** do que com um botão!

Se você tem um teclado Ajazz com knob (como AK820 Pro), use o plugin em um knob para navegar suavemente entre janelas girando!

---

## 🆘 Suporte

Se precisar de ajuda:

1. Veja `INSTALL-AJAZZ.md` para guia detalhado
2. Verifique logs em `%APPDATA%\HotSpot\StreamDock\logs\`
3. Execute `install-to-ajazz.bat` para reinstalar

---

## ✨ Funcionalidades

- ✅ Simula Alt+Tab nativo do Windows
- ✅ Mantém Alt pressionado automaticamente
- ✅ Navegação suave com knob rotativo
- ✅ Auto-release inteligente (1.5s padrão)
- ✅ Configurações personalizáveis
- ✅ Suporte a knob E botão
- ✅ Multi-idioma (EN, PT, ZH)

---

# 🎮 BOA SORTE E DIVIRTA-SE!

**Criado com ❤️ por Dudu Lima**
**Versão 1.0.0**

---