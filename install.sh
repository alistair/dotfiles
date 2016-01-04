#!/bin/bash

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
