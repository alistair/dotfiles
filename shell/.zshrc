# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

source "${HOME}/.path"
source "${HOME}/.shell_env"
source "${ZSH}/oh-my-zsh.sh"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git rsync tmux tmuxinator z docker)

autoload -U compinit
compinit
[ -f "/home/alistair/.ghcup/env" ] && source "/home/alistair/.ghcup/env" # ghcup-env
