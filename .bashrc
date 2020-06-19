#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Some excerpt I found on StackOverflow for SSH agent auto-start that works.
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    #echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    #echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        rm -rf ${SSH_ENV}
        start_agent;
    }
else
    rm -rf ${SSH_ENV}
    start_agent;
fi

# Don't use Fish if $USE_BASH is defined
if [ ! -z "$USE_BASH" ]; then
  return
fi


# Check if $USE_FISH or $KITTY_WINDOW_ID (defined by Kitty) are defined, if so, automatically
# use fish then exit on return
if [ ! -z "$USE_FISH" -o ! -z "$KITTY_WINDOW_ID" ]; then
	/usr/bin/fish -i
	exit
fi
