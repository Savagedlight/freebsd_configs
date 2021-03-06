#!/bin/sh
# Test if package is installed.
pkg_exists() 
{
	pkg info ${1} 2>&1 >/dev/null
	if [ $? -eq 0 ]
	then
		echo 1
	else
		echo 0
	fi
}

# Verify required packages are installed.
MISSING_DEPENDENCIES=""
for p in ca_root_nss git curl zsh tmux 
do
	if [ $(pkg_exists $p) -eq 0 ]
	then
		echo "missing dependency: ${p}"
		MISSING_DEPENDENCIES="${MISSING_DEPENDENCIES} ${p}"
	fi
done

if [ -n "${MISSING_DEPENDENCIES}" ]
then
	echo "There are missing dependencies, and this script will not do anything more."
	echo "Please run: pkg install ${MISSING_DEPENDENCIES}"
	echo "and then run this script again."
	exit 1
fi

echo "Installing tmux tpm"
mkdir -p ~/.tmux/plugins/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "The oh-my-zsh installer will spawn a new shell. Please exit it."
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install bullet-train ZSH theme
mkdir -p ~/.oh-my-zsh/custom/themes
fetch -o - http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme > ~/.oh-my-zsh/custom/themes/bullet-train.zsh-theme

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Symlink the users dotfiles.
./symlink_dotfiles.sh

echo "Please ensure that your locale is set to UTF-8. Example: Add to login.conf:"
echo ":lang=en_US.UTF-8:"
