#!/bin/sh
set -e

SCRIPT_DIR=$(dirname $0)
OS=`uname`

cd ${SCRIPT_DIR}

#####################
# install oh-my-zsh
#####################
if [ -d ${HOME}/.oh-my-zsh ]; then
    echo 'oh-my-zsh is already installed.'
else
    echo 'install oh-my-zsh'
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

#####################
# tmux-powerline
#####################
if [ -d ${HOME}/dotfiles/tmux-powerline ]; then
    echo 'tmux-powerline is already installed.'
else
    echo 'install tmux-powerline'
    git clone https://github.com/erikw/tmux-powerline.git 
fi

# symlink tmux theme
tmux_default_theme_path=${HOME}/dotfiles/tmux-powerline/themes/default.sh
if [ -e $tmux_default_theme_path ]; then
    rm $tmux_default_theme_path    
    echo "remove default tmux theme"
fi
echo "link powerline theme"
ln -s "${HOME}/dotfiles/powerline_conf/default.sh" $tmux_default_theme_path

#####################
# symlink .tmux.conf
#####################
cd ${SCRIPT_DIR}
case ${OS} in
    Darwin)
    ln -Fis "$PWD/tmux.mac.conf" "${HOME}/.tmux.conf"
    echo "link $PWD/tmux.mac.conf ${HOME}/.tmux.conf"
    ;;
    Linux)
    ln -Fis "$PWD/tmux.linux.conf" "${HOME}/.tmux.conf"
    echo "link $PWD/tmux.linux.conf ${HOME}/.tmux.conf"
    ;;
esac

#####################
# symlink dotfiles
#####################
cd ${SCRIPT_DIR}
for dotfile in .?*; do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitignore' ] && [ $dotfile != '.DS_Store' ]; then
        ln -Fis "$PWD/$dotfile" $HOME
        echo "link $PWD/$dotfile to $HOME"
    fi
done

###############################################################
# symlink *.zsh files to ~/.oh-my-zsh/custom
###############################################################
link_file_to_custom_dir ()
{
    dotfile=$1
    if [ ! -e $dotfile ]; then
        echo "file does not exist: ${dotfile}" >&2
        return 1
    fi

    if [ $dotfile != '..' ] && [ $dotfile != '.git' ] && [ $dotfile != '.gitignore' ] && [ $dotfile != '.DS_Store' ]; then
        ln -Fis "$PWD/$dotfile" "$HOME/.oh-my-zsh/custom"
        echo "link $PWD/$dotfile" "to" "$HOME/.oh-my-zsh/custom"
    fi
    return 0
}

# link shared files
cd ${SCRIPT_DIR}
for zshfiles in zshrcs/shared/*.zsh; do
    link_file_to_custom_dir $zshfiles
done

# link others
cd ${SCRIPT_DIR}
case ${OS} in
    Darwin)
    echo "link MacOSX scripts"
    for zshfiles in zshrcs/macosx/*.zsh; do
        link_file_to_custom_dir $zshfiles
    done
    ;;
    Linux)
    echo "link linux scripts"
    for zshfiles in zshrcs/linux/*.zsh; do
        link_file_to_custom_dir $zshfiles
    done
    ;;
esac

