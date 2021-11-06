# File              : Zsh Config
# File Position     : ~/.zshrc
# Bash Position     : 5.8
# Reference         : man zsh

# Alias
alias up="paru"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias grep="rg"
alias cat="bat"
alias update-config="clear && source ~/.zshrc"
alias ls='exa -al --color=always --group-directories-first --icons'
alias mpv="/usr/bin/devour /usr/bin/mpv"
alias sxiv="/usr/bin/devour /usr/bin/sxiv "
alias less="bat"
alias find="fd"
alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"
alias mpv="/usr/bin/devour /usr/bin/mpv"
alias sxiv="/usr/bin/devour /usr/bin/sxiv "
alias zathura="/usr/bin/devour /usr/bin/zathura"

# Exports
export EDITOR="vim"
export TERMINAL="alacritty"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESSHSITFILE=-
export SHELL="/bin/zsh"

# Autostart
neofetch
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
zmodload zsh/complist
autoload -Uz compinit
compinit
echo -ne '\e[5 q'

# ZSH Settings
HISTFILE=~/.cache/histfile
HISTSIZE=1000
SAVEHIST=1000

zstyle :compinstall filename '/home/vivek/.zshrc'
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Key Bindings
bindkey -v
export KEYTIMEOUT=1
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char
bindkey "^?" backward-delete-char

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
