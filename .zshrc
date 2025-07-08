# The update_path function adds a specified directory to the PATH environment variable if the directory exists and is not already included in PATH. 
function update_path() {
  local new_dir="$1"

  # Check if the directory exists
  if [[ -d "$new_dir" ]]; then
      # Check if the directory is already in PATH
      if [[ ":$PATH:" != *":$new_dir:"* ]]; then
          export PATH="$new_dir:$PATH"
          echo "Added $new_dir to PATH."
      fi
  else
      echo "Directory $new_dir does not exist."
  fi
}

# The checkpath function displays the directories in the PATH environment variable, each on a new line, sorted alphabetically.
function checkpath(){
    echo "${PATH//:/$'\n'}" | sort
}

update_path "/snap/bin"
update_path "$HOME/bin"
update_path "$HOME/.local/bin"
update_path "/usr/local/bin"
update_path "/usr/games"
update_path "$HOME/.cargo/bin"

# Export for Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun
[ -s "/home/dgnsrekt/.bun/_bun" ] && source "/home/dgnsrekt/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun end

# pnpm
export PNPM_HOME="/home/dgnsrekt/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# SDKMAN
# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Path to your oh-my-zsh installation.
export ZSH="/home/dgnsrekt/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
plugins=(git uv ssh starship)

source $ZSH/oh-my-zsh.sh

# User configuration
#
export VISUAL=vim
export EDITOR="$VISUAL"

export GPG_TTY=$(tty) # for GPG keys

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
alias vim="/snap/bin/nvim"
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.config/nvim/"
alias osconfig="vim ~/InstallOS/"
alias ghosttyconfig="vim ~/.config/ghostty/config"
alias sgptconfig="vim ~/.config/shell_gpt/.sgptrc"
alias neofetchconfig="vim ~/.config/neofetch/config.conf"
alias zshreload="exec zsh"
alias reloadzsh="exec zsh"
alias claude="~/.claude/local/claude"

#alias cat="batcat --paging=never"
alias bashtop="bpytop"

alias ll="ls -lah"
alias redmatrix="cmatrix -a -C red"
alias lolmatrix="cmatrix -a | lolcat"

alias tmux="zellij"
alias zmux="zellij"
#alias top="btm -b"
#alias htop="btm -b"

alias echopath="checkpath"
alias shell-gpt="sgpt"
alias shell-lama="sgpt --model ollama/mistral:7b-instruct --no-functions"
alias shell-gpt-gen-commit='git diff --cached | sgpt --code "Craft a concise, high-level commit message following best practices. Ensure the summary is under 72 characters and group smaller changes by topic. Skip reformatting changes and only describe sections with actual changes."'

alias docker-compose="docker compose"

function play_movie(){
    cvlc --fullscreen --no-video-title-show $1 vlc://quit
}

# Kubectl autocompletion / https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
#source <(kubectl completion zsh)

# Minikube autocompletion ?
#source <(minikube completion zsh)

# STARSHIP CROSS-SHELL PROMPT / https://starship.rs/
eval "$(starship init zsh)" 

clear
neofetch | lolcat

