#!/bin/bash

##
# vim emacs git git-gui tig gitk keychain zsh
##

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function link_file() {
  local source="${DIR}/${1}"
  local target="${HOME}/${1/_/.}"

  rm -f "${target}"
  ln -sfv "${source}" "${target}"
}

ZSH_FILE="${HOME}/.zshrc"

if [[ ! -e "${HOME}/.oh-my-zsh" ]]; then
  if [[ -e "${ZSH_FILE}" ]]; then
    if [[ "$(readlink \"${ZSH_FILE}\")" == "${DIR}/_zshrc" ]]; then
      #remove and relink later so that the install doesn't change the file
      rm "${HOME}/.zshrc"
    fi
  fi

  export MYHOME=${HOME}

  sudo apt-get install zsh

  ZSH="" sh -c "$(HOME="${MYHOME}"; ZSH=""; curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  rm "${HOME}/.zshrc"
fi

if [[ ! -e "${HOME}/.emacs.d" ]]; then
  git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
  mkdir -p ~/.emacs.d/private
  git clone https://github.com/cydparser/spacemacs-intero.git ~/.emacs.d/private/intero
fi

if [[ ! -e "${HOME}/.nvm" ]]; then
  git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`
fi

if [[ -n "$(grep ubuntu /etc/os-release)" ]]; then

  sudo apt-get update
  sudo apt-get install -y keychain tmux zsh vim-gtk-py2 emacs

  if [[ ! -c "${HOME}/.rbenv" ]]; then
    git clone https://github.com/rbenv/rbenv.git "${HOME}/.rbenv"
    git clone https://github.com/rbenv/ruby-build.git "${HOME}/.rbenv/plugins/ruby-build"
    pushd "${HOME}/.rbenv" &> /dev/null
      src/configure && make -C src
    popd &> /dev/null
  fi

  sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo apt-key fingerprint 0EBFCD88
  sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
  echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list

  sudo sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list'
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893

  sudo add-apt-repository multiverse

  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886

  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

  sudo apt-get update
  sudo apt-get install -y docker-ce dotnet-dev-1.0.1 chromium-browser spotify-client steam

  curl -sSL https://get.haskellstack.org/ | sh

  if [[ ! -e "${HOME}/.fonts" ]]; then
    TMP_DIR="$(mktemp -d)"
    curl -L -o "${TMP_DIR}/sourcecodepro.zip" https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip
    unzip "${TMP_DIR}/sourcecodepro.zip" -d "${TMP_DIR}"
    rm "${TMP_DIR}/sourcecodepro.zip"
    mkdir -p "${HOME}/.fonts"
    mv "${TMP_DIR}"/* "${HOME}/.fonts/"
    sudo fc-cache -f -v
  fi
fi

for i in _*
do
  link_file "${i}"
done

bundle_dir="${HOME}/.vim/bundle"
plugin_dir="${HOME}/.vim/plugin"

mkdir -p "${bundle_dir}"
mkdir -p "${plugin_dir}"

if [[ ! -e "${bundle_dir}/neobundle.vim" ]]
then
  git clone git@github.com:Shougo/neobundle.vim.git "${bundle_dir}/neobundle.vim"
fi

pushd vim/plugin

for i in *
do
  HOME="${plugin_dir}" link_file "${i}"
done

popd
