# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#
# general config
#

# general aliases
if [ -f ~/.alias ]; then
	source ~/.alias
fi

# general variables
if [ -f ~/.env ]; then
	source ~/.env
fi

#
# options
#

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# number of commands to store in memory
HISTSIZE=1000

# number of commands to store in HISTFILE
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# a command that is the name of a directory translates into a cd into that directory
shopt -s autocd

# correct spelling mistakes in cd arguments
shopt -s cdspell

# ignore case while globbing
shopt -s nocaseglob

#
# prompt
#

PROMPT_FG_RED="$(tput setaf 1)"
PROMPT_FG_BLUE="$(tput setaf 4)"
PROMPT_FG_WHITE="$(tput setaf 7)"
PROMPT_FG_BLACK="$(tput setaf 8)"

PROMPT_BG_RED="$(tput setab 1)"
PROMPT_BG_BLUE="$(tput setab 4)"
PROMPT_BG_WHITE="$(tput setab 7)"
PROMPT_BG_BLACK="$(tput setab 8)"

PROMPT_DEFAULT="$(tput sgr0)"

# highlight working directory part of prompt
PS1='$\u@\h:${PROMPT_BG_BLUE}${PROMPT_FG_BLACK}\w\$${PROMPT_DEFAULT} '

# set variable identifying the chroot you work in, given the variable is not
# defined and the corresponding file exists
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1="${debian_chroot:+($debian_chroot)}$PS1"

# method to put a red X on error status
exitstatus()
{
	if [[ $? != 0 ]]; then
		echo "${PROMPT_FG_RED} X ${PROMPT_DEFAULT}"
	fi
}

# escape $ to evaluate anew on each prompt redraw instead of once on definition
PS1="\$(exitstatus)$PS1"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# git status extension
if [ -f /etc/bash_completion.d/git-prompt ]; then
	source /etc/bash_completion.d/git-prompt
	export PS1=$PS1'$(__git_ps1 "\[\e[0;32m\](%s) \[\e[0m\]")'
fi

#
# misc
#

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
