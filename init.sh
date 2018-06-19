#!/bin/sh

# .alias
if [ -f ~/.alias ]; then
    cp ~/.alias ~/.alias_old
fi
ln -s .alias ~/.alias

# .bash_colors
if [ -f ~/.bash_colors ]; then
    cp ~/.bash_colors ~/.bash_colors_old
fi
ln -s .bash_colors ~/.bash_colors

# .bash_profile
if [ -f ~/.bash_profile ]; then
    cp ~/.bash_profile ~/.bash_profile_old
fi
ln -s .bash_profile ~/.bash_profile

# .bashrc
if [ -f ~/.bashrc ]; then
    cp ~/.bashrc ~/.bashrc_old
fi
ln -s .bashrc ~/.bashrc

# .gitconfig
if [ -f ~/.gitconfig ]; then
    cp ~/.gitconfig ~/.gitconfig_old
fi
ln -s .gitconfig ~/.gitconfig

# .myclirc
if [ -f ~/.myclirc ]; then
    cp ~/.myclirc ~/.myclirc_old
fi
ln -s .myclirc ~/.myclirc

# .tmux.conf
if [ -f ~/.tmux.conf ]; then
    cp ~/.tmux.conf ~/.tmux.conf_old
fi
ln -s .tmux.conf ~/.tmux.conf

# .vimrc
if [ -f ~/.vimrc ]; then
    cp ~/.vimrc ~/.vimrc_old
fi
ln -s .vimrc ~/.vimrc

# diff-highlight
if [ -f ~/diff-highlight ]; then
    cp ~/diff-highlight ~/diff-highlight_old
fi
ln -s diff-highlight ~/diff-highlight

# .vim
if [ -d ~/.vim ]; then
    cp -R ~/.vim ~/.vim_old
fi
if [ -f ~/.vim ]; then
    cp ~/.vim ~/.vim_old
fi
ln -s .vim ~/.vim

# .dotfiles
if [ -d ~/.dotfiles ]; then
    cp -R ~/.dotfiles ~/.dotfiles_old
fi
ln -s ./ ~/.dotfiles
