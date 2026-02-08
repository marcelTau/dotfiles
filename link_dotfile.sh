#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <source> <destination>"
  exit 1
fi

src="$1"
dst="$2"

if [ ! -e "$src" ] && [ ! -L "$src" ]; then
  echo "Missing source: $src"
  exit 1
fi

mkdir -p "$(dirname "$dst")"

if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
  echo "ok    $dst"
  exit 0
fi

if [ -e "$dst" ] || [ -L "$dst" ]; then
  backup="$dst.bak.$(date +%Y%m%d%H%M%S)"
  mv "$dst" "$backup"
  echo "backup $backup"
fi

ln -s "$src" "$dst"
echo "link  $dst -> $src"
