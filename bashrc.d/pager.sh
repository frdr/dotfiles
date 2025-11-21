#!/usr/bin/env bash

# Run last command through pager
function pp() {
    # shellcheck disable=SC2091
    $(fc -nl -1) | ${PAGER:-less}
}
