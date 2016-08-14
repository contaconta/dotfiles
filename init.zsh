#! /usr/bin/env zsh

#####################
# load scripts
#####################
SCRIPT_DIR=$(dirname $0)
source ${SCRIPT_DIR}/zsh/env.zsh
source ${SCRIPT_DIR}/zsh/utils.zsh
source ${SCRIPT_DIR}/zsh/zplug.zsh
source ${SCRIPT_DIR}/zsh/alias.zsh
source ${SCRIPT_DIR}/zsh/settings.zsh

# run scripts
tmux_ssh
attach_tmux
