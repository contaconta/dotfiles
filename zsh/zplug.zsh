# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    curl -sL zplug.sh/installer | zsh
    source ~/.zplug/init.zsh && zplug update --self
fi

# Essential
source ~/.zplug/init.zsh

# zplug check returns true if all packages are installed
# Therefore, when it returns false, run zplug install
if ! zplug check; then
    zplug install
fi

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", nice:10

# https://github.com/b4b4r07/enhancd
zplug "b4b4r07/enhancd", use:init.sh

# https://github.com/zplug/zplug/wiki/Configurations
zplug "peco/peco", as:command, from:gh-r

zplug "themes/cloud", from:oh-my-zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    # printf "Install? [y/N]: "
    # if read -q; then
    #     echo; zplug install
    # fi
    zplug install
fi

# Then, source packages and add commands to $PATH
zplug load --verbose
