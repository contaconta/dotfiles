#!/bin/sh
set -e

# symlink dotfiles
cd $(dirname $0)

#####################
# install oh-my-zsh
#####################
if [ ! -d '$HOME/.oh-my-zsh' ]; then
    echo 'oh-my-zsh is already installed.'
else
    echo 'install oh-my-zsh'
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

#####################
# tmux- powerline
#####################
if [ ! -d '~/dotfiles/tmux-powerline' ]; then
    echo 'tmux-powerline'
else
    echo 'install oh-my-zsh'
    git clone https://github.com/erikw/tmux-powerline.git
fi

# symlink tmux theme
rm $HOHE/dotfiles/powerline_conf/default.sh
ln -s $HOME/dotfiles/powerline_conf/default.sh $HOME/dotfiles/powerline_conf/default.sh

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
