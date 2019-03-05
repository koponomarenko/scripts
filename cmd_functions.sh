#!/bin/bash

# include guard
if declare -f -F default_cmd_do_nonfatal >/dev/null; then
    return
fi

# cmd_* family of functions:
# use them to print out your scripts and exit the script on error.

default_cmd_die() {
    echo $@
    exit 1
}

# cmd_die - use to fail the script immediately.
# Example usage: cmd_die "command $tool not found".
cmd_die() {
    default_cmd_die "$@"
}

# This is a "base class" for cmd_do_nonfatal.
# If you want a special-case cmd_do_nonfatal (e.g. redirect the output) -
# redefine cmd_do_nonfatal and reuse default_cmd_do_nonfatal call.
# This is to avoid copypasting of cmd_do_nonfatal.
default_cmd_do_nonfatal() {
    echo ">> $@"
    eval "$@"
}

# cmd_do_nonfatal - use this to print command before executing.
# Watch out for bash quoting! http://wiki.bash-hackers.org/syntax/quoting.
# Example usage: cmd_do_nonfatal <shell_cmd>
cmd_do_nonfatal() {
    default_cmd_do_nonfatal "$@"
}

# cmd_do - use this to print command before executing and exit the script on error.
# Watch out for bash quoting! http://wiki.bash-hackers.org/syntax/quoting.
# Example usage: cmd_do <shell_cmd>
cmd_do() {
    cmd_do_nonfatal "$@" || cmd_die
}
