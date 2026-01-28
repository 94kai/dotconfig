brew install iterm2
git@github.com:94kai/dotconfig.git


# ================wezterm
ln -s ~/project/dotconfig/wezterm ~/.config/wezterm
# ================neovim相关
ln -s ~/project/dotconfig/nvim ~/.config/nvim

# 启动neovim，等待Lazy克隆成功后，关闭重启启动即可

# 安装字体补丁(Noto Nerd Font)
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
# Perferences->Profiles->Text->Font


# LSP/Format/DAP通过Mason按需安装
# ================格式化相关
# 格式化json,需要先安装prettier。基于node。先去node官网安装node，然后`npm install -g prettier` 安装全局prettier。使用FJson命令格式化json
# 格式化python,需要先安装autopep8。linux优先用'apt install python3-autopep8',mac可以用pip3 install autopep8。使用FPython命令格式化python



# ================zsh相关
sh -c "$(curl -fsSL https://install.ohmyz.sh)"
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
ln -s ~/project/dotconfig/zshrc ~/.zshrc


# ================tmux相关
ln -s ~/project/dotconfig/tmux.conf ~/.tmux.conf
# 克隆tmux的插件管理器
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# 重启tmux
# Ctrl-s shift-I 安装tmux插件
> linux上显示有问题，tmux可以切换到linux分支


# ================ideavim相关
ln -s ~/project/dotconfig/ideavimrc ~/.ideavimrc


# ================按键映射
- caps单独按esc，组合按Ctrl
	- linux
		- sudo apt install interception-tools interception-caps2esc
		- 创建/etc/interception/udevmon.d/udevmon.yaml
			- 添加如下配置
			```
			- JOB: interception -g $DEVNODE | caps2esc | uinput -d $DEVNODE
			  DEVICE:
				EVENTS:
				  EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
			```
		- sudo systemctl restart udevmon

# ================三指拖动
https://github.com/ferstar/gestures/releases
```
	; 登陆前启动肯定会失败，所以需要设置自动重启
	[Unit]
	Description=三指拖拽，注意需要配置一些环境变量，否则service中跑这个程序会有各种bug
	StartLimitIntervalSec=0

	[Service]

	Environment=XAUTHORITY=/run/user/1000/gdm/Xauthority
	Environment=DISPLAY=:0
	Environment=HOME=/home/xuekai
	Type=simple
	ExecStart=/home/xuekai/.local/bin/gestures-amd64-linux
	Restart=always
	RestartSec=1

	[Install]
	WantedBy=default.target
```
