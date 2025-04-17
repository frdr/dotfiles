GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1

source /usr/share/git/completion/git-prompt.sh

VIRTUAL_ENV_DISABLE_PROMPT=1

function __preamble_ps1() {
    local _errorcode=$?

    if [[ ${_errorcode} -ne 0 ]]; then
        __error_ps1="🙀 ${_errorcode} "
    else
        __error_ps1=""
    fi

    local _num_jobs
    _num_jobs=$( jobs | wc -l )
    if [[ ${_num_jobs} -ne 0 ]]; then
        __jobs_ps1="⚒ ${_num_jobs} "
    else
        __jobs_ps1=""
    fi

    # Python virtual environment?
    if [ -v VIRTUAL_ENV_PROMPT ]; then
        __venv_ps1="🐍 ${VIRTUAL_ENV_PROMPT} "
    else
        __venv_ps1=""
    fi

    # user name and host if different from defaults
    local _host
    _host=$(hostname)
    unset __user_ps1="${USER}@${_host}:"
    if [[ $USER != "${_bashrc_d_install_user:-}" || $_host != "${_bashrc_d_install_host:-}" ]]; then
        __user_ps1="${USER}@${_host}:"
    else
        __user_ps1=""
    fi

    return ${_errorcode}
}

PROMPT_COMMAND=__preamble_ps1

#PS1='${VIM:+✌ }${__error_ps1:-}${__jobs_ps1:-}${__venv_ps1:-}${__user_ps1:-\u@\h:}\w$(__git_ps1)\$ '
PS1='\[\e]0;\u@\h: \w\a\]${VIM:+✌ }\[\e[1;31m\]${__error_ps1:-}\[\e[0m\e[0;34m\]${__jobs_ps1:-}\[\e[0m\e[0;32m\]${__venv_ps1:-}\[\e[0m\]${__user_ps1:-}\w\[\e[0;32m\]$(__git_ps1)\[\e[0m\]\$ '
