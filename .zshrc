# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

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
COMPLETION_WAITING_DOTS="true"

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

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Lazy load NVM to speed up init
export NVM_COMPLETION=true

alias bco="better-commits"
alias zshrc="code ~/.zshrc"
alias dotfiles="code ~/.dotfiles"
if command -v espanso &> /dev/null; then
  ESPANSO_PATH=$(espanso path config)
  alias espanso-edit="code \$ESPANSO_PATH/."
fi

# Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  [ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
fi

if [[ ! -f "$HOME/.antigen.zsh" ]]; then
  curl -L git.io/antigen > ~/.antigen.zsh
fi
source "$HOME/.antigen.zsh"

# Antigen
# Uncomment to log antigen output
# export ANTIGEN_LOG=$HOME/antigen.log
antigen use oh-my-zsh

antigen bundle git
antigen bundle olets/zsh-abbr@main
antigen bundle wfxr/forgit
antigen bundle lukechilds/zsh-better-npm-completion
antigen bundle sudo
antigen bundle dirhistory
antigen bundle lukechilds/zsh-nvm


if ! command -v oh-my-posh &> /dev/null; then
  antigen theme romkatv/powerlevel10k

fi

antigen apply

if ! command -v oh-my-posh &> /dev/null; then
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
else
  eval "$(oh-my-posh init zsh --config ~/.oh-my-posh.json)"
fi


export PATH="$HOME/.local/bin:$PATH"



# fzf
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
  export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'

  gch() {
    GCH_BRANCH=$(git branch --all | fzf | tr -d '[:space:]')
    # Add to history
    print -S "git checkout $GCH_BRANCH"
    git checkout "$GCH_BRANCH"
  }
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if command -v pyenv &> /dev/null; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# ng completions
if command -v ng version &> /dev/null; then 
  source <(ng completion script)
fi

# alias apt to nala
if command -v nala &> /dev/null; then
  apt() { 
    command nala "$@"
  }
  sudo() {
    if [ "$1" = "apt" ]; then
      shift
      command sudo nala "$@"
    else
      command sudo "$@"
    fi
  }
fi