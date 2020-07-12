#!/bin/bash

set -e

basedir=$(cd "$(dirname "$0")" && pwd)
dirlist=$(find "$basedir" \
               -maxdepth 1 \
               -mindepth 1 \
               -type d \
               -not -name '.*' \
              | sed 's/[^/]*\///g'
       )

for d in $dirlist; do
    echo installing "$d"
    install_script=$basedir/$d/install.sh
    if [ -x "$install_script" ]; then
        $install_script || echo "ERROR: $install_script"
    fi
    stow \
        --dir "$basedir" \
        --target "$HOME" \
        --ignore 'private-packages' \
        --ignore 'install.sh' \
        --ignore '^[^\.].*' \
        "$d"
done

stow \
  --dir "$basedir/spacemacs" \
  --target "$HOME"/.emacs.d/private \
  "private-packages"

exit 0

#  mkdir -p ~/.emacs.d/private
#  git clone https://github.com/cydparser/spacemacs-intero.git ~/.emacs.d/private/intero

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
echo "deb http://download.mono-project.com/repo/ubuntu stable-$(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/mono-offical-stable.list

version="$(lsb_release -rs)"
tmp_file="$(tmpfile)"

curl https://packages.microsoft.com/config/ubuntu/${version}/packages-microsoft-prod.deb -o "${tmpfile}"
sudo dpgk -i "${tmpfile}"

sudo add-apt-repository multiverse

sudo apt-get update
sudo apt-get install -y docker-ce dotnet-sdk-2.1 chromium-browser spotify-client steam mono-devel

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
