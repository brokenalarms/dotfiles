# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
if [ -x /usr/bin/keychain ] ; then
        MYNAME=`/usr/bin/whoami`
        if [ -f ~/.ssh/${MYNAME}_at_linkedin.com_ssh_key ] ; then
              /usr/bin/keychain ~/.ssh/${MYNAME}_at_linkedin.com_ssh_key
              . ~/.keychain/`hostname`-sh
        fi
fi
zstyle :omz:plugins:ssh-agent identities ${MYNAME}_at_linkedin.com_ssh_key
 
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

source ~/.alias	

export NETREPO=svn+ssh://svn.corp.linkedin.com/netrepo/network
export LIREPO=svn+ssh://svn.corp.linkedin.com/lirepo
export VENREPO=svn+ssh://svn.corp.linkedin.com/vendor

export JAVA_HOME=/export/apps/jdk/JDK-1_8_0_121
export JDK_HOME=/export/apps/jdk/JDK-1_8_0_121
export NLS_LANG=American_America.UTF8

export M2_HOME=/local/maven
export M2=$M2_HOME/bin

export PATH=/export/apps/xtools/bin:$PATH:$JAVA_HOME/bin:/usr/local/bin:/usr/local/mysql/bin:/usr/local/linkedin/bin
export PATH=$PATH:~/tools

unset LESS

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export HOMESHICK_DIR=/usr/local/opt/homeshick
source "/usr/local/opt/homeshick/homeshick.sh"
