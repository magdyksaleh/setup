# ---- OH MY ZSH ---- 
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_UNTRACKED_FILES_DIRTY="false"
HIST_STAMPS="mm/dd/yyy"
plugins=(git zsh-autosuggestions)
DISABLE_AUTO_UPDATE="true"
ZSH_DISABLE_COMPFIX="true"
source $ZSH/oh-my-zsh.sh

source ~/.envvars.sh

# Aliases - grep
alias grep='grep --color=auto'

# Aliases - ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Aliases - tools
alias k='kubectl'
alias ffile='find . | grep'
alias docker-clean="docker stop \$(docker ps -aq)"
alias ta="tmux a "
alias tls="tmux ls"
alias sc="systemctl"
alias lg="lazygit"
alias vim='nvim'

# Aliases - kubernetes
alias kex='k exec -it $(/Users/magdy/scripts/get_pods_fzf.sh) -- bash'
alias kd='k describe pod $(/Users/magdy/scripts/get_pods_fzf.sh)'
alias kl='k logs $(/Users/magdy/scripts/get_pods_fzf.sh)'
alias klf='k logs $(/Users/magdy/scripts/get_pods_fzf.sh) -f'
alias kx="kubectx"
alias kn="kubens"
alias branches="git branch --sort=-committerdate | cat | fzf"
alias gcb='git checkout $(branches)'

# Aliases - Django/Python
alias uvr='uv run'
alias django='uv run manage.py'
alias migrate='uvr manage.py migrate'
alias runserver='uvr manage.py runserver'
alias makemigrations='uvr manage.py makemigrations'
alias djshell='uvr manage.py shell'

# Cargo
source ~/.cargo/env

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# NVM - lazy loaded for faster shell startup
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm node npm npx
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
  nvm "$@"
}
node() { nvm use default; node "$@"; }
npm() { nvm use default; npm "$@"; }
npx() { nvm use default; npx "$@"; }

# Kubernetes edit deployment
ked() {
  k edit deployment $(k get deployments --no-headers | fzf | awk '{print $1}')
}

. "$HOME/.local/bin/env"

# Google Cloud SDK
if [ -f '/Users/magdy/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/magdy/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/magdy/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/magdy/google-cloud-sdk/completion.zsh.inc'; fi

# Antigravity
export PATH="/Users/magdy/.antigravity/antigravity/bin:$PATH"

# Key bindings - word navigation
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
