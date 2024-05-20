#!/usr/bin/env bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

# 存储原始的IFS（Internal Field Separator）值，并临时更改为换行符
OLDIFS=$IFS
IFS=$'\n'

# 替换这些变量为实际值
PKGNAME=$1  # .deb包的包名

DISTRIBUTION="polaris"
COMPONENT="devel"

if [ ! -n "$1" ] ;then
    echo "FAIL"
    exit 1
fi

current_dir=$(cd "$(dirname "$0")";pwd)

cd "$current_dir/../devrepo"

VERSION_CONTENT=$(reprepro list $DISTRIBUTION)

if [[ $VERSION_CONTENT =~ $DISTRIBUTION ]]; then
    if [[ $VERSION_CONTENT =~ $PKGNAME ]]; then
          echo "SUCCESS"
          echo "$VERSION_CONTENT"
          exit 0
    else
          echo "FAIL"
          exit 1
    fi
else
    echo "FAIL"
    exit 1
fi