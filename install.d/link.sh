#!/bin/bash

ORIG_DOTFILES=$(echo '
.zshenv
.tmux.conf
.vim
.git_template
.vimperatorrc
' | xargs)

for f in $ORIG_DOTFILES; do
  if [ -e $HOME/$f ]; then
    mv $HOME/$f /tmp/${f}.orig
  fi
  ln -s $ZDOTDIR/$f $HOME/$f
done

# tmux plugins
TMUXDIR=$HOME/.tmux
mkdir -p $TMUXDIR/plugins
ln -s $HOME/src/github.com/tmux-plugins/tpm $TMUXDIR/plugins/tpm

# neovim
mkdir -p $XDG_CONFIG_HOME/nvim
ln -s $ZDOTDIR/.vim/vimrc $XDG_CONFIG_HOME/nvim/init.vim
