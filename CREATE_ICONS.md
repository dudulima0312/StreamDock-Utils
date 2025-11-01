# Ícones Necessários para o Plugin WindowCycle

Para o plugin funcionar corretamente, você precisa criar os seguintes ícones:

## Arquivos de Ícone Necessários

1. **window-icon.png** (144x144px)
   - Ícone principal do plugin
   - Usado no estado normal do botão
   - Localização: `static/img/window-icon.png`

2. **window-icon-active.png** (144x144px)
   - Ícone quando uma janela está ativa
   - Usado no estado ativo do botão
   - Localização: `static/img/window-icon-active.png`

3. **window-icon.ico** (opcional)
   - Ícone do executável Windows
   - Formato ICO com múltiplas resoluções
   - Localização: `static/img/window-icon.ico`

## Sugestões de Design

### Ícone Normal (window-icon.png)
- Fundo: Cinza escuro (#2D3142)
- Símbolo: Duas janelas sobrepostas em cinza claro
- Borda: Sutil, cinza médio

### Ícone Ativo (window-icon-active.png)
- Fundo: Azul (#5865F2)
- Símbolo: Duas janelas sobrepostas em branco
- Borda: Azul mais escuro
- Pode incluir um efeito de brilho

## Ferramentas Recomendadas

- **Figma** - Design profissional gratuito
- **Canva** - Templates prontos
- **GIMP** - Editor gratuito de imagens
- **Paint.NET** - Simples e eficaz para Windows

## Criação Rápida com Python

Se preferir, você pode usar o script Python abaixo para criar ícones básicos:

```python
from PIL import Image, ImageDraw

# Criar ícone normal
img = Image.new('RGBA', (144, 144), color=(45, 49, 66, 255))
draw = ImageDraw.Draw(img)

# Desenhar janela de fundo
draw.rectangle((30, 40, 90, 100), outline=(150, 150, 150, 255), width=2)
draw.rectangle((30, 40, 90, 50), fill=(150, 150, 150, 255))

# Desenhar janela da frente
draw.rectangle((54, 54, 114, 114), outline=(200, 200, 200, 255), width=2)
draw.rectangle((54, 54, 114, 64), fill=(200, 200, 200, 255))

img.save('static/img/window-icon.png')

# Criar ícone ativo
img_active = Image.new('RGBA', (144, 144), color=(88, 101, 242, 255))
draw = ImageDraw.Draw(img_active)

# Desenhar janela de fundo
draw.rectangle((30, 40, 90, 100), outline=(255, 255, 255, 200), width=2)
draw.rectangle((30, 40, 90, 50), fill=(255, 255, 255, 200))

# Desenhar janela da frente
draw.rectangle((54, 54, 114, 114), outline=(255, 255, 255, 255), width=2)
draw.rectangle((54, 54, 114, 64), fill=(255, 255, 255, 255))

img_active.save('static/img/window-icon-active.png')

print("Ícones criados com sucesso!")
```

## Recursos Online

- **IconFinder**: https://www.iconfinder.com/search?q=window
- **FlatIcon**: https://www.flaticon.com/search?word=window
- **Icons8**: https://icons8.com/icons/set/window

Lembre-se: Os ícones devem ser claros e legíveis mesmo em tamanho pequeno no Stream Deck!