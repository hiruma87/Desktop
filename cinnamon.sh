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

PKGS=(
#basic cinnamon desktop
xorg-server
egl-wayland
xorg-xinit
lightdm
lightdm-slick-greeter
lightdm-settings
#uncomment for default greeter
# lightdm-gtk-greeter
# lightdm-gtk-greeter-settings
cinnamon
gnome-terminal
 #utilities
cups
cups-pdf
system-config-printer
gutenprint #canon driver
nemo-fileroller
unzip
unrar
flatpak
grub-btrfs
btrfs-assistant
wireless_tools
inotify-tools
mintlocale
cinnamon-translations
xdg-user-dirs-gtk
gvfs
gvfs-mtp
#bluetooth
bluez
bluez-utils
blueberry
bluez-libs
#audio
pipewire
wireplumber
pipewire-alsa
pipewire-jack
pipewire-pulse
libpulse
gst-plugin-pipewire
# applications
mintstick
xed
xviewer
xreader
gnome-disk-utility
simple-scan
smplayer
gufw
# internet
firefox
opera
thunderbird
keepassxc
# themes
mint-themes
mint-y-icons
mint-x-icons
# fonts
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
ttf-ubuntu-font-family
ttf-roboto
ttf-roboto-mono
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
sudo systemctl enable lightdm.service
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

# Change default lightdm greeter to slick-greeter
sleep 1
	echo "################################################################"
	tput setaf 3;echo "Change default lightdm greeter to slick-greeter"; tput sgr0;
	echo "################################################################"
sleep 1

sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-slick-greeter/' /etc/lightdm/lightdm.conf
sleep 1

# flatpak apps
flatpak install flathub org.libreoffice.LibreOffice
flatpak install flathub net.davidotek.pupgui2
flatpak install flathub com.felipekinoshita.Kana
flatpak install flathub com.belmoussaoui.Decoder

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
	tput setaf 3;echo "Installing complete"; tput sgr0;
	echo "################################################################"
sleep 1
