#! /bin/sh

bup index $HOME/.vim
bup save -n vim-backup --graft $HOME/.vim=/vim $HOME/.vim/

