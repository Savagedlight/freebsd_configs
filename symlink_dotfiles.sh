#!/bin/sh
DOTFILES="$(dirname $(realpath ${0}))/dotfiles"


echo "Creating symlinks in home directory for relevant dotfiles in interactive mode."

for f in $(find ${DOTFILES} -maxdepth 1 -type f)
do
	dotfile="$(basename ${f})"
	ln -si ${f} ~/${dotfile}
done
