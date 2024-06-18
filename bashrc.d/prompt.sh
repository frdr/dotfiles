# git
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

source /usr/share/git/completion/git-prompt.sh

function swiss_army_prompt()
{
  # preserve for later
  local _errorcode=$?

  # colors, made to look nice with gnome-terminal-colors-solarized
  # local blue="\[\e[0;34m\]"
  # local gold="\[\e[0;33m\]"
  # local green="\[\e[0;32m\]"
  # local red="\[\e[1;31m\]"
  # local white="\[\e[0;37m\]"
  # local bleach="\[\e[0m\]"
  # erase prompt
  PS1=''

  # indicate vim running in the background
  if [ $VIM ]; then
    PS1="\[\e[0;33m\]=vim=\[\e[0m\]"
  fi

  # indicate background jobs
  local numjobs=$(jobs | wc -l)
  if [ ${numjobs} -ne 0 ]; then
    PS1="${PS1}[\[\e[0;34m\]${numjobs}\[\e[0m\]]"
  fi

  # indicate error of last command
  if [ ${_errorcode} -ne 0 ]; then
    PS1="${PS1}\[\e[0;37m\]>>\[\e[1;31m\]${_errorcode}\[\e[0;37m\]<<\[\e[0m\]"
  fi

  # main thing: path, __git_ps1 and $
  PS1="${PS1}\w\[\e[0;32m\]$(__git_ps1)\[\e[0m\]\$ "

  # set title bar of xterm
  case "$TERM" in
  xterm*|rxvt*)
      PS1="\[\e]0;\u@\h: \w\a\]${PS1}"
    ;;
  *)
    ;;
  esac

  #restore error code for subsequent $?
  return ${_errorcode}
}
PROMPT_COMMAND=swiss_army_prompt
