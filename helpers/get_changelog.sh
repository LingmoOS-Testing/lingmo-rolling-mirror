#!/usr/bin/env bash

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

export LC_ALL=C

# 存储原始的IFS（Internal Field Separator）值，并临时更改为换行符
OLDIFS=$IFS
IFS=$'\n'

# 替换这些变量为实际值
PKGNAME=$1  # .deb包的文件名
PKGFILENME=$(basename $PKGNAME)
DIRNAME="/tmp/lingmodev/"$PKGFILENME     # 解包内容的目标目录

if [ ! -n "$1" ] ;then
    echo "FAIL"
    exit 1
fi

mkdir -p $DIRNAME

# 解压deb包的数据部分
dpkg -x $PKGNAME $DIRNAME > /dev/null 2>&1

if [ $? -ne 0 ];then
	echo "FAIL"
	exit 1
fi

# 尝试使用zcat输出changelog.gz的内容，并保存到变量中
CHANGELOG_CONTENT1=$(zcat $DIRNAME/usr/share/doc/*/changelog.gz 2>&1)
CHANGELOG_CONTENT2=$(zcat $DIRNAME/usr/share/doc/*/changelog.Debian.gz 2>&1)

# 恢复IFS
IFS=$OLDIFS

rm -rf $DIRNAME

# 判断changelog.gz是否存在以及是否可以读取它的内容
if [[ $CHANGELOG_CONTENT1 =~ "No such file or directory" ]]; then
    if [[ $CHANGELOG_CONTENT2 =~ "No such file or directory" ]]; then
        echo "FAIL"
        exit 1
    else
        echo "SUCCESS"
        echo "$CHANGELOG_CONTENT2"
        exit 0
    fi
else
    echo "SUCCESS"
    echo "$CHANGELOG_CONTENT1"
    exit 0
fi