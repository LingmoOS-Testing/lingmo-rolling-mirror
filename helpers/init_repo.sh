#!/usr/bin/env bash

set -o errexit
set -o nounset

DISTRIBUTION="polaris-devel"
COMPONENTS="main contrib non-free"
ARCHITECTURES="amd64 source"
GPG_KEY="32259E1EF21375F04B9C8FC7586C0A9D70A392B1"

REPO_DIR_NAME="devrepo"

current_dir=$(cd "$(dirname "$0")";pwd)
echo "$current_dir"

cd "$current_dir/.."

if [ -d "$REPO_DIR_NAME" ]; then
  rm -rfv "$REPO_DIR_NAME"
fi

mkdir -p "$REPO_DIR_NAME"/conf

cd "$REPO_DIR_NAME"/conf

echo "Codename: $DISTRIBUTION" >> distributions
echo "Architectures: $ARCHITECTURES" >> distributions
echo "Components: $COMPONENTS" >> distributions
echo "SignWith: $GPG_KEY" >> distributions

echo "Init finished!"