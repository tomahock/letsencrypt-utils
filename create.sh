#!/bin/bash

# check running with root privileges
if [ "$(id -u)" != "0" ]; then
	echo "Unfortunately requires root privileges to do its stuff.. Run this with sudo"
	exit 1
fi

# check if $1 is passed 
if [[ -z $1 ]]; then
	echo "Invalid domain"
	echo "Run $ ./create.sh domain"
	exit 1
else
	# check if domain resolves
	host $1 2>&1 > /dev/null
    	if [ $? -eq 0 ]; then
		DOMAIN=$1        
	else
        	echo "$1 is not responding... You should serve this domain."
		echo "Read Me: https://github.com/tomahock/letsencrypt-utils/blob/master/README.md#create"
        fi
fi

# check if the src dir exists and update or clone the git repository
if [ -d src ]; then
	cd src
	git fetch --all
	git reset --hard origin/master
else
	git submodule update --init --recursive
fi

# exec let's encrypt create
./letsencrypt-auto certonly --server  https://acme-v01.api.letsencrypt.org/directory -a webroot --webroot-path=/tmp/letsencrypt-auto -d $DOMAIN -d www.$DOMAIN 

echo 'See you later alligator!'
exit
