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
libpulse
gst-plugin-pipewire
#org-sercer and desktop
xorg-server
xorg-xinit
egl-wayland
# DE and WM
sddm
sddm-kcm
plasma-meta
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
wireless_tools
inotify-tools
#gvfs-ntfs
gvfs-mtp
#bluetooth
bluez
bluez-utils
bluez-libs
bluedevil
#apps
firefox
opera
thunderbird
keepassxc
smplayer
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
flatpak install flathub net.davidotek.pupgui2
flatpak install flathub org.kde.kalk
flatpak install flathub com.felipekinoshita.Kana
flatpak install flathub com.belmoussaoui.Decoder

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
