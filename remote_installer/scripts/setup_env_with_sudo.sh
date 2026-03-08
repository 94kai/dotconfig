#!/bin/bash

set -e

echo "🚀 Starting Linux development environment setup..."

# Update package manager
echo "📦 Updating package manager..."
if command -v apt-get &> /dev/null; then
    sudo apt-get update
else
    echo "❌ Unsupported package manager. Please install packages manually."
    exit 1
fi

# Install essential packages
echo "📦 Installing essential packages..."
sudo apt-get install -y zsh neovim

# Install oh-my-zsh
echo "🎨 Installing oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://install.ohmyz.sh)" "" --unattended
else
    echo "oh-my-zsh already installed, skipping..."
fi

git clone https://github.com/jeffreytse/zsh-vi-mode ~/.oh-my-zsh/plugins/zsh-vi-mode
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting


# Set zsh as default shell
echo "🐚 Setting zsh as default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    sudo chsh -s $(which zsh)
    echo "Please log out and log back in for the shell change to take effect."
fi

# Create basic nvim config
echo "📝 Setting up basic nvim configuration..."
mkdir -p ~/.config/nvim

cat > ~/.config/nvim/init.lua << 'EOF'
-- Basic Neovim configuration
vim.opt.number = true
vim.opt.mouse = ""
EOF


cat > ~/.zshrc << 'EOF'

setopt HIST_IGNORE_ALL_DUPS  # 忽略所有重复记录（包括连续和非连续）
# setopt HIST_IGNORE_DUPS      # 仅忽略连续的重复记录
setopt HIST_EXPIRE_DUPS_FIRST  # 当历史文件满时，优先删除重复记录
# setopt HIST_FIND_NO_DUPS     # 在历史搜索中不显示重复项

BASH_PROFILE=~/.bash_profile
if [ -f "$BASH_PROFILE" ]; then
	source $BASH_PROFILE
fi
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"


# 使用nvim作为编辑工具
export EDITOR='nvim'

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-vi-mode
	z
)

source $ZSH/oh-my-zsh.sh

alias v="nvim"
alias vim="nvim"
alias vimdiff="v -d"
alias vi="nvim"
alias ov="/usr/bin/vim"

EOF

echo "✅ Setup complete!"
echo ""
echo "📋 Summary:"
echo "  - Essential packages installed"
echo "  - oh-my-zsh installed"
echo "  - zsh set as default shell (restart required)"
echo "  - basic nvim configuration created"
echo "  - vim-plug installed for plugin management"
echo ""
echo "🎯 Next steps:"
echo "  1. Restart your terminal or log out/in"
echo "  2. Customize your ~/.zshrc"
echo "  3. Add plugins to ~/.config/nvim/init.lua"
echo "  4. Run :PlugInstall in nvim to install plugins"
