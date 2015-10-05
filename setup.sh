exists(){
	which "$1" >/dev/null 2>&1
	return $?
}

if exists "curl" || exists "wget"; then
	if exists "curl"; then
		sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
		curl -k "https://github.com/quartorz/oh-my-zsh-solarized-powerline-theme/blob/master/solarized-powerline.zsh-theme" > ~/.oh-my-zsh/custom/solarized-powerline.zsh-theme
	else
		sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
		wget --no-check-certificate "https://github.com/quartorz/oh-my-zsh-solarized-powerline-theme/blob/master/solarized-powerline.zsh-theme" -P ~/.oh-my-zsh/custom
	fi
fi

if (uname | grep -e 'MINGW' >/dev/null 2>&1) || (uname | grep -e 'CYGWIN' >/dev/null 2>&1); then
	cp vimrc $HOME/.vimrc
	cp zshrc $HOME/.zshrc
	cp -r vim $HOME/.vim
else
	ln -sv vimrc $HOME/.vimrc
	ln -sv zshrc $HOME/.zshrc
	ln -sdv vim $HOME/.vim
fi
