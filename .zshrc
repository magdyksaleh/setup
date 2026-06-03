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
alias lt="lazytodo"
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
alias penv='source .venv/bin/activate'
alias ipython='uv run ipython'

# Cargo
source ~/.cargo/env

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# NVM - lazy loaded for faster shell startup
export NVM_DIR="$HOME/.nvm"
export PATH="$NVM_DIR/versions/node/v20.19.2/bin:$PATH"

{
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
} &!

# Kubernetes edit deployment
ked() {
  k edit deployment $(k get deployments --no-headers | fzf | awk '{print $1}')
}

pbf() { pbcopy < "$1"; }

. "$HOME/.local/bin/env"

# Google Cloud SDK
if [ -f '/Users/magdy/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/magdy/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/magdy/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/magdy/google-cloud-sdk/completion.zsh.inc'; fi

# Antigravity
export PATH="/Users/magdy/.antigravity/antigravity/bin:$PATH"

# Key bindings - word navigation
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

# opencode
export PATH=/Users/magdy/.opencode/bin:$PATH


# Change tmux pane background when running AI tools
_ai_tmux_enter() { [ -n "$TMUX" ] && tmux select-pane -P "bg=$1"; }
_ai_tmux_exit()  { [ -n "$TMUX" ] && tmux select-pane -P 'bg=default'; }

claude() { _ai_tmux_enter '#1e1b4b'; command claude "$@"; _ai_tmux_exit; }  # deep purple
codex()  { _ai_tmux_enter '#0a2e1a'; command codex  "$@"; _ai_tmux_exit; }  # deep green
