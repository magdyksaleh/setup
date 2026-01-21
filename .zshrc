
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load a theme from this variable instead of looking in ~/.oh-my-zsh/themes/ If set to an empty array, this variable will have no effect.
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
DISABLE_UNTRACKED_FILES_DIRTY="false"

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

# For k8s bash prompt enable kube-ps1
# plugins=(git zsh-autosuggestions kube-ps1)
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
source ~/.envvars.sh

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
alias k='kubectl'
alias kcgp='kubectl get pods'
alias ffile='find . | grep'
alias docker-clean="docker stop \$(docker ps -aq)"
alias vf='vim $(fzf)'

alias ta="tmux a "
alias tls="tmux ls"
alias sc="systemctl"
alias lg="lazygit"
alias predigo="cd ~/predibase/server && source ../scripts/local_env.sh && go build && ./predibase"
alias rdb="ray debug"
alias rsv="cd ~/predibase/engine && source ../scripts/local_env.sh && python predibase_engine/ray_serve.py --local --activities"
alias branches="git branch --sort=-committerdate | cat | fzf"
alias kex='k exec -it $(/Users/magdy/scripts/get_pods_fzf.sh) -- bash'
alias kd='k describe pod $(/Users/magdy/scripts/get_pods_fzf.sh)'
alias kl='k logs $(/Users/magdy/scripts/get_pods_fzf.sh)'
alias klf='k logs $(/Users/magdy/scripts/get_pods_fzf.sh) -f'
alias kx="kubectx"
alias kn="kubens"
alias awsenv="python /Users/magdy/aws-envs/env-selector.py"
alias localsetup="python /Users/magdy/scripts/local-setup.py /Users/magdy/predibase"
alias gcb='git checkout $(branches)'
alias c='clear'
alias vim='nvim'
alias uvr='uv run'
alias django='uv run manage.py'

alias migrate='uvr manage.py migrate'
alias runserver='uvr manage.py runserver'
alias makemigration='uvr manage.py makemigration'
alias djshell='uvr manage.py shell'

source ~/.cargo/env

alias ludwigEnv=". ~/.virtualenvs/ludwig/bin/activate"

# source ~/.virtualenvs/ludwig/bin/activate
# source ~/.virtualenvs/py38env/bin/activate
# source ~/.virtualenvs/py39env/bin/activate
# source ~/.virtualenvs/intTestEnv/bin/activate
# source ~/.virtualenvs/engineEnv/bin/activate
# source ~/.virtualenvs/loraxenv/bin/activate

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# k8s autocomplete 
# source <(kubectl completion zsh)
# PROMPT='$(kube_ps1):'$PROMPT

engine-logs () {
  kubectl exec -it $1 -- /bin/bash -c "cat /tmp/ray/session_latest/logs/*.out"
}

istio-endpoints() {
  current_namespace=`kubectl config view --minify -o jsonpath='{..namespace}'`
  istioctl proxy-config endpoint $1.$current_namespace
}

istio-debug () {
  istioctl x envoy-stats $1 --type clusters
}

ked() {
  k edit deployment $(`k get deployments --no-headers | fzf | awk '{print $1}'`)
}

gateway-logs() {
  for pod in `kubectl get pods | grep "gateway" | awk '{print $1}'`; do
    kubectl logs $pod
  done
}

forward-engines() {
  sudo kubefwd svc -l ray.io/node-type=head
}

forward-temporal-ui() {
  sudo kubefwd svc -l app.kubernetes.io/component=web
  current_namespace=`kubectl config view --minify -o jsonpath='{..namespace}'`
}

t() {
  export PREDIBASE_API_TOKEN="$1"
}

senv() {
  source ~/.virtualenvs/$(ls ~/.virtualenvs -1 | fzf)/bin/activate
}

. "$HOME/.local/bin/env"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/magdy/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/magdy/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/magdy/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/magdy/google-cloud-sdk/completion.zsh.inc'; fi

source ~/fawkes/server/.venv/bin/activate
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Added by Antigravity
export PATH="/Users/magdy/.antigravity/antigravity/bin:$PATH"
