# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Source aliases
if [ -f ~/.alias ]; then
    . ~/.alias
fi

if [ $(id -u) -eq 0 ]
then
  PS1="[\u@\h \w]# "
else
  PS1="[\u@\h \w]\$ "
fi
