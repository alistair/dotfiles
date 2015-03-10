#!/bin/bash

function link_file() {
  local source="${PWD}/${1}"
  local target="${HOME}/${1/_/.}"

  rm -f "${target}"
  ln -sfv "${source}" "${target}"
}

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
