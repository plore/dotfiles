# get executables right before their configuration
if [ -f ~/.path ]; then
	source ~/.path
fi

export ZSH=~/.oh-my-zsh	# path to oh-my-zsh installation

if [ -d $ZSH ]; then
	#
	# oh-my-zsh configuration
	#

	ZSH_THEME="agnoster"

	CASE_SENSITIVE="true"

	export UPDATE_ZSH_DAYS=13

	HIST_STAMPS="yyyy-mm-dd"
	HISTSIZE=100000
	SAVEHIST=$HISTSIZE

	plugins=(
		asdf
		bundler
		colored-man-pages
		docker-compose
		git
		history-substring-search
		jsontools
		vi-mode
	)

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

# define LS_COLORS via dircolors
if [ -x "$(command -v dircolors)" ]; then
	DIRCOLORS=dircolors
elif [ -x "$(command -v gdircolors)" ]; then
	DIRCOLORS=gdircolors
fi

if [ -r ~/.dircolors ]; then
	unset LS_COLORS			# predefined colors on non-BSD
	unset LSCOLORS			# BSD
    eval "$($DIRCOLORS -b ~/.dircolors)" # sets LS_COLORS
fi

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

if [ -f ~/.functions ]; then
	source ~/.functions
fi
