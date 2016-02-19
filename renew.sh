#!/bin/bash
if [ "$(id -u)" != "0" ]; then
	echo "Unfortunately requires root privileges to do its stuff.. Run this with sudo"
	exit 1
fi

# check if the src dir exists and update or clone the git repository
if [ -d src ]; then
	cd src
	git fetch --all
	git reset --hard origin/master
else
	git clone https://github.com/letsencrypt/letsencrypt src
fi

# exec let's encrypt renew
exec ./letsencrypt-auto certonly renew

echo 'See you later alligator!'
exit
