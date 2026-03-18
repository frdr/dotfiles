#!/usr/bin/env bash

# proudly stolen from
# https://stackoverflow.com/a/71129295/796259

function vimq() {
    # shellcheck disable=SC2091
    vim -q <($(fc -nl -1)) +cw
}

function vimgrep() {
    local _grep='grep -nH'
    command -v rg > /dev/null && _grep='rg --vimgrep'
    vim -q <(${_grep} "$@") +cw
}

function vimhelp() {
    vim +"help $*" +only
}
