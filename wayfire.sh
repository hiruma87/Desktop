#!/usr/bin/env bash

tput setaf 3
echo "###############################################################################"
echo "##################  Installing package Plasma Desktop"
echo "###############################################################################"
echo
tput sgr0
# installing aur helper yay
cd "${HOME}"
mkdir git
cd git
echo "CLONING: YAY"
git clone "https://aur.archlinux.org/yay.git"
cd yay
makepkg -si --noconfirm

# installing wayfire from source
#git clone https://github.com/WayfireWM/wf-install
#cd wf-install

#./install.sh --prefix /opt/wayfire --stream master

# to update
# ./update_build.sh . master
