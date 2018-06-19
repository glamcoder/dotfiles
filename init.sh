#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# .alias
if [ -f ~/.alias ]; then
    mv ~/.alias ~/.alias_old
fi
ln -s $DIR/.alias ~/.alias

# .bash_colors
if [ -f ~/.bash_colors ]; then
    mv ~/.bash_colors ~/.bash_colors_old
fi
ln -s $DIR/.bash_colors ~/.bash_colors

# .bash_profile
if [ -f ~/.bash_profile ]; then
    mv ~/.bash_profile ~/.bash_profile_old
fi
ln -s $DIR/.bash_profile ~/.bash_profile

# .bashrc
if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc_old
fi
ln -s $DIR/.bashrc ~/.bashrc

# .gitconfig
if [ -f ~/.gitconfig ]; then
    cp ~/.gitconfig ~/.gitconfig_old
fi
ln -s $DIR/.gitconfig ~/.gitconfig

# .myclirc
if [ -f ~/.myclirc ]; then
    mv ~/.myclirc ~/.myclirc_old
fi
ln -s $DIR/.myclirc ~/.myclirc

# .tmux.conf
if [ -f ~/.tmux.conf ]; then
    mv ~/.tmux.conf ~/.tmux.conf_old
fi
ln -s $DIR/.tmux.conf ~/.tmux.conf

# .vimrc
if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc_old
fi
ln -s $DIR/.vimrc ~/.vimrc

# .vim
if [ -d ~/.vim ]; then
    mv ~/.vim ~/.vim_old
fi
ln -s $DIR/.vim ~/.vim

# .dotfiles
if [ -d ~/.dotfiles ]; then
    mv -R ~/.dotfiles ~/.dotfiles_old
fi
ln -s $DIR ~/.dotfiles
