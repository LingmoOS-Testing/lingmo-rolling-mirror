#!/usr/bin/env bash

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

DISTRIBUTION="polaris-devel"
COMPONENT="devel"

echo "Starting Removing Deb <br/>"


if [ ! -n "$1" ] ;then
    echo "No valid param given! <br/>"
    exit 1
else
    echo "Removing deb: $1 <br/>"
fi


deb_file=$1

current_dir=$(cd "$(dirname "$0")";pwd)
#echo "$current_dir"

cd "$current_dir/../devrepo"
#pwd

/usr/bin/reprepro -b "$current_dir/../devrepo" remove $DISTRIBUTION $deb_file

if [ $? -ne 0 ];then
    echo "<br/>"
	echo " Remove Failed <br/>"
	exit 1
else
    echo "<br/>"
	echo "Removed successfully! <br/>"
fi
