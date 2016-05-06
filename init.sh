#!bin/bash

cd `dirname $0`

readonly DOTFILES_DIR=$HOME/dotfiles
readonly FILES=.*

for FILE in $FILES; do
    if [[ $FILE = '.' || $FILE = '..' || $FILE = '.git' || $FILE = '.gitmodules' ]]; then
        continue
    fi

    # 既にファイルや別ファイルへのシンボリックリンクが存在する場合はバックアップを取る
    if [[ -L $HOME/$FILE ]]; then
        lfile=`readlink $HOME/$FILE`
        if [[ $lfile = $DOTFILES_DIR/$FILE ]]; then
            continue
        fi
        mv $HOME/$FILE $HOME/$FILE-old
    elif [[ -f $HOME/$FILE ]]; then
        mv $HOME/$FILE $HOME/$FILE-old
    fi

    ln -s $DOTFILES_DIR/$FILE $HOME/$FILE
done
