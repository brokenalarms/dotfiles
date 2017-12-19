# Get the aliases and functions
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
PATH="$(printf "%s" "${PATH}" | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')"
# MacOS
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion.d/git-completion.bash
    source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
fi

# RHEL
if [ -f ~/.git-completion.sh ]; then
    source ~/.git-completion.bash
fi

# set up git autocompletion prompt
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

if [ -x /usr/bin/keychain ] ; then
        MYNAME=`/usr/bin/whoami`
        if [ -f ~/.ssh/${MYNAME}_at_linkedin.com_ssh_key ] ; then
              /usr/bin/keychain ~/.ssh/${MYNAME}_at_linkedin.com_ssh_key
              . ~/.keychain/`hostname`-sh
        fi
fi

export NETREPO=svn+ssh://svn.corp.linkedin.com/netrepo/network
export LIREPO=svn+ssh://svn.corp.linkedin.com/lirepo
export VENREPO=svn+ssh://svn.corp.linkedin.com/vendor

export JAVA_HOME=/export/apps/jdk/JDK-1_8_0_121
export JDK_HOME=/export/apps/jdk/JDK-1_8_0_121
export NLS_LANG=American_America.UTF8

export M2_HOME=/local/maven
export M2=$M2_HOME/bin

export PATH=/export/apps/xtools/bin:$PATH:$JAVA_HOME/bin:/usr/local/bin:/usr/local/mysql/bin:/usr/local/linkedin/bin

# Set up Caps Lock -> Escape mapping
if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

