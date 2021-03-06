#!/bin/sh


function symlink_dir() {
	for f in $(find "${1}" -maxdepth 1 -type f)
	do
		dotfile="$(basename ${f})"
		ln -si ${f} ~/${dotfile}
	done
}

echo "Creating symlinks in home directory for relevant dotfiles in interactive mode."

MYDIR="$(dirname $(realpath ${0}))"
for d in $(find ${MYDIR} -maxdepth 1 -type f)
do
	symlink_dir "${d}"
done


