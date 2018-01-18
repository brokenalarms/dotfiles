
source "$HOME/.homesick/repos/homeshick/homeshick.sh"

homeshick --quiet refresh
export PATH=$PATH:/usr/local/linkedin/bin
export PATH=$PATH:/export/content/linkedin/bin

# RHEL machine-specific settings
if [ $(hostname) = "dalawren-ld1" ]; then
    export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
fi
