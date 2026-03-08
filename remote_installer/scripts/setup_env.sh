#!/bin/bash

set -e

echo "🚀 Starting Linux development environment setup..."

# Update package manager
echo "📦 Updating package manager..."
if command -v apt-get &> /dev/null; then
    apt-get update
else
    echo "❌ Unsupported package manager. Please install packages manually."
    exit 1
fi

# Install essential packages
echo "📦 Installing essential packages..."
apt-get install -y zsh neovim zoxide


# 克隆zsh插件
rm -rf ~/.zsh
git clone --depth 1 --single-branch https://github.com/jeffreytse/zsh-vi-mode ~/.zsh/plugins/zsh-vi-mode
git clone --depth 1 --single-branch https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
git clone --depth 1 --single-branch https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/plugins/zsh-syntax-highlighting


# Set zsh as default shell
echo "🐚 Setting zsh as default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
    echo "Please log out and log back in for the shell change to take effect."
fi



cat > ~/.zshrc << 'EOF'
# 配置prompt
PROMPT='%F{cyan}%~%f %# '
# 配置历史
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS  # 忽略所有重复记录（包括连续和非连续）
# setopt HIST_IGNORE_DUPS      # 仅忽略连续的重复记录
setopt HIST_EXPIRE_DUPS_FIRST  # 当历史文件满时，优先删除重复记录
# setopt HIST_FIND_NO_DUPS     # 在历史搜索中不显示重复项

BASH_PROFILE=~/.bash_profile
if [ -f "$BASH_PROFILE" ]; then
	source $BASH_PROFILE
fi

# 生效z
eval "$(zoxide init zsh)"

# 生效几个插件
source ~/.zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias v="nvim"
alias vim="nvim"
alias vimdiff="v -d"
alias vi="nvim"
alias ov="/usr/bin/vim"

# 使用nvim作为编辑工具
export EDITOR='nvim'


# 前缀匹配历史
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

bindkey -M viins '^[[A' up-line-or-beginning-search
bindkey -M viins '^[[B' down-line-or-beginning-search
bindkey -M viins '^[OA' up-line-or-beginning-search
bindkey -M viins '^[OB' down-line-or-beginning-search

bindkey -M vicmd '^[[A' up-line-or-beginning-search
bindkey -M vicmd '^[[B' down-line-or-beginning-search
bindkey -M vicmd '^[OA' up-line-or-beginning-search
bindkey -M vicmd '^[OB' down-line-or-beginning-search


# 补全列表可交互
zmodload zsh/complist
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' file-sort name
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

EOF




# 简单配置nvim
echo "📝 Setting up basic nvim configuration..."
mkdir -p ~/.config/nvim

cat > ~/.config/nvim/init.lua << 'EOF'
-- Basic Neovim configuration
vim.opt.number = true
vim.opt.mouse = ""
EOF


echo "安装成功"
# 把需要立即生效到配置写到/tmp/env中
write_env_sync_file() {
cat > "/tmp/env" <<'EOF'
zsh
EOF
}
write_env_sync_file

