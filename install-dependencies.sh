type apt-get &> /dev/null && sudo add-apt-repository ppa:kelleyk/emacs && \
    sudo apt-get update

type apt-get &> /dev/null && sudo apt-get install -y \
    python3-dev \
    build-essential \
    cmake \
    vim-nox \
    tmux \
    stow \
    zsh \
    ctags \
    shellcheck \
    silversearcher-ag \
    jq \
    socat \
    tmux \
    keychain \
    emacs27 \
    tree \
    python3-pip \
    sqlite3 \
    graphviz \
    ripgrep

type brew &> /dev/null && brew install \
    python3 \
    cmake \
    vim \
    tmux \
    stow \
    zsh \
    ctags \
    shellcheck \
    ag \
    jq \
    socat \
    keychain \
    nvm \
    sqlite3 \
    gprof2dot \
    ripgrep \
    && brew tap homebrew/cask-fonts && brew cask install font-source-code-pro emacs

pip3 install awscli
