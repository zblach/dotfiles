#!/bin/sh

declare -a FILES=(.zshrc .global.gitconfig .zshenv .tmux.conf .vimrc .gvimrc)

for file in ${FILES[@]}; do
  echo ln -is ${file} "${HOME}"
done

for template in $(find template -type f); do
  echo cp $template "${HOME}/${template##*/}"
done
# cp ./.gitconfig.template ~/.gitconfig
