brew install iterm2
git@github.com:94kai/dotconfig.git

# ================neovim相关
ln -s ~/project/dotconfig/nvim ~/.config/nvim

# 启动neovim，等待Lazy克隆成功后，关闭重启启动即可

# 安装字体补丁(Noto Nerd Font)
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
# Perferences->Profiles->Text->Font


# LSP/Format/DAP通过Mason按需安装


# ================zsh相关
sh -c "$(curl -fsSL https://install.ohmyz.sh)"
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
ln -s ~/project/dotconfig/zshrc ~/.zshrc


# ================tmux相关
ln -s ~/project/dotconfig/tmux.conf ~/.tmux.conf
# 克隆tmux的插件管理器
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# 重启tmux
# Ctrl-s shift-I 安装tmux插件


# ================ideavim相关
ln -s ~/project/dotconfig/ideavimrc ~/.ideavimrc
