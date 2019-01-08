# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export JAVA_HOME=$(/usr/libexec/java_home)
export ANDROID_HOME=/Users/Charles/Library/Android/sdk
export PATH=/usr/local/opt/mysql@5.7/bin:$PATH
export GPG_TTY=$(tty)

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ruby autojump mvn copydir cp history colored-man-pages sublime colorize rsync zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
alias lls="ls -lhSr"
alias llt="ls -lst"
alias lld="ls -lhF | grep "/$""
alias cds="/Users/Charles/Documents/workspace/Scripts"
alias cdw="/Users/Charles/Documents/workspace"
alias cdd="/Users/Charles/Downloads"
alias bs="brew services"
alias pip="python -m pip"
alias pip3="python3 -m pip"
alias diff="icdiff"
alias diffn="icdiff --line-numbers"
alias free="top -l 1 | head -n 10 | grep PhysMem"
alias gsync="gco develop;git pull;gco release;git pull;gco master;git pull;"
# Quote Of The Day
echo "============================== Quote Of The Day =============================="
fortune | lolcat
echo "=============================================================================="
echo
# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# eos commands
alias myeos='docker exec -it eosio bash'
alias eosiocpp='/Users/Charles/Documents/workspace/eos/build/tools/eosiocpp'
# alias cleos='docker exec -it eosio /opt/eosio/bin/cleos -u http://localhost:8888'
alias cleos="/usr/local/bin/cleos --wallet-url http://127.0.0.1:6666 --url http://127.0.0.1:8000"

function eos_env_switch() {
    local env=$1
    case $env in
    "local")
        alias cleos="/usr/local/bin/cleos --wallet-url http://127.0.0.1:6666 --url http://127.0.0.1:8000"
        ;;
    "test")
        alias cleos="/usr/local/bin/cleos --wallet-url http://127.0.0.1:6666 --url http://test-chain.ruffcorp.com:8888"
        ;;
    "staging")
        alias cleos="/usr/local/bin/cleos --wallet-url http://127.0.0.1:6666 --url http://staging-chain.ruffcorp.com:8888"
        ;;
    "prod")
        alias cleos="/usr/local/bin/cleos --wallet-url http://127.0.0.1:6666 --url http://chain.ruffcorp.com:8000"
        ;;
    esac
}

# kubectl logs
function kl() {
    local env=$1
    local svc=$2
    local pod
    [[ -z $3 ]] && pod=1 || pod=$3
    printf "\e[1;32mEnvrioment:\e[0m \e[1;46m【${env}】\e[0m \e[1;32mService:\e[0m \e[1;46m【${svc}】\e[0m\n"
    #echo "Envrionment=${env} / Service=${svc}"
    local pods="kubectl -n ${env} get pods | grep ${svc} | awk '{print \$1}'"
    eval $pods
    local cmd="${pods} | awk 'NR==${pod}{print;}' | xargs kubectl -n ${env} logs -f"
    printf "\e[1;32mCommand:\e[0m \e[1;46m${cmd}\e[0m\n"
    #echo "Command: ${cmd}"
    eval $cmd
}

# kubectl delete pod
function kdp() {
    local env=$1
    local state=$2
    printf "\e[1;32mEnvrioment:\e[0m \e[1;46m【${env}】\e[0m\n"
    local cmd="kubectl get pods -n ${env} | grep ${state} | awk '{print \$1}' | xargs -t -I {} kubectl delete pods --grace-period=0 --force -n ${env} {}"
    printf "\e[1;32mCommand:\e[0m \e[1;46m${cmd}\e[0m\n"
    eval $cmd
}

# kubectl delete svc
function kds() {
    local env=$1
    printf "\e[1;32mEnvrioment:\e[0m \e[1;46m【${env}】\e[0m\n"
    local arr=($(kubectl get svc -n $env | awk 'NR!=1{print $1}' | tr -s "\n" " "))
    printf "\e[1;32mServices:\e[0m \e[1;46m${arr}\e[0m\n"
    for acc in $arr; do kubectl -n $env delete svc $acc; done;
}

# kubectl scale zero
function ksz() {
    local env=$1
    printf "\e[1;32mEnvrioment:\e[0m \e[1;46m【${env}】\e[0m\n"
    local arr=($(kubectl get deploy -n $env | awk 'NR!=1 && $3!=0 {print $1}' | tr -s "\n" " "))
    printf "\e[1;32mDeployments:\e[0m \e[1;46m${arr}\e[0m\n"
    for acc in $arr;do kubectl -n $env scale deploy $acc --replicas=0;done;
    kubectl get deploy -n $env
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}";
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}
