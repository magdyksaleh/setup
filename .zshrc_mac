
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export DJANGO_SETTINGS_MODULE=zenapi.settings_local
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/magdy/.local/bin:/usr/local/cuda-10.2/bin"
export LD_LIBRARY_PATH="/usr/local/"
export BUCKET_ROOT="gridspace-models-dev"
export MANIFEST_PATH="/home/magdy/dossier/zenapi/server/base/models-manifest.txt"
export TARGET_DIR="/home/magdy/dossier/_dockercache/nlpbin"
export MODELS_ROOT_DIR="/home/magdy/dossier/_dockercache/nlpbin"
export EDITOR=vim
export PATH=$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH
source ~/.virtualenvs/pyenv/bin/activate

export USE_CUSTOM_USAA_W2V=1
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# enable color support of ls and also add handy aliases
# alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# custom aliases
alias dossier='cd /home/magdy/dossier'
alias kc='kubectl'
alias kcgp='kubectl get pods'
alias ffile='find . | grep'
alias glog='python /Users/magdy/dossier/tools/glog/glog.py'
alias zenapi='cd /home/magdy/dossier/zenapi'
alias docker-clean="docker stop \$(docker ps -aq)"
alias run_native="docker-clean; cd && python ~/dossier/tools/local_cluster.py && cd - "
alias vf='vim $(fzf)'

alias ta="tmux a "
alias tls="tmux ls"
alias deploy="/Users/magdy/dossier/management/kubernetes/deploy_sift.py" 
alias test_aws="python /home/magdy/Documents/testing/call_amazon_via_api.py"
alias webrtc_clean="ps -ax | grep webrtc | awk '{print $1}' | xargs kill"
alias sc="systemctl"

# Add an "alert" alias for long running commands.  Use like so:
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
function p () {
   if pwd | grep 'zenapi'; then
		/home/magdy/dossier/zenapi/manage.py shell
   else
      ipython
   fi
}  

if [ /home/magdy/google-cloud-sdk/bin/kubectl ]; then source <(kubectl completion zsh); fi

e () {
   local NETWORK_NAME=$(/Sy*/L*/Priv*/Apple8*/V*/C*/R*/airport -I | awk '/ SSID:/ {print $2}')
   if [[ $NETWORK_NAME == "Grindspace" ]]
   then 
      ssh magdy@skynet3
   else
      tsh ssh --proxy=teleport2.gridspace.com:3080 --cluster=bigboi magdy@skynet3
   fi
}


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/magdy/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/magdy/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/magdy/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/magdy/google-cloud-sdk/completion.zsh.inc'; fi
