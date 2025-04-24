#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------
# install.sh — replicável e não interativo
# ----------------------------------

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🔄 Iniciando instalação dos dotfiles..."

# 1) Oh My Zsh
if [ ! -d "${HOME}/.oh-my-zsh" ]; then
  echo "📥 Instalando Oh My Zsh..."
  git clone https://github.com/ohmyzsh/ohmyzsh.git "${HOME}/.oh-my-zsh"
else
  echo "✅ Oh My Zsh já está instalado."
fi

# 2) Powerlevel10k
P10K_CUSTOM="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "${P10K_CUSTOM}" ]; then
  echo "📥 Instalando Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${P10K_CUSTOM}"
else
  echo "✅ Powerlevel10k já está instalado."
fi

# 3) MesloLGS NF (Nerd Fonts)
echo "🔤 Instalando fontes MesloLGS NF..."
FONT_DIR="${HOME}/.local/share/fonts"
mkdir -p "${FONT_DIR}"
pushd "${FONT_DIR}" > /dev/null

declare -a STYLES=(Regular Bold Italic "Bold Italic")
for style in "${STYLES[@]}"; do
  file="MesloLGS NF ${style}.ttf"
  url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/L/${style}/${file// /%20}"
  if [ ! -f "${file}" ]; then
    curl -fLo "${file}" "${url}"
  fi
done

fc-cache -fv > /dev/null
popd > /dev/null
echo "✅ Fontes instaladas."

# 4) Symlinks dos dotfiles
echo "🔗 Criando links simbólicos dos dotfiles..."
# ZSH
ln -sf "${DOTFILES_DIR}/.zshrc" "${HOME}/.zshrc"
ln -sf "${DOTFILES_DIR}/.p10k.zsh" "${HOME}/.p10k.zsh"
# TMUX
mkdir -p "${HOME}/.config/tmux"
ln -sf "${DOTFILES_DIR}/.config/tmux/tmux.conf" "${HOME}/.config/tmux/tmux.conf"

# 5) Ajustes no .zshrc
echo "✍️  Ajustando configurações do .zshrc..."
# Define o tema powerlevel10k
if grep -q '^ZSH_THEME=' "${HOME}/.zshrc"; then
  sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "${HOME}/.zshrc"
else
  echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "${HOME}/.zshrc"
fi
# Garante o carregamento do seu .p10k.zsh
if ! grep -q 'source ~\/\.p10k\.zsh' "${HOME}/.zshrc"; then
  echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> "${HOME}/.zshrc"
fi

echo "🎉 Instalação completa! Abra um novo terminal para ver o Powerlevel10k no ar."

# 6) Aliases úteis para Python, venv e Django
echo "⚙️  Adicionando aliases úteis ao .zshrc..."

ALIASES_BLOCK="
# --- Aliases customizados ---
alias python='python3'
alias pip='python3 -m pip'
alias venv-create='python3 -m venv .venv'
alias venv-activate='source .venv/bin/activate'
alias venv-deactivate='deactivate'
alias dj='python manage.py'
alias djrun='python manage.py runserver'
alias djm='python manage.py makemigrations'
alias dja='python manage.py migrate'
alias djs='python manage.py shell'
alias djcsu='python manage.py createsuperuser'
"

if ! grep -q "Aliases customizados" "${HOME}/.zshrc"; then
  echo "${ALIASES_BLOCK}" >> "${HOME}/.zshrc"
  echo "✅ Aliases adicionados ao .zshrc"
else
  echo "⚠️  Aliases já presentes no .zshrc, pulando..."
fi

echo "🛠️ Instalando AstroVim personalizado..."

# 1) Dependências
echo "📦 Instalando dependências do sistema (pacman)..."
sudo pacman -S --needed --noconfirm \
  neovim git curl ripgrep fd unzip tar xz gcc make \
  nodejs npm python python-pip

# 2) Pynvim para suporte Python
echo "🐍 Instalando pynvim com pip..."
pip install --user pynvim

# 3) Clonando seu AstroVim
ASTROVIM_DIR="$HOME/.config/nvim"
if [ -d "$ASTROVIM_DIR" ]; then
  echo "⚠️  Diretório ~/.config/nvim já existe, pulando clone."
else
  echo "📥 Clonando AstroVim do seu repositório..."
  git clone https://github.com/Rodrigo160731/AstroVim.git "$ASTROVIM_DIR"
fi

# 4) Executa o Neovim para instalar tudo
echo "🚀 Rodando Neovim pela primeira vez para instalar plugins..."
nvim --headless "+Lazy! sync" +qa

echo "✅ AstroVim instalado com sucesso!"

# 7) Instalação e configuração do tmux
echo "🧩 Instalando e configurando tmux..."

# Instala o tmux se ainda não estiver instalado
if ! command -v tmux >/dev/null 2>&1; then
  echo "📦 Instalando tmux..."
  sudo pacman -S --needed --noconfirm tmux
else
  echo "✅ tmux já está instalado."
fi

# Link do arquivo de configuração
TMUX_CONFIG_DIR="${HOME}/.config/tmux"
mkdir -p "${TMUX_CONFIG_DIR}"

echo "🔗 Criando link simbólico para o .tmux.conf..."
ln -sf "${DOTFILES_DIR}/.config/tmux/.tmux.conf" "${TMUX_CONFIG_DIR}/.tmux.conf"

echo "✅ Configuração do tmux finalizada."

# 8) Tmux Plugin Manager (TPM)
echo "📦 Instalando TPM (Tmux Plugin Manager)..."
TPM_DIR="${HOME}/.config/tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "✅ TPM já instalado."
  echo "OBS: Entre no tmux e rode ´run '~/.config/tmux/plugins/tpm/tpm'´"
fi

# echo "📁 Criando pastas padrão de projetos..."
# mkdir -p ~/Projects/Python ~/Projects/Web ~/Projects/Scripts

# 9) Ferramentas CLI úteis
echo "📦 Instalando ferramentas úteis para CLI..."

# Lista de ferramentas que queremos instalar
TOOLS=(
  "exa"        # Alternativa moderna ao ls
  "bat"        # Cat com sintaxe colorida
  "btop"       # Monitor de sistema
  "htop"       # Monitor de sistema interativo
  "ranger"     # Gerenciador de arquivos no terminal
  "fzf"        # Ferramenta de busca interativa
  "jq"         # Ferramenta para manipulação de JSON
)

# Instalando as ferramentas
for TOOL in "${TOOLS[@]}"; do
  if ! command -v "$TOOL" &>/dev/null; then
    echo "📥 Instalando $TOOL..."
    sudo pacman -S --needed --noconfirm "$TOOL"
  else
    echo "✅ $TOOL já está instalado."
  fi
done

echo "✅ Ferramentas CLI instaladas com sucesso."





echo "🧪 Testando setup..."
nvim --version
tmux -V
zsh --version
python3 --version
