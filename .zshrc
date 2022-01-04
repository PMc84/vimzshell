# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gnzh"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
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
# DISABLE_MAGIC_FUNCTIONS="true"

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  rbenv
  ruby
)

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export EDITOR=vim

# Oracle config
export httpproxy=http://www-proxy-adcq7-new.us.oracle.com:80/
export httpsproxy=http://www-proxy-adcq7-new.us.oracle.com:80/
export no_proxy='localhost,127.0.0.1,.oracle.com,.oraclecorp.com,.grungy.us'

export EMAIL_ADDRESS="peter.mccourt@oracle.com"
export PIP_TRUSTED_HOST=artifactory.oci.oraclecorp.com
export PIP_INDEX_URL=https://artifactory.oci.oraclecorp.com/api/pypi/global-release-pypi/simple/
export PIP_EXTRA_INDEX_URL=https://artifactory.oci.oraclecorp.com/api/pypi/io-dev-pypi-local/simple
export NCPCLI_VENV=$HOME/workspaces/venv/ncpcli

export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"


reload-ssh() {
   ssh-add -e /usr/local/lib/opensc-pkcs11.so >> /dev/null
   if [ $? -gt 0 ]; then
       echo "Failed to remove previous card"
   fi
   ssh-add -s /usr/local/lib/opensc-pkcs11.so
}

activate-hqt() {
  source ~/.hqt/venv/bin/activate
}

# sccp-java-cli() {
#  java -Djavax.net.ssl.trustStoreType=KeychainStore -jar sccp-java-cli-v99.jar
# }

export VAGRANT_SERVER_URL=https://artifactory.oci.oraclecorp.com:443/api/vagrant
export VAGRANT_USE_VAGRANT_TRIGGERS=no # this turns off the native triggers
export CHEF_LICENSE='accept'

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

export PATH="/usr/local/opt/terraform@0.12/bin:$PATH"

export JAVA_HOME=$(/usr/libexec/java_home -v1.8)

function kitchen-fulltest(){
    rm -f Berksfile.lock Policyfile.lock.json

    kitchen destroy all || return 1
    kitchen create || return 1
    kitchen converge || return 1

    kitchen-verify || return 1
    kitchen converge || return 1
    kitchen verify || return 1
}

# kitchen verify will try to install busser and friends (if the verifier is set to serverspec) on the VM, but this only partially succeed.
# run kitchen-fixup to fix the busted busser installation (then subsequent calls to kitchen verify will succeed)
function kitchen-fixup(){
    local GEM_HOME=/var/tmp/busser/gems
    kitchen exec $@ -c "sudo rm -f /var/tmp/busser/gems/specifications/rspec-{core,support}-*.gemspec"
    kitchen exec $@ -c "sudo sh -c \"GEM_HOME=${GEM_HOME} GEM_PATH=${GEM_HOME} GEM_CACHE=${GEM_HOME}/cache /opt/chef/embedded/bin/ruby -e 'require %q(busser); require %q(busser/rubygems); Busser::RubyGems.install_gem(%q(bundler), %q(~> 1.17.0)); Busser::RubyGems.install_gem(%q(rspec-core), %q(~> 3.8.0)); Busser::RubyGems.install_gem(%q(rspec-support), %q(~> 3.8.0))'\""
}

function kitchen-verify (){
  # don't run kitchen-fixup if the verifier is set to inspec in .kitchen.yml
  if grep -q inspec .kitchen.yml; then
    kitchen verify $@
  else
    kitchen verify $@ >/dev/null 2>&1
    kitchen-fixup $@ && kitchen verify $@
  fi
}

alias vagrant-destroy-all='vagrant global-status | awk '\''$3 == "virtualbox" { print $1 }'\'' | xargs -n1 vagrant destroy -f'
function vbox-destroy-all(){
    VBoxManage list vms \
        | sed 's/.*{\([^}]*\)}/\1/' \
        | while read -r uuid; do
            VBoxManage controlvm "$uuid" poweroff
            VBoxManage unregistervm --delete "$uuid"
        done
}
eval "$(pyenv init -)"
alias mfo="export OPERATOR_ACCESS_TOKEN=$(jit-manager.py -m jwt -e operator-access-token.svc.ad1.r2); java -jar ~/bo-peep/mfo-cli.jar"
