#!/usr/bin/env bash

# proudly stolen from
# https://stackoverflow.com/a/71129295/796259

function vimq() {
    # shellcheck disable=SC2091
    vim -q <($(fc -nl -1)) +cw
}

function vimhelp() {
    vim +"help $*" +only
}
