#shellcheck disable=SC2034
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

if [[ -r /usr/share/git/completion/git-prompt.sh ]]; then
    source /usr/share/git/completion/git-prompt.sh
fi

VIRTUAL_ENV_DISABLE_PROMPT=1

PS1="\u@\h:\w\$ "

if which tput &> /dev/null; then
    __red=$(tput setaf 1)
    __gold=$(tput setaf 3)
    __green=$(tput setaf 2)
    __clear=$(tput sgr0)
else
    __red=''
    __gold=''
    __green=''
    __clear=''
fi

function __folding_ps1() {
    local _errorcode=$?

    PS1="\w"

    # user name and host if different from defaults
    local _host
    _host=$(hostname)
    if [[ $USER != "${_bashrc_d_install_user:-}" || $_host != "${_bashrc_d_install_host:-}" ]]; then
        PS1="\u@\h:${PS1}"
    fi

    local _num_jobs
    _num_jobs=$( jobs | wc -l )
    if [[ ${_num_jobs} -ne 0 ]]; then
        PS1="\[${__gold}\]⚒ \j\[${__clear}\] ${PS1}"
    fi

    if [[ ${_errorcode} -ne 0 ]]; then
        PS1="🙀\[\e${__red}\]${_errorcode}\[${__clear}\] ${PS1}"
    fi

    # Python virtual environment?
    if [ -v VIRTUAL_ENV_PROMPT ]; then
       PS1="🐍\[${__green}\]${VIRTUAL_ENV_PROMPT}\[${__clear}\] ${PS1}"
    fi

    PS1="${VIM:+✌ }${PS1}\[${__green}\]$(__git_ps1)\[${__clear}\]\$ "

    # xterm title bar
    PS1="\[\e]0;\u@\h: \w\a\]${PS1}"

    return ${_errorcode}
}

PROMPT_COMMAND=__folding_ps1
