# p10k即时提示功能
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt SHARE_HISTORY         # 多终端实时共享历史
setopt AUTO_CD               # 直接输入目录路径时自动 cd 过去
setopt HIST_IGNORE_ALL_DUPS  # 忽略所有重复记录（包括连续和非连续）
# setopt HIST_IGNORE_DUPS      # 仅忽略连续的重复记录
setopt HIST_EXPIRE_DUPS_FIRST  # 当历史文件满时，优先删除重复记录
# setopt HIST_FIND_NO_DUPS     # 在历史搜索中不显示重复项
#
# 内存中保留多少条
HISTSIZE=500000
#写入历史文件多少条
SAVEHIST=500000

export EDITOR='nvim'

# zinit 自举安装
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [ ! -f "$ZINIT_HOME/zinit.zsh" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone --depth=1 --single-branch https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

# zsh-vi-mode 需最先加载，fzf 绑定在 zvm_after_init 里完成
function zvm_after_init() {
  if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
  elif command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
  fi
  # 上下键按前缀搜索历史，光标保持在末尾
  autoload -U up-line-or-beginning-search down-line-or-beginning-search
  zle -N up-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey '^[[A' up-line-or-beginning-search
  bindkey '^[[B' down-line-or-beginning-search
 }

# vim normal下的/绑定为fzf历史搜索
function zvm_after_lazy_keybindings() {
  if (( ${+widgets[fzf-history-widget]} )); then
    bindkey -M vicmd '/' fzf-history-widget
  fi
}

# 补全系统初始化
zmodload zsh/complist
autoload -Uz compinit
compinit -C
zstyle ':completion:*' menu select


# 插件安装
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions
# zsh-syntax-highlighting 需放在最后
zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting


# yazi配置
function f() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# 别名
alias less="less -N"
alias v="nvim"
alias vimdiff="v -d"
alias fzfv="v \`fzf\`"
alias t="tmux attach -t 1994 || tmux new -s 1994"
alias gst="git status"
alias gc="git commit"
alias gcm="git commit -m"
alias gs="git switch"
alias gf="git fetch --prune"
alias gl="git pull --prune"
alias gp="git push"
alias ll="ls -l"
alias aria="aria2c"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# fnm（node 版本管理）
if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd)"
fi

# powerlevel10k
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# zoxide
if command -v zoxide >/dev/null 2>&1; then
  # linux的zoxide版本配置zi，会和zinit冲突
  unalias zi 2>/dev/null
  eval "$(zoxide init zsh)"
fi

# Added by coco installer
export PATH="/Users/xuekai/.local/bin:$PATH"
