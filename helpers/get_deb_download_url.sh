#!/usr/bin/env bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

PKGNAME=$1  # .deb包的完整文件名

DISTRIBUTION="polaris"
COMPONENT="devel"

# 存储原始的IFS（Internal Field Separator）值，并临时更改为换行符
OLDIFS=$IFS
IFS=$''

if [ ! -n "$1" ] ;then
    echo "FAIL"
    exit 1
fi

current_dir=$(cd "$(dirname "$0")";pwd)

cd "$current_dir/../devrepo"

FILE_PATH=$(find ./ -name $PKGNAME)

if [[ $FILE_PATH =~ $PKGNAME ]]; then
    echo "SUCCESS"
    echo "$FILE_PATH"
    # 恢复IFS
    IFS=$OLDIFS
    exit 0
else
    echo "FAIL"
    # 恢复IFS
    IFS=$OLDIFS
    exit 1
fi