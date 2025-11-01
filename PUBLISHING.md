# 📤 Guia de Publicação no Marketplace StreamDock

## 📋 Checklist Pré-Publicação

Antes de submeter seu plugin, certifique-se de que tudo está em ordem:

### ✅ Arquivos Obrigatórios

- [x] **manifest.json** - Configuração completa do plugin
- [x] **WindowCycle.exe** - Executável compilado
- [x] **README.txt** - Descrição do plugin para usuários
- [x] **Ícones** - Todos os ícones em PNG (72x72px)
- [x] **Property Inspectors** - UIs de configuração funcionando
- [x] **Fontes** - Todas as fontes customizadas incluídas

### ✅ Manifest.json Validado

Verifique se seu `manifest.json` contém:

```json
{
  "Name": "WindowCycle Utils",
  "Version": "1.0.0",
  "Author": "Dudu Lima",
  "Description": "Descrição completa e atrativa",
  "Icon": "static/img/category-icon",
  "Category": "System Tools",
  "URL": "https://github.com/dudulima0312/StreamDock-Utils",
  "SDKVersion": 1,
  "Software": {
    "MinimumVersion": "2.0"
  },
  "OS": [
    {
      "Platform": "windows",
      "MinimumVersion": "10"
    }
  ],
  "CodePath": "WindowCycle.exe",
  "Actions": [...]
}
```

### ✅ Testes Finais

1. **Instalação Manual**
   ```bash
   # Copie o plugin para o diretório de plugins
   xcopy /E /I "com.windowcycle.streamdock.sdPlugin" "%APPDATA%\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"

   # Reinicie StreamDock
   taskkill /F /IM "Stream Dock AJAZZ.exe"
   ```

2. **Testes Funcionais**
   - [ ] WindowCycle funciona com knob
   - [ ] Clock exibe corretamente com todas as fontes
   - [ ] Webhook Clock dispara (Discord/IFTTT)
   - [ ] Webhook Knob funciona nas 3 direções
   - [ ] Property Inspectors abrem e salvam configurações
   - [ ] Todas as ações aparecem no StreamDock

3. **Testes de Estabilidade**
   - [ ] Plugin não trava após 1 hora de uso
   - [ ] Webhooks não causam lentidão
   - [ ] Memória não vaza (use Task Manager)
   - [ ] Logs não mostram erros repetidos

## 📦 Criar Pacote de Distribuição

### Opção 1: Arquivo .streamDockPlugin (Recomendado)

```bash
cd "d:\Projetos\Space Plugin\WindowCycle-Dev"

# Crie arquivo tar.gz com extensão .streamDockPlugin
tar -czf com.windowcycle.streamdock.streamDockPlugin -C com.windowcycle.streamdock.sdPlugin .
```

O arquivo resultante pode ser instalado com duplo-clique.

### Opção 2: Arquivo ZIP

```bash
# Crie um ZIP da pasta do plugin
cd "d:\Projetos\Space Plugin\WindowCycle-Dev"
powershell Compress-Archive -Path "com.windowcycle.streamdock.sdPlugin\*" -DestinationPath "WindowCycleUtils-v1.0.0.zip"
```

## 🌐 Publicação no Marketplace

### Marketplace Oficial StreamDock/HotSpot

**⚠️ Importante:** StreamDock é desenvolvido pela empresa **HotSpot** (chinesa). O processo de submissão pode variar.

#### Opção A: Portal de Desenvolvedor (se existir)

1. Acesse o portal de desenvolvedores do StreamDock/HotSpot
2. Crie uma conta de desenvolvedor
3. Clique em "Submit Plugin" ou "Novo Plugin"
4. Preencha o formulário:
   - **Nome:** WindowCycle Utils
   - **Categoria:** System Tools
   - **Descrição:** Copie do README.md
   - **Versão:** 1.0.0
   - **Screenshots:** Tire prints das 3 ações funcionando
   - **Arquivo:** Upload do `.streamDockPlugin`

#### Opção B: Contato Direto

Se não houver portal público:

1. **Email de Suporte:**
   - Procure no site oficial do StreamDock
   - Geralmente: `support@hotspot.com` ou `developer@streamdock.com`

2. **Template de Email:**
   ```
   Assunto: Plugin Submission - WindowCycle Utils v1.0.0

   Hello StreamDock Team,

   I would like to submit my plugin "WindowCycle Utils" to the StreamDock marketplace.

   Plugin Details:
   - Name: WindowCycle Utils
   - Version: 1.0.0
   - Author: Dudu Lima
   - Category: System Tools
   - Description: Multi-functional plugin with Window Cycle (Alt+Tab), Advanced Clock (13 fonts, webhooks), and Webhook Knob

   Features:
   - Window Cycle: Navigate windows with knob rotation
   - Clock Enhanced: 13 fonts, custom formats, webhook integration (Discord/IFTTT)
   - Webhook Knob: Trigger 3 webhooks with rotation/press

   GitHub: https://github.com/dudulima0312/StreamDock-Utils

   Attached: .streamDockPlugin file

   Please let me know the next steps for publication.

   Best regards,
   Dudu Lima
   ```

3. **Anexos:**
   - `com.windowcycle.streamdock.streamDockPlugin`
   - Screenshots (3-5 imagens)
   - README.txt (em inglês)

## 📸 Screenshots Necessários

Tire capturas de tela mostrando:

1. **WindowCycle em ação** - Task View aberto com knob
2. **Clock Enhanced** - Diferentes modos e fontes
3. **Property Inspector** - UI de configuração do Clock
4. **Webhook funcionando** - Mensagem no Discord
5. **Todas as 3 ações** - No StreamDock

**Dimensões recomendadas:** 1920x1080 ou 1280x720

## 🚀 GitHub Release

Crie uma release no GitHub para distribuição alternativa:

```bash
cd "d:\Projetos\Space Plugin\WindowCycle-Dev"

# Commit manifest atualizado
git add com.windowcycle.streamdock.sdPlugin/manifest.json
git commit -m "docs: update manifest for marketplace submission"
git push

# Crie tag de versão
git tag -a v1.0.0 -m "Release v1.0.0 - Initial marketplace submission"
git push origin v1.0.0
```

Depois, no GitHub:

1. Vá em **Releases** → **Create new release**
2. Escolha tag `v1.0.0`
3. Título: **WindowCycle Utils v1.0.0**
4. Descrição:
   ```markdown
   # WindowCycle Utils v1.0.0

   First official release! 🎉

   ## Features
   - **Window Cycle**: Navigate windows with knob (Alt+Tab)
   - **Clock Enhanced**: 13 fonts, custom formats, webhooks
   - **Webhook Knob**: 3 webhook triggers

   ## Installation
   1. Download `com.windowcycle.streamdock.streamDockPlugin`
   2. Double-click to install
   3. Restart StreamDock

   ## Documentation
   See [README.md](https://github.com/dudulima0312/StreamDock-Utils) for full docs
   ```
5. Upload `com.windowcycle.streamdock.streamDockPlugin`
6. Publish release

## 📱 Marketplace Alternativo

Se StreamDock não tiver marketplace público, considere:

### 1. **GitHub Releases** (Recomendado)
- ✅ Fácil de manter
- ✅ Controle de versão
- ✅ Download direto
- ✅ Comunidade pode contribuir

### 2. **Gumroad / Itch.io**
- Plataformas de distribuição digital
- Pode cobrar ou distribuir grátis
- Analytics de downloads

### 3. **Reddit / Discord**
- Comunidades de StreamDock
- r/StreamDeck (similar)
- Grupos de Discord

## 🔄 Atualizações Futuras

Para publicar atualizações:

1. Aumente a versão no `manifest.json`:
   ```json
   "Version": "1.1.0"
   ```

2. Compile novamente:
   ```bash
   py -m PyInstaller WindowCycle.spec --noconfirm
   force_update_plugin.bat
   ```

3. Crie novo pacote:
   ```bash
   tar -czf com.windowcycle.streamdock.streamDockPlugin -C com.windowcycle.streamdock.sdPlugin .
   ```

4. Submeta no marketplace ou crie nova release no GitHub

## 📊 Analytics e Feedback

Após publicar:

- **GitHub Issues**: Para bug reports
- **GitHub Discussions**: Para perguntas
- **GitHub Stars**: Métrica de popularidade
- **Watch releases**: Usuários podem acompanhar updates

## 🎯 Marketing do Plugin

Promova seu plugin em:

1. **Reddit**
   - r/StreamDeck
   - r/Productivity
   - Subreddits de automação

2. **YouTube**
   - Faça um video demonstrativo
   - Tutorial de uso
   - "Top StreamDock Plugins"

3. **Twitter / X**
   - Tweet com GIF/video
   - Use hashtags: #StreamDock #Productivity

4. **Discord**
   - Servidores de StreamDock
   - Comunidades de automação

## 📝 Changelog

Mantenha um CHANGELOG.md:

```markdown
# Changelog

## [1.0.0] - 2025-11-01

### Added
- Window Cycle: Task View navigation with knob
- Clock Enhanced: 13 fonts, custom formats
- Clock: Webhook integration (Discord/IFTTT)
- Clock: AM/PM dot indicator
- Clock: Two-line display mode
- Webhook Knob: 3 webhook triggers

### Technical
- Python 3.13 + PyInstaller
- PIL/Pillow for rendering
- WebSocket communication
- Threading for webhooks
```

## 🆘 Suporte

Se tiver dúvidas sobre publicação:

1. **Documentação StreamDock SDK**
2. **Fórum de desenvolvedores** (se existir)
3. **Email de suporte HotSpot**
4. **Comunidades de desenvolvedores**

---

**Boa sorte com a publicação! 🚀**

Se precisar de ajuda, abra uma issue no GitHub:
https://github.com/dudulima0312/StreamDock-Utils/issues
