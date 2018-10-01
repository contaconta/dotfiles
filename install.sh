#! /usr/bin/env zsh
set -e
OS=`uname`

DOTFILES_ROOT_DIR="${HOME}/dotfiles"

SCRIPT_DIR=$DOTFILES_ROOT_DIR
AUTOGEN_DIR="${SCRIPT_DIR}/autogen"
CONFIG_DIR="${HOME}/.config"

#####################
# tmux-powerline
#####################
INSTALL_DIR="${AUTOGEN_DIR}/tmux-powerline"
if [ -d ${INSTALL_DIR} ]; then
    echo 'tmux-powerline is already installed.'
else
    echo 'install tmux-powerline'
    git clone https://github.com/erikw/tmux-powerline.git ${INSTALL_DIR}
fi

# symlink tmux theme
tmux_default_theme_path="${INSTALL_DIR}/themes/default.sh"
tmux_custom_theme_path="${SCRIPT_DIR}/tmux/powerline_conf/default.sh"
if [ -e $tmux_default_theme_path ]; then
    rm $tmux_default_theme_path
    echo "remove default tmux theme"
fi
echo "link powerline theme"
ln -Fis ${tmux_custom_theme_path} ${tmux_default_theme_path}
echo ${tmux_default_theme_path}

#####################
# symlink .tmux.conf
#####################
case ${OS} in
    Darwin)
    ln -Fis "${SCRIPT_DIR}/tmux/tmux.mac.conf" "${HOME}/.tmux.conf"
    echo "link ${SCRIPT_DIR}/tmux/tmux.mac.conf ${HOME}/.tmux.conf"
    ;;
    Linux)
    ln -Fis "${SCRIPT_DIR}/tmux/tmux.linux.conf" "${HOME}/.tmux.conf"
    echo "link ${SCRIPT_DIR}/tmux/tmux.linux.conf ${HOME}/.tmux.conf"
    ;;
esac

#####################
# sshrc
#####################
if [ -e ~/.sshrc ]; then
	echo "sshrc is already linked"
else
	echo "link sshrc settings..."
	ln -Fis "${SCRIPT_DIR}/sshrc/.sshrc" "${HOME}/.sshrc"
	ln -Fis "${SCRIPT_DIR}/sshrc/.sshrc.d" "${HOME}/.sshrc.d"
fi

#####################
## emacs
#####################
#EMACS_INIT="${HOME}/.emacs.d/init.el"
#if [ -e ${EMACS_INIT} ]; then
#    rm ${EMACS_INIT}
#fi
#ln -Fis "${SCRIPT_DIR}/.emacs.d/init.el" ${EMACS_INIT}

#####################
## nvim
#####################
mkdir -p ${CONFIG_DIR}
NVIM_INIT="${HOME}/.config/nvim"
if [ -e ${NVIM_INIT} ]; then
    rm ${NVIM_INIT}
fi
ln -Fis "${SCRIPT_DIR}/nvim" ${NVIM_INIT}
