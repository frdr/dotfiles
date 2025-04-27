GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

source /usr/share/git/completion/git-prompt.sh

VIRTUAL_ENV_DISABLE_PROMPT=1

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
        PS1="\[\e[0;33m\]⚒ \j\[\e[0m\] ${PS1}"
    fi

    if [[ ${_errorcode} -ne 0 ]]; then
        PS1="🙀\[\e[1;31m\]${_errorcode}\[\e[0m\] ${PS1}"
    fi

    # Python virtual environment?
    if [ -v VIRTUAL_ENV_PROMPT ]; then
       PS1="🐍\[\e[0;32m\]${VIRTUAL_ENV_PROMPT}\[\e[0m\] ${PS1}"
    fi

    PS1="${VIM:+✌ }${PS1}\[\e[0;32m\]$(__git_ps1)\[\e[0m\]\$ "

    # xterm title bar
    PS1="\[\e]0;\u@\h: \w\a\]${PS1}"

    return ${_errorcode}
}

PROMPT_COMMAND=__folding_ps1

PS1="\u@\h:\w\$ "
