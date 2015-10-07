exists(){
	which "$1" >/dev/null 2>&1
	return $?
}

# set DOTPATH
if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=~/.dotfiles; export DOTPATH
fi

download(){
	if [ -d "$DOTPATH" ]; then
		echo "$DOTPATH: already exists"
		exit 1
	fi

	if exists "git"; then
		git clone --recursive "https://github.com/quartorz/dotfiles" "$DOTPATH"
	fi
}

download

