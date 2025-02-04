# Setting Homebrew variables
eval "$(/opt/homebrew/bin/brew shellenv)"

php-switch-version() {
	local apachedir
	local apacheconf
	
	# You can adjust these if the config file with all the `LoadModule` lines for PHP is in a non-standard location
	apachedir="$(brew --prefix)/etc/httpd"
	apacheconf="$apachedir/httpd.conf"
	
	if [[ -z $1 ]]; then
		echo "Usage: php-switch-version <version>"
		return 1
	fi

	local phpver="$1"
	if [[ ! $phpver =~ ^[0-9]+\.[0-9]+$ ]]; then
		echo "Invalid PHP version: $phpver"
		return 1
	fi

	echo 'Unlinking all PHP versions'
	(trap 'kill 0' SIGINT;
		brew unlink php >/dev/null &
		brew unlink php@8.0 >/dev/null &
		brew unlink php@8.3 >/dev/null &
		wait
	)
	brew link --overwrite --force php@"$phpver" || return $?

	echo 'Fixing Apache conf (LoadModule.*php lines)'
	sed -E -i '' 's!^(LoadModule php)!#\1!g' "$apacheconf" || return $?
	sed -E -i '' "s!^#(LoadModule php.*/php@$phpver/)!\1!g" "$apacheconf" || return $?
	echo 'Restarting Apache'
	echo ''
	brew services restart httpd
}
