#Determine env

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

if [ -f ~/.alias ]; then
	. ~/.alias
fi

# MacOS

if [ "$machine" = "Mac" ]
then

	if [ -f /opt/homebrew/opt/homeshick/homeshick.sh ]; then
		# homeshick - brew installation
		export HOMESHICK_DIR=/opt/homebrew/opt/homeshick
		source "/opt/homebrew/opt/homeshick/homeshick.sh"
	elif [ -f $HOME/.homesick/repos/homeshick/homeshick.sh ]; then
		# homeshick - Git clone installation
		export HOMESHICK_DIR=/usr/local/opt/homeshick
		source "$HOME/.homesick/repos/homeshick/homeshick.sh"
	fi

	if [ -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
		[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
	fi
fi

# RHEL
if [ "$machine" = "Linux" ]; then
	echo "Applying Linux-specific settings"

	# print full pathname
	PATH="$(printf "%s" "${PATH}" | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')"

	if [ -f ~/.git-completion.sh ]; then
	    source ~/.git-completion.bash
	fi

	if [ -f ~/.git-prompt.sh ]; then
	    source ~/.git-prompt.sh
	fi

	if [ -f $HOME/.homesick/repos/homeshick/homeshick.sh ]; then
		source "$HOME/.homesick/repos/homeshick/homeshick.sh"
		source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
	else
		echo "homeshick not found"
	fi


	# set up git autocompletion prompt
	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_SHOWCOLORHINTS=true
	PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

	PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

	# Set up Caps Lock -> Escape mapping
	if [ -s ~/.Xmodmap ]; then
	    xmodmap ~/.Xmodmap
	fi

fi

if [ -x /usr/bin/keychain ] ; then
        MYNAME=`/usr/bin/whoami`
        if [ -f ~/.ssh/${MYNAME}_at_linkedin.com_ssh_key ] ; then
              /usr/bin/keychain ~/.ssh/${MYNAME}_at_linkedin.com_ssh_key
              . ~/.keychain/`hostname`-sh
        fi
fi


# User specific environment and startup programs

export NODE_OPTIONS=--max-old-space-size=8192

export PATH=$PATH:$HOME/bin

# change Node default dir
export PATH=~/.npm-global/bin:$PATH

export NETREPO=svn+ssh://svn.corp.linkedin.com/netrepo/network
export LIREPO=svn+ssh://svn.corp.linkedin.com/lirepo
export VENREPO=svn+ssh://svn.corp.linkedin.com/vendor

export JAVA_HOME=$(/usr/libexec/java_home)

export NLS_LANG=American_America.UTF8
export M2_HOME=/local/maven
export M2=$M2_HOME/bin

export PATH=/export/apps/xtools/bin:$PATH:$JAVA_HOME/bin:/usr/local/bin:/usr/local/mysql/bin:/usr/local/linkedin/bin


# remove duplicates in PATH:
PATH=$(echo ${PATH} | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')
PATH="${PATH%:}"    # remove trailing colon
export PATH
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"


# stop Git auto completing remotes
_git_checkout ()
{
  __git_has_doubledash && return

  case "$cur" in
    --conflict=*)
      __gitcomp "diff3 merge" "" "${cur##--conflict=}"
      ;;
    --*)
      __gitcomp "
      --quiet --ours --theirs --track --no-track --merge
      --conflict= --orphan --patch
      "
      ;;
    *)
      # check if --track, --no-track, or --no-guess was specified
      # if so, disable DWIM mode
      local flags="--track --no-track --no-guess" track=1
      if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
        track=''
      fi
      # only search local branches instead of remote branches if origin isn't
      # specified
      if [[ $cur == "origin/"* ]]; then
        __gitcomp_nl "$(__git_refs '' $track)"
      else
        __gitcomp_nl "$(__git_heads '' $track)"
      fi
      ;;
  esac
}

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/bash_profile.post.bash" ]] && . "$HOME/.fig/shell/bash_profile.post.bash"
