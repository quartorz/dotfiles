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

ln -sv vimrc .vimrc
mv .vimrc ../
ln -sv zshrc .zshrc
mv .zshrc ../
ln -sdv vim .vim
mv .vim ../
