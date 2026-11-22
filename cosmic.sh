#!/usr/bin/env bash
#-------------------------------------------------------------------------
#      _          _    __  __      _   _
#     /_\  _ _ __| |_ |  \/  |__ _| |_(_)__
#    / _ \| '_/ _| ' \| |\/| / _` |  _| / _|
#   /_/ \_\_| \__|_||_|_|  |_\__,_|\__|_\__|
#  Arch Linux Post Install Setup and Config
#-------------------------------------------------------------------------

echo
echo "INSTALLING AUR SOFTWARE"
echo

cd "${HOME}"
mkdir git
cd git
echo "CLONING: YAY"
git clone "https://aur.archlinux.org/yay-bin.git"
cd yay-bin
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

PKGS=(
#org-sercer and desktop
xorg-server
xorg-xinit
#egl-wayland #needed for NVIDIA card

#audio
pipewire
wireplumber
pipewire-alsa
pipewire-pulse
pipewire-audio
gst-plugin-pipewire

# DE and WM
cosmic
xdg-user-dirs
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

#bluetooth
bluez
bluez-utils
bluez-libs

#apps
keepassxc
steam
firefox

# fonts
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
ttf-ubuntu-font-family
)

for PKG in "${PKGS[@]}"; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $PKG;tput sgr0;
	echo "################################################################"
	func_install $PKG
    sleep 1
done

sudo systemctl enable cups
sleep 1
sudo systemctl enable bluetooth
sleep 1
#sudo systemctl enable reflector.service
#sleep 1
#sudo systemctl enable reflector.timer
#sleep 1
sudo systemctl mask systemd-rfkill.socket
sleep 1
sudo systemctl mask systemd-rfkill.service
sleep 1
#sudo systemctl enable grub-btrfsd.service
#sleep 1
sudo systemctl enable cosmic-greeter.service

sleep 1
#	echo "################################################################
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
#sleep 1
#sudo grub-mkconfig -o /boot/grub/grub.cfg
sleep 1
	echo "################################################################"
	tput setaf 3;echo "Installing complete"; tput sgr0;
	echo "################################################################"
sleep 1
