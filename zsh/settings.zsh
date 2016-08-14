###############################
# History
###############################

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# コマンドの開始時刻、実行時間もヒストリファイルに書き込む
setopt extended_history

# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 先頭にスペースをいれると、コマンドはヒストリに追加しない
setopt hist_ignorespace

# 余分なスペースを除いてからヒストリに追加する
setopt hist_reduce_blanks

# ヒストリ展開時、いきなりコマンド実行せずに一旦提示する
setopt hist_verify

# 稼働するzshプロセスでヒストリを共有
setopt share_history

################################
# peco
################################
zle -N peco-history-selection
bindkey '^r' peco-history-selection
