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
	echo 2
	git submodule update --init --recursive
	echo 3
fi

# exec let's encrypt renew and check if there were errors
if ! ./letsencrypt-auto renew > /var/log/letsencrypt/renew.log 2>&1 ; then
    echo Something terrible happened:
    cat /var/log/letsencrypt/renew.log
    exit 1
fi

echo 'See you later alligator!'
exit
