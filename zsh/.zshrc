# get executables right before their configuration
if [ -f ~/.path ]; then
	source ~/.path
fi

export ZSH=~/.oh-my-zsh	# path to oh-my-zsh installation

if [ -d $ZSH ]; then
	#
	# oh-my-zsh configuration
	#

	# oh-my-zsh theme
	ZSH_THEME="agnoster"

	# case-sensitive completion
	CASE_SENSITIVE="true"

	# how often to auto-update
	export UPDATE_ZSH_DAYS=13

	# 'history' command output format
	HIST_STAMPS="yyyy-mm-dd"

	# oh-my-zsh plugins to load
	plugins=(git bundler vi-mode history-substring-search colored-man-pages jsontools)

	source $ZSH/oh-my-zsh.sh

	# unbind v key (set to edit-command-line by plugin vi-mode, confuses me all the time)
	bindkey -rM vicmd 'v'

	# HACK: enable history-substring-search by explicitly mapping to keys
	bindkey "^[[A" history-substring-search-up
	bindkey "^[[B" history-substring-search-down

else
	#
	# configure zsh to be workable without oh-my-zsh
	#

	# lets names of parameters set to absolute dirs be used as a stand-in for those dirs at the
	# prompt, potentially saving prompt space (e.g. by using ~ instead of /home/<username>)
	setopt AUTO_NAME_DIRS

	# prompts
	export PS1="%n@%M %~%# "

	#
	# configure ZLE vi mode
	#

	# enable vi bindings in ZLE
	setopt VI

	# reduce delay after hitting <ESC>
	export KEYTIMEOUT=1

	# enable backspace and delete in insert mode
	bindkey '^H' backward-delete-char
	bindkey '^?' backward-delete-char

	# display mode information on the right hand side prompt
	function zle-line-init zle-keymap-select {
		if [[ $KEYMAP == "vicmd" ]]; then
			RPS1="[NORMAL]"
		elif [[ $KEYMAP == "main" || $KEYMAP == "viins" ]]; then
			RPS1=""
		else
			RPS1="[$KEYMAP]"
		fi
		zle reset-prompt
	}
	zle -N zle-line-init
	zle -N zle-keymap-select
fi

#
# additional configuration
#

# correct spelling mistakes for commands but not arguments
unsetopt correct_all
setopt correct

# cycle through possible completions instead of expanding with all completions at once
setopt GLOB_COMPLETE

# do not notify on completed background job (can mess up editor view)
setopt NO_NOTIFY

# custom environment variables
if [ -f ~/.env_additional ]; then
	source ~/.env_additional
fi

autoload -Uz compinit promptinit
compinit
promptinit

# ls and completion style
if [ -x "$(command -v dircolors)" ]
then
	unset LS_COLORS
	DIRCOLORS=dircolors
else
	# we're most likely on macOS and want to use GNU ls
	unset LSCOLORS			# remove settings for BSD ls
	export CLICOLOR=1
	DIRCOLORS=gdircolors
fi
eval $($DIRCOLORS -b ~/.dircolors)

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

# additional aliases
if [ -f ~/.alias ]; then
	source ~/.alias
fi

# additional options for external programs
if [ -f ~/.programs ]; then
	source ~/.programs
fi
