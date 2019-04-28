# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
[ -z "$PS1" ] && return

# Put your fun stuff here.
eval `keychain --eval --agents ssh id_rsa`

#
# History
#

HISTCONTROL=ignoredups
HISTSIZE=50000
export HISTIGNORE="[   ]*:&:bg:fg:exit"
shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell

if [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
fi

# set LS_COLORS env var
type dircolors &> /dev/null && eval `dircolors`

. .shell_env
