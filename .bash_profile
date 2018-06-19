# export CLICOLOR=1
# export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

if [ -f ~/.alias ]; then
    . ~/.alias
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# export PS1="\[\033[38;5;1m\]\u\[$(tput sgr0)\]\[\033[38;5;2m\]@\h\[$(tput sgr0)\]\[\033[38;5;15m\]:\[$(tput sgr0)\]\[\033[38;5;4m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ \[$(tput sgr0)\]"
