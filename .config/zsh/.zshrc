if [ -z "$TMUX" ]
then
  exec tmux new-session
fi

case ${OSTYPE} in
  darwin*)
    EMACS="/Applications/Emacs.app/Contents/MacOS/Emacs"
    EMACSCLIENT="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
    alias emacs="$EMACS"
    alias emacsclient="$EMACSCLIENT"
    export EDITOR="$EMACSCLIENT -nw"
    ;;
  linux*)
    ;;
  msys*)
    if which start > /dev/null; then
      function mstart(){
        for arg in $@
        do
          start $arg
        done
      }
      alias start=mstart
    fi
    ;;
esac

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ ! -d $ZPLUG_HOME ]; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
  source $ZPLUG_HOME/init.zsh && zplug update --self
fi

function zplug_init (){
  source $ZPLUG_HOME/init.zsh
  unset -f zplug_init
}

export MY_ZPLUG_SOURCES=$ZPLUG_HOME/my_zplug_sources

function update_zplug_sources () {
  if which zplug_init > /dev/null
  then
    zplug_init
  fi
  zplug load --verbose \
    | grep -E "^ Load" \
    | cut -d" " -f 3 \
    | sed -e "s/^/. /" -e 's/"//g' \
    | tee $MY_ZPLUG_SOURCES
}

if [ ! -f "$MY_ZPLUG_SOURCES" ]
then
  update_zplug_sources
fi

# . $MY_ZPLUG_SOURCES
zplug_init
zplug load

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
bindkey ' ' autosuggest-accept

# direnv setup
eval "$(direnv hook zsh)"

if (which zprof > /dev/null) ;then
  zprof
fi
