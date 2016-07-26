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

  ZSH="" sh -c "$(HOME="${MYHOME}"; ZSH=""; curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  rm "${HOME}/.zshrc"
fi

if [[ ! -e "${HOME}/.nvm" ]]; then
  git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`
fi

if [[ -n "$(grep ubuntu /etc/os-release)" && ! -e "${HOME}/.rbenv" ]]; then
  git clone https://github.com/rbenv/rbenv.git "${HOME}/.rbenv"
  git clone https://github.com/rbenv/ruby-build.git "${HOME}/.rbenv/plugins/ruby-build"
  pushd "${HOME}/.rbenv" &> /dev/null
    src/configure && make -C src
  popd &> /dev/null
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
