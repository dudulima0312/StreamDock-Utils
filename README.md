# WindowCycle StreamDock Plugin 🎮

Plugin multifuncional para StreamDock com três ações principais: WindowCycle (Task View), Clock avançado e Webhook Knob.

## 📋 Índice

- [Funcionalidades](#-funcionalidades)
- [Instalação](#-instalação)
- [Ações Disponíveis](#-ações-disponíveis)
  - [WindowCycle](#1-windowcycle---task-view-com-knob)
  - [Clock Enhanced](#2-clock-enhanced)
  - [Webhook Knob](#3-webhook-knob)
- [Desenvolvimento](#-desenvolvimento)
- [Build e Deploy](#-build-e-deploy)
- [Backup e Rollback](#-backup-e-rollback)

## ✨ Funcionalidades

### 1. WindowCycle - Task View com Knob

Navegação intuitiva entre janelas abertas usando o knob rotativo do StreamDock.

**Características:**
- 🔄 Gire o knob para abrir Task View e navegar entre janelas
- ⌨️ Simula Alt+Tab automaticamente
- 🎯 Auto-release inteligente do Alt
- ⚙️ Sensibilidade ajustável
- 🔀 Direção reversível
- 👆 Pressione o knob para confirmar seleção

**Configurações:**
- **Sensitivity**: Quantos "ticks" do knob para cada navegação (1-10)
- **Reverse Direction**: Inverte direção de rotação
- **Release Delay**: Tempo antes de soltar Alt automaticamente (ms)

### 2. Clock Enhanced

Relógio altamente customizável com múltiplos modos de exibição e integração com webhooks.

#### 🎨 Modos de Display

1. **Time (HH:MM)** - Hora padrão
2. **Hour Only (HH)** - Apenas hora
3. **Minute Only (MM)** - Apenas minutos
4. **Date (DD/MM)** - Data
5. **Time & Date (Two Lines)** - Hora e data em duas linhas
6. **Custom Format** - Formato totalmente customizável

#### 🔤 Formato Customizado

Use códigos intuitivos para criar seu próprio formato:

| Código | Descrição | Exemplo |
|--------|-----------|---------|
| `HH` | Hora 24h | 23 |
| `hh` | Hora 12h | 11 |
| `mm` | Minutos | 45 |
| `ss` | Segundos | 30 |
| `dd` | Dia | 15 |
| `MM` | Mês | 03 |
| `yyyy` | Ano completo | 2025 |
| `yy` | Ano curto | 25 |
| `AA` | Dia da semana completo | Monday |
| `aa` | Dia da semana abreviado | Mon |
| `BB` | Mês completo | January |
| `bb` | Mês abreviado | Jan |

**Exemplos:**
- `HH:mm:ss` → 23:45:30
- `dd/MM/yyyy` → 15/03/2025
- `HH:mm dd/MM` → 23:45 15/03
- `hh:mm aa` → 11:45 PM

#### 🎨 Fontes Disponíveis

**Fontes Modernas:**
- Doto (Modern)
- Sofia Sans (Condensed)
- Stint Ultra (Ultra Condensed)
- Coral Pixels (Pixel Art)
- Workbench

**Fontes Especializadas em Números:**
- Numbers Claimcheck
- Numbers Deuce
- Numbers Greenback
- Numbers Premium
- Numbers Redbird
- Numbers Revenue
- Numbers Valuta Open

**Fontes do Sistema:**
- Arial
- Segoe UI

#### ⚙️ Configurações Visuais

- **Font Size**: 12-60px
- **Bold**: Texto em negrito
- **Text Color**: Cor do texto (picker)
- **Background Color**: Cor de fundo (picker)
- **Outline Width**: Contorno do texto (0-5px)
- **Outline Color**: Cor do contorno
- **Horizontal/Vertical Offset**: Ajuste fino de posição (-20 a +20px)

#### 🌙 Indicador AM/PM

- Ponto discreto no canto superior direito
- Aparece apenas durante horas PM (12:00-23:59)
- Mesma cor do texto para consistência visual
- Opcional (pode ser desativado)

#### 🔗 Integração com Webhooks

Dispare webhooks ao clicar no relógio!

**Suporte Especial para:**
- ✅ Discord Webhooks (formato automático)
- ✅ IFTTT
- ✅ Qualquer webhook genérico

**Configurações:**
- **Webhook URL**: URL completa do webhook
- **Request Timeout**: Tempo limite da requisição (1-30s)

**Payload Discord:**
```json
{
  "content": "⏰ Clock clicked! Mode: time | Time: 23:45:30"
}
```

**Payload Genérico:**
```json
{
  "action": "clock_click",
  "mode": "time",
  "timestamp": "2025-11-01T23:45:30"
}
```

### 3. Webhook Knob

Dispare até 3 webhooks diferentes com um único knob rotativo.

**Ações:**
- 🔄 **Girar Esquerda** → Webhook 1
- 🔄 **Girar Direita** → Webhook 2
- 👆 **Pressionar Centro** → Webhook 3

**Configurações:**
- **Rotate Left Webhook**: URL para rotação anti-horária
- **Rotate Right Webhook**: URL para rotação horária
- **Click Webhook**: URL para pressão do botão
- **Timeout**: Tempo limite das requisições (1-30s)

**Payload Enviado:**
```json
{
  "action": "left|right|click",
  "timestamp": "2025-11-01T23:45:30"
}
```

**Feedback Visual:**
- ✓ Checkmark verde em caso de sucesso
- ⚠ Alerta vermelho em caso de erro

## 📦 Instalação

### Método 1: Plugin Pré-compilado

1. Baixe o arquivo `.streamDockPlugin` da [página de releases](https://github.com/dudulima0312/StreamDock-Utils/releases)
2. Dê duplo clique no arquivo
3. StreamDock instalará automaticamente

### Método 2: Instalação Manual

1. Clone o repositório:
```bash
git clone https://github.com/dudulima0312/StreamDock-Utils.git
cd StreamDock-Utils/WindowCycle-Dev
```

2. Copie a pasta do plugin para StreamDock:
```bash
xcopy /E /I "com.windowcycle.streamdock.sdPlugin" "C:\Users\%USERNAME%\AppData\Roaming\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin"
```

3. Reinicie o StreamDock

## 🛠 Desenvolvimento

### Pré-requisitos

- Python 3.13+
- PyInstaller
- Dependências do `requirements.txt`

### Setup do Ambiente

1. Crie ambiente virtual:
```bash
python -m venv venv
venv\Scripts\activate
```

2. Instale dependências:
```bash
pip install -r requirements.txt
```

### Estrutura do Projeto

```
WindowCycle-Dev/
├── src/
│   ├── core/                    # Núcleo do framework
│   │   ├── plugin.py           # Gerenciador WebSocket
│   │   ├── action.py           # Classe base Action
│   │   ├── action_factory.py   # Factory de ações
│   │   ├── timer.py            # Sistema de timers
│   │   └── logger.py           # Sistema de logs
│   └── actions/                # Implementações de ações
│       ├── window_cycle.py     # WindowCycle/Task View
│       ├── clock.py            # Clock Enhanced
│       └── webhook_knob.py     # Webhook Knob
├── com.windowcycle.streamdock.sdPlugin/  # Pacote do plugin
│   ├── manifest.json           # Configuração do plugin
│   ├── propertyInspector/      # UIs de configuração
│   │   ├── clock/
│   │   │   └── index.html      # UI do Clock
│   │   └── webhook_knob/
│   │       └── index.html      # UI do Webhook Knob
│   ├── static/                 # Recursos estáticos
│   │   ├── img/               # Ícones das ações
│   │   └── fonts/             # Fontes customizadas
│   └── WindowCycle.exe         # Executável do plugin
├── fonts/                      # Fontes TTF
├── WindowCycle.spec           # Configuração PyInstaller
├── main.py                    # Entry point
└── requirements.txt           # Dependências Python
```

### Criando uma Nova Ação

1. Crie arquivo em `src/actions/`:

```python
from src.core.action import Action
from src.core.logger import Logger

class MinhaAcao(Action):
    def __init__(self, action: str, context: str, settings: dict, plugin):
        super().__init__(action, context, settings, plugin)
        Logger.info(f"[MinhaAcao] Initialized")

    def on_key_down(self, payload: dict):
        """Chamado quando botão é pressionado"""
        Logger.info("[MinhaAcao] Button pressed")
        self.show_ok()

    def on_will_appear(self, payload: dict):
        """Chamado quando ação aparece no StreamDock"""
        settings = payload.get('settings', {})
        self.settings.update(settings)
```

2. Registre no `action_factory.py`:

```python
'com.windowcycle.streamdock.minha_acao': 'src.actions.minha_acao.MinhaAcao'
```

3. Adicione ao `manifest.json`:

```json
{
  "UUID": "com.windowcycle.streamdock.minha_acao",
  "Icon": "static/img/minha-acao-icon",
  "Name": "Minha Ação",
  "Tooltip": "Descrição da ação",
  "States": [
    {
      "Image": "static/img/minha-acao-icon"
    }
  ],
  "Controllers": ["Keypad"]
}
```

## 🔨 Build e Deploy

### Compilação

```bash
# Compile o executável
py -m PyInstaller WindowCycle.spec --noconfirm
```

### Deploy Rápido

Use o batch script fornecido:

```bash
# Fecha StreamDock, copia exe e abre novamente
force_update_plugin.bat
```

Ou manualmente:

```bash
# 1. Feche o StreamDock
taskkill /F /IM "Stream Dock AJAZZ.exe"

# 2. Copie o executável
copy /Y "dist\WindowCycle.exe" "com.windowcycle.streamdock.sdPlugin\WindowCycle.exe"
copy /Y "dist\WindowCycle.exe" "C:\Users\%USERNAME%\AppData\Roaming\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin\WindowCycle.exe"

# 3. Reabra o StreamDock
start "" "C:\Program Files\AJAZZ\Stream Dock AJAZZ\Stream Dock AJAZZ.exe"
```

### Atualização de Property Inspector

Se você modificou arquivos HTML/CSS/JS:

```bash
# Copie os arquivos para instalação do StreamDock
xcopy /E /Y "com.windowcycle.streamdock.sdPlugin\propertyInspector" "C:\Users\%USERNAME%\AppData\Roaming\HotSpot\StreamDock\plugins\com.windowcycle.streamdock.sdPlugin\propertyInspector"

# Mate o processo para forçar reload
taskkill /F /IM "Stream Dock AJAZZ.exe"
```

## 💾 Backup e Rollback

### Criando Backup

Backups são criados automaticamente antes de mudanças grandes:

```bash
# Formato: WindowCycle-Dev-BACKUP-YYYYMMDD_HHMMSS
WindowCycle-Dev-BACKUP-20251101_174554/
```

### Restaurando Backup

```bash
# 1. Pare o StreamDock
taskkill /F /IM "Stream Dock AJAZZ.exe"

# 2. Delete pasta atual
rmdir /S /Q "WindowCycle-Dev"

# 3. Renomeie backup
rename "WindowCycle-Dev-BACKUP-20251101_174554" "WindowCycle-Dev"

# 4. Recompile e deploy
cd WindowCycle-Dev
py -m PyInstaller WindowCycle.spec --noconfirm
force_update_plugin.bat
```

### Backups Disponíveis

- **20251101_174554** - Backup antes das melhorias do Clock v1.0-ENHANCED
  - Último estado estável antes de adicionar:
    - 7 novas fontes Numbers
    - Webhook no click
    - Formato customizado
    - Modo duas linhas
    - Indicador AM/PM dot

## 📝 Logs e Debugging

### Localização dos Logs

```
C:\Users\%USERNAME%\AppData\Roaming\HotSpot\StreamDock\logs\
```

### Monitoramento em Tempo Real

```bash
# PowerShell
Get-Content "C:\Users\$env:USERNAME\AppData\Roaming\HotSpot\StreamDock\logs\log-*.txt" -Tail 50 -Wait

# Git Bash
tail -f "C:/Users/$USERNAME/AppData/Roaming/HotSpot/StreamDock/logs/log-"*.txt
```

### Filtrando Erros

```bash
# Apenas erros e warnings
tail -f log-*.txt | grep -i -E "(error|exception|traceback|warning)"

# Apenas uma ação específica
tail -f log-*.txt | grep -i "clock"
```

## 🧪 Testing

### Testando Webhooks

**Discord:**
1. Crie webhook no Discord (Server Settings → Integrations → Webhooks)
2. Copie URL do webhook
3. Cole no campo "Webhook URL" da ação
4. Click/rotacione e verifique mensagem no Discord

**IFTTT:**
1. Crie Applet no IFTTT com trigger "Webhooks"
2. Use URL: `https://maker.ifttt.com/trigger/{event}/with/key/{key}`
3. Configure ação desejada
4. Teste no StreamDock

**Generic Webhook (Request Inspector):**
1. Use serviço como [webhook.site](https://webhook.site)
2. Copie URL única fornecida
3. Configure no plugin
4. Veja payload recebido em tempo real

## 🤝 Contribuindo

1. Fork o projeto
2. Crie branch para feature (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Add: Minha feature'`)
4. Push para branch (`git push origin feature/MinhaFeature`)
5. Abra Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja [LICENSE](LICENSE) para mais detalhes.

## 🐛 Bugs e Sugestões

Abra uma [issue](https://github.com/dudulima0312/StreamDock-Utils/issues) no GitHub.

## 📚 Recursos Adicionais

- [Documentação StreamDock SDK](https://streamdock.dev/docs)
- [PyInstaller Documentation](https://pyinstaller.org)
- [Pillow (PIL) Documentation](https://pillow.readthedocs.io)

## 🎉 Agradecimentos

- StreamDock/HotSpot pela plataforma
- Comunidade Python
- Todos os contribuidores

---

**Desenvolvido com ❤️ por [Dudu Lima](https://github.com/dudulima0312)**

**Versão:** 1.0-ENHANCED (November 2025)
