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
echo "adding bashrc"
. ~/.bashrc
fi

# MacOS
if [ "$machine" = "Mac" ]
then
	echo "Applying Mac-specific settings"

	if [ -f $HOME/.homesick/repos/homeshick/homeshick.sh ]; then
		source "$HOME/.homesick/repos/homeshick/homeshick.sh"
		export HOMESHICK_DIR=/usr/local/opt/homeshick
	else
		echo "homeshick not found"
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

	if [ -f /home/linuxbrew/.linuxbrew/opt/homeshick ]; then
		export HOMESHICK_DIR=/home/linuxbrew/.linuxbrew/opt/
		source "/home/linuxbrew/.linuxbrew/opt/homeshick/homeshick.sh"
	fi

	# set up git autocompletion prompt
	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_SHOWCOLORHINTS=true
	PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

fi

if [ -x /usr/bin/keychain ] ; then
        MYNAME=`/usr/bin/whoami`
        if [ -f ~/.ssh/${MYNAME}_at_linkedin.com_ssh_key ] ; then
              /usr/bin/keychain ~/.ssh/${MYNAME}_at_linkedin.com_ssh_key
              . ~/.keychain/`hostname`-sh
        fi
fi

# Set up Caps Lock -> Escape mapping
if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi


# User specific environment and startup programs

PATH=$PATH:$HOME/bin

# change Node default dir
export PATH=~/.npm-global/bin:$PATH

export NETREPO=svn+ssh://svn.corp.linkedin.com/netrepo/network
export LIREPO=svn+ssh://svn.corp.linkedin.com/lirepo
export VENREPO=svn+ssh://svn.corp.linkedin.com/vendor

export JAVA_HOME=/export/apps/jdk/JDK-1_8_0_121
export JDK_HOME=/export/apps/jdk/JDK-1_8_0_121
export NLS_LANG=American_America.UTF8

export M2_HOME=/local/maven
export M2=$M2_HOME/bin

export PATH=/export/apps/xtools/bin:$PATH:$JAVA_HOME/bin:/usr/local/bin:/usr/local/mysql/bin:/usr/local/linkedin/bin
PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

export VOLTA_HOME="/Users/dalawren/.volta"
grep --silent "$VOLTA_HOME/bin" <<< $PATH || export PATH="$VOLTA_HOME/bin:$PATH"
