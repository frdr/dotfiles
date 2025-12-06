#!/usr/bin/env bash

# Run a command without firejail's sandbox.
# As for the pun: sorry, couldn't resist.
function firefail() {
    firejail --noprofile "$@"
}
