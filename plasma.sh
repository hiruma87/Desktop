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
#org-sercer and desktop
xorg-server
xorg-xwayland
xorg-xinit
xorg-xwininfo
egl-wayland
sddm
plasma
plasma-workspace
print-manager
system-config-printer
konsole
dolphin
dolphin-plugins
#utilities
cups
cups-pdf
gutenprint
unzip
unrar
flatpak
grub-btrfs
btrfs-assistant
python-pipx
wireless_tools
inotify-tools
jq
#and graphic
mesa
lib32-mesa
vulkan-radeon
lib32-vulkan-radeon
libva
lib32-libva
libva-utils
#bluetooth
bluez
bluez-utils
bluez-libs
bluedevil
#audip
pipewire
wireplumber
pipewire-alsa
pipewire-pulse
libpulse
gst-plugin-pipewire
#apps
firefox
opera
thunderbird
keepassxc
# fonts
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
ttf-ubuntu-font-family
ttf-roboto
ttf-roboto-mono
)

for name in "${list[@]}" ; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	echo "################################################################"
	sleep 1
	func_install $name
done

##############################################################################

sudo systemctl enable cups
sleep 1
sudo systemctl enable bluetooth
sleep 1
sudo systemctl enable sddm.service
sleep 1
sudo systemctl enable reflector.service
sleep 1
sudo systemctl enable reflector.timer
sleep 1
sudo systemctl mask systemd-rfkill.socket
sleep 1
sudo systemctl mask systemd-rfkill.service
sleep 1
sudo systemctl enable upower
sleep 1
sudo systemctl enable grub-btrfsd.service
sleep 3

# making a swapfile
sleep 1
	echo "################################################################"
	tput setaf 3;echo "Creating Swapfile"; tput sgr0;
	echo "################################################################"
sleep 1

sudo btrfs filesystem mkswapfile --size 8g --uuid clear /.swap/swapfile
sleep 3
sudo swapon /.swap/swapfile
sleep 3
sudo echo "/.swap/swapfile   none   swap   defaults  0 0" | sudo tee -a /etc/fstab
sleep 3
sudo systemctl daemon-reload
sleep 3
sudo mount -av
sleep 3
free -h
sleep 1
sudo grub-mkconfig -o /boot/grub/grub.cfg

sleep 1
	echo "################################################################"
	tput setaf 3;echo "Installation complete"; tput sgr0;
	echo "################################################################"
sleep 1
