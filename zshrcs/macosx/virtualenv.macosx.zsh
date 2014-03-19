echo "mac virtualenv..."
###############################################################################
# virtualenv
#   workon set $PS1 environmental variable.
#   so if you don't want to display "(env01) $" to prompt,
#   run this script before "source $ZSH/oh-my-zsh.sh"
###############################################################################
function set_virtualenv () {
    if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
        export WORKON_HOME=$HOME/.virtualenvs
        export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
        source /usr/local/bin/virtualenvwrapper.sh
        export VIRTUALENV_USE_DISTRIBUTE=1
        workon pydev2.7
    fi    
}
