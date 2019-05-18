#!/bin/sh
DOTFILES=$(dirname $(realpath ${0}))

echo "Creating symlinks in home directory for relevant dotfiles in interactive mode."

for dotfile in .tmux.conf .zshrc .vimrc
do
	ln -si ${DOTFILES}/dotfiles/${dotfile} ~/${dotfile}
done
