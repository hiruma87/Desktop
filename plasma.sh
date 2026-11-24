#!/usr/bin/env bash


#Search for connection name
nmcli connection show --active
sleep 1
#Set the DNS
sudo nmcli connection modify "Wired connection 1" ipv4.dns "8.8.8.8 8.8.4.4"
sleep 1
#Remove autoDns
sudo nmcli con mod "Wired connection 1" ipv4.ignore-auto-dns yes
sleep 1
sudo nmcli con mod "Wired connection 1" ipv6.method "disabled"
sleep 1
#Reset the network Connection
sudo nmcli connection down "Wired connection 1"
sleep 1
sudo nmcli connection up "Wired connection 1"
sleep 1

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
gst-plugin-pipewire

#org-sercer and desktop
wayland
xorg-xwayland
#xorg-server
#xorg-xinit
#egl-wayland #needed for NVIDIA card

# DE and WM
#sddm
aurorae
breeze
breeze-gtk
discover
drkonqi
flatpak-kcm
kactivitymanagerd
kde-cli-tools
kde-gtk-config
kdecoration
kdeplasma-addons
kglobalacceld
kinfocenter
kmenuedit
knighttime
kpipewire
krdp
kscreen
kscreenlocker
ksshaskpass
ksystemstats
kup
kwayland
kwin
kwrited
layer-shell-qt
libkscreen
libksysguard
libplasma
milou
ocean-sound-theme
plasma-activities
plasma-activities-stats
plasma-browser-integration
plasma-desktop
plasma-disks
plasma-firewall
plasma-integration
plasma-keyboard
plasma-login-manager
plasma-pa
plasma-systemmonitor
plasma-workspace
polkit-kde-agent
powerdevil
print-manager
spectacle
systemsettings
union
xdg-desktop-portal-kde
konsole
dolphin
dolphin-plugins
xdg-desktop-portal-kde 
#dolphin-plugins

#utilities
cups
cups-pdf
gutenprint
skanpage
ark
unzip
unrar
flatpak
isoimagewriter #usb image writer
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
protonplus
firefox
smplayer #media player
#haruna #wayland focus media player
elisa #music player
#amarok #full-build music collection manager for sumple player elisa
kalk
kate
libreoffice-fresh

# fonts
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
ttf-ubuntu-font-family
otf-firamono-nerd
)

for name in "${list[@]}" ; do
	count=$[count+1]
	echo "################################################################"
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	echo "################################################################"
	sleep 1
	func_install $name
done

#tput setaf 3
#echo "###############################################################################"
#echo "##################  Installing Flatpak apps"
#echo "###############################################################################"
#echo
#tput sgr0

#flatpak install flathub org.libreoffice.LibreOffice
#flatpak install flathub org.kde.kalk
##############################################################################

sudo systemctl enable cups.service
sleep 1
sudo systemctl enable bluetooth.service
sleep 1
#sudo systemctl enable sddm.service
sudo systemctl enable plasmalogin.service
sleep 1
sudo systemctl enable firewalld.service
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
