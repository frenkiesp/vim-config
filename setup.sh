#!/bin/bash

ln -s ~/.vim/vimrc ~/.vimrc

mkdir -p ~/.fonts/
cp ~/.vim/powerline-fonts/* ~/.fonts/
fc-cache -fv
