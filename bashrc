# File              : Bash Config
# File Position     : ~/.bashrc
# Bash Position     : 5.8.1
# Reference         : man bash

# Alias
alias up="paru"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias grep="rg"
alias cat="bat"
alias update-config="clear && source ~/.bashrc"
alias ls='exa -al --color=always --group-directories-first'
alias neofetch="fm6000 -c=cyan -asok -n -l 25"
alias less="bat"
alias find="fd"
alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"
alias mpv="/usr/bin/devour /usr/bin/mpv"
alias zathura="/usr/bin/devour /usr/bin/zathura"
alias emacsclient="/usr/bin/devour /usr/bin/emacsclient"

# Exports
export EDITOR="vim"
export TERMINAL="alacritty"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESSHSITFILE=-
export SHELL="/bin/bash"
# Prompt
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# Autostart
fm6000 -c=cyan -asok -n -l 25
echo -ne '\e[5 q'
