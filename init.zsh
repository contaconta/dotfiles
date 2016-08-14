#! /usr/bin/env zsh
SCRIPT_DIR=$(dirname $0)
OS=`uname`

cd ${SCRIPT_DIR}
AUTOGEN_DIR="${SCRIPT_DIR}/autogen"

#####################
# tmux-powerline
#####################
INSTALL_DIR="${AUTOGEN_DIR}/tmux-powerline"
if [ -d ${INSTALL_DIR} ]; then
    # echo 'tmux-powerline is already installed.'
else
    echo 'install tmux-powerline'
    git clone https://github.com/erikw/tmux-powerline.git ${INSTALL_DIR}

	# symlink tmux theme
	tmux_default_theme_path="${INSTALL_DIR}/themes/default.sh"
	if [ -e $tmux_default_theme_path ]; then
	    rm $tmux_default_theme_path
	    echo "remove default tmux theme"
	fi
	echo "link powerline theme"
	ln -s "${SCRIPT_DIR}/tmux/powerline_conf/default.sh" ${tmux_default_theme_path}
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
fi

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
# load scripts
#####################
source ${SCRIPT_DIR}/zsh/env.zsh
source ${SCRIPT_DIR}/zsh/utils.zsh
source ${SCRIPT_DIR}/zsh/zplug.zsh
source ${SCRIPT_DIR}/zsh/alias.zsh
source ${SCRIPT_DIR}/zsh/settings.zsh

# run scripts
tmux_ssh
attach_tmux
