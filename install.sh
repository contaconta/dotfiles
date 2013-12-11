#!/bin/sh

# install oh-my-zsh
#curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

# symlink dotfiles
cd $(dirname $0)
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitignore' ] && [ $dotfile != '.DS_Store' ]
    then
        ln -Fis "$PWD/$dotfile" $HOME
        echo "link $PWD/$dotfile to $HOME"
    fi
done

# symlink *.zsh files to ~/.oh-my-zsh/custom
cd $(dirname $0)
for zshfiles in zshrcs/*.zsh
do
    if [ $zshfiles != '..' ] && [ $zshfiles != '.git' ] && [ $zshfiles != '.gitignore' ]
    then
        ln -Fis "$PWD/$zshfiles" "$HOME/.oh-my-zsh/custom"
        echo "link $PWD/$zshfiles" "to" "$HOME/.oh-my-zsh/custom"
    fi
done
