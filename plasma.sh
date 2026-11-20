#!/usr/bin/env bash

tput setaf 3
echo "###############################################################################"
echo "##################  Installing package Plasma Desktop"
echo "###############################################################################"
echo
tput sgr0

cd "${HOME}"
mkdir git
cd git
echo "CLONING: YAY"
git clone "https://aur.archlinux.org/yay.git"
cd yay
makepkg -si --noconfirm


func_install() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	        echo "###############################################################################"
      	        echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	yay -S --noconfirm --needed $1
    fi
}

###############################################################################
echo "Installation of the core software"
###############################################################################

list=(
#audio
pipewire
wireplumber
pipewire-alsa
pipewire-pulse
pipewire-audio

#org-sercer and desktop
xorg-server
xorg-xinit
#egl-wayland #needed for NVIDIA card

# DE and WM
sddm
plasma-meta
konsole
xdg-desktop-portal-kde 
#dolphin-plugins

#utilities
cups
cups-pdf
gutenprint
simple-scan
ark
unzip
unrar
flatpak
gvfs-mtp
firewalld

#bluetooth
bluez
bluez-utils
bluez-libs
bluedevil

#apps
keepassxc
steam

# fonts
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
ttf-ubuntu-font-family
)

for name in "${list[@]}" ; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	echo "################################################################"
	sleep 1
	func_install $name
done

tput setaf 3
echo "###############################################################################"
echo "##################  Installing Flatpak apps"
echo "###############################################################################"
echo
tput sgr0

flatpak install flathub org.libreoffice.LibreOffice
flatpak install flathub org.kde.kalk
##############################################################################

sudo systemctl enable cups
sleep 1
sudo systemctl enable bluetooth
sleep 1
sudo systemctl enable sddm.service
sleep 1
#sudo systemctl enable reflector.service
#sleep 1
#sudo systemctl enable reflector.timer
#sleep 1
sudo systemctl mask systemd-rfkill.socket
sleep 1
sudo systemctl mask systemd-rfkill.service
sleep 1

# making a swapfile
#sleep 1
#	echo "################################################################"
#	tput setaf 3;echo "Creating Swapfile"; tput sgr0;
#	echo "################################################################"
#sleep 1

#sudo btrfs filesystem mkswapfile --size 8g --uuid clear /.swap/swapfile
#sleep 3
#sudo swapon /.swap/swapfile
#sleep 3
#sudo echo "/.swap/swapfile   none   swap   defaults  0 0" | sudo tee -a /etc/fstab
#sleep 3
#sudo systemctl daemon-reload
#sleep 3
#sudo mount -av
#sleep 3
#free -h

sleep 1
	echo "################################################################"
	tput setaf 3;echo "Installation complete"; tput sgr0;
	echo "################################################################"
sleep 1
