# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
    source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"

# https://github.com/zplug/zplug/wiki/Configurations
# zplug "peco/peco", as:command, from:gh-r

# # https://github.com/b4b4r07/enhancd
# ENHANCD_FILTER=peco; export ENHANCD_FILTER
# zplug "b4b4r07/enhancd", use:init.sh

# from oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "themes/cloud", from:oh-my-zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    zplug install
fi

# Then, source packages and add commands to $PATH
zplug load --verbose
