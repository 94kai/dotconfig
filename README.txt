brew install iterm2
git@github.com:94kai/dotconfig.git

# ================neovim相关
ln -s ~/project/dotconfig/nvim ~/.config/nvim
# 注释掉init.lua中插件的加载，保证lazy库先clone成功，然后再解开注释

# 安装字体补丁(Noto Nerd Font)
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
# Perferences->Profiles->Text->Font

# 安装im-select
brew tap daipeihust/tap
brew install im-select

# LSP/Format/DAP通过Mason按需安装


# ================zsh相关
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
ln -s ~/project/dotconfig/zshrc ~/.zshrc


# ================tmux相关
ln -s ~/project/dotconfig/tmux.conf ~/.tmux.conf
# 克隆tmux的插件管理器
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# 重启tmux
# Ctrl-s shift-I 安装tmux插件


ln -s ~/project/dotconfig/ideavim.vim ~/.ideavim.vim
