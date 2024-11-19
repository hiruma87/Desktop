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
plasma-desktop
plasma-nm
plasma-systemmonitor
drkonqi
kde-gtk-config
kdeaplasma-addons
kgamma
kinfocenter
kscreen
kwrited
ocean-sound-theme
oxygen
oxygen-sounds
plasma-disks
plasma-welcome
plasma-workpace-wallpapers
powerdevil
sddm-kcm
xdg-deaktop-portal-kde
flatpak-kcm
phonon-vlc
kio-admin
kio-extras
kio-fuse
kio-gdrive
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
wget
print-manager
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
pipewire-jack
pipewire-pulse
libpulse
gst-plugin-pipewire
#apps
konsole
kate
ark
discover
dolphin
firefox
opera
thunderbird
dolphin-plugins
ffmpegthumbs
power-profiles-daemon
xsettingsd
#fonts
noto-sans
noto-color-emoji
noto-fonts-cjk
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
sudo systemctl enable bluetooth
sudo systemctl enable sddm.service
sudo systemctl enable reflector.service
sudo systemctl enable reflector.timer
sudo systemctl mask systemd-rfkill.socket
sudo systemctl mask systemd-rfkill.service
sudo systemctl enable upower
sleep 3
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
	echo "################################################################"
	tput setaf 3;echo "Installing complete"; tput sgr0;
	echo "################################################################"
sleep 1
