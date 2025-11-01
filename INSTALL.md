# 🎮 Guia de Instalação - WindowCycle Plugin

## ✅ Plugin Compilado com Sucesso!

O plugin WindowCycle foi compilado e está pronto para ser instalado no StreamDock.

## 📁 Localização do Plugin

```
WindowCycle-Dev/com.windowcycle.streamdock.sdPlugin/
```

## 🚀 Como Instalar no StreamDock

### Método 1: Arrastar e Soltar (Recomendado)

1. **Abra o StreamDock**
2. **Arraste a pasta** `com.windowcycle.streamdock.sdPlugin` para a janela do StreamDock
3. O plugin será instalado automaticamente
4. Reinicie o StreamDock se necessário

### Método 2: Copiar Manualmente

1. **Feche o StreamDock** completamente
2. **Copie a pasta** `com.windowcycle.streamdock.sdPlugin`
3. **Cole em**:
   ```
   %appdata%\Elgato\StreamDeck\Plugins\
   ```
4. **Abra o StreamDock** novamente
5. O plugin aparecerá na lista de ações disponíveis

### Método 3: Usando o Instalador do StreamDock

1. **Comprima a pasta** `com.windowcycle.streamdock.sdPlugin` em um arquivo ZIP
2. **Renomeie** a extensão de `.zip` para `.streamDockPlugin`
3. **Dê duplo clique** no arquivo `.streamDockPlugin`
4. O StreamDock instalará automaticamente

## 🎯 Como Usar

### Com Knob (StreamDock+)

1. **Arraste** a ação "Window Cycle" para um knob
2. **Gire o knob**: Abre o Task View e navega entre janelas
3. **Pare de girar**: Auto-seleciona após 1.5 segundos
4. **Pressione o knob**: Confirma a seleção imediatamente

### Com Botão

1. **Arraste** a ação "Window Cycle" para um botão
2. **Pressione**: Abre o Task View
3. **Pressione novamente**: Navega para a próxima janela
4. **Aguarde**: Auto-seleciona após o delay configurado

## ⚙️ Configurações

Clique na ação para abrir o Property Inspector e configurar:

- **Rotation Sensitivity**: Sensibilidade do knob (1-5 ticks)
- **Auto-release Delay**: Tempo até auto-seleção (0.5-5 segundos)
- **Reverse Direction**: Inverte a direção de rotação
- **Enable Knob Press**: Habilita seleção por pressão

## 🔧 Solução de Problemas

### Plugin não aparece no StreamDock

1. Verifique se a pasta está em `%appdata%\Elgato\StreamDeck\Plugins\`
2. Confirme que o nome da pasta termina com `.sdPlugin`
3. Reinicie o StreamDock completamente
4. Verifique os logs em `%appdata%\Elgato\StreamDeck\logs\`

### Alt+Tab não funciona

1. Execute o StreamDock como **Administrador**
2. Verifique as permissões de acessibilidade no Windows
3. Confirme que nenhum outro programa está bloqueando as teclas

### Executável não inicia

1. Verifique se o **Windows Defender** não está bloqueando
2. Adicione exceção para o executável se necessário
3. Verifique os logs do plugin

## 📊 Estrutura do Plugin

```
com.windowcycle.streamdock.sdPlugin/
├── WindowCycle.exe          # Executável compilado
├── manifest.json            # Configuração do plugin
├── en.json                  # Tradução em inglês
├── pt.json                  # Tradução em português
├── zh_CN.json               # Tradução em chinês
├── propertyInspector/       # Interface de configuração
│   └── windowcycle/
│       └── index.html
└── static/                  # Recursos estáticos
    └── img/
        ├── window-icon.png
        └── window-icon-active.png
```

## 🎨 Funcionalidades

- ✅ Simula Alt+Tab nativo do Windows
- ✅ Mantém Alt pressionado automaticamente
- ✅ Navegação suave com knob rotativo
- ✅ Auto-release inteligente
- ✅ Configurações personalizáveis
- ✅ Feedback visual em tempo real
- ✅ Suporte multi-idioma

## 📝 Notas Importantes

- O plugin requer **permissões de teclado** para funcionar
- Funciona melhor com **StreamDock+** (knob rotativo)
- Compatível com **Windows 7+**
- Testado no **StreamDock versão 3.10+**

## 🆘 Suporte

Se encontrar problemas:

1. Verifique os logs do plugin
2. Teste as dependências: `py test_dependencies.py`
3. Recompile se necessário: `build.bat`
4. Abra uma issue no GitHub

## 🎉 Aproveite!

Seu plugin WindowCycle está pronto para uso. Gire o knob e navegue entre suas janelas de forma intuitiva!

---

**Versão**: 1.0.0
**Compilado em**: {{ date }}
**Python**: 3.13.9
**PyInstaller**: 6.16.0