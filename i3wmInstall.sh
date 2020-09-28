#!/bin/bash

# Set the cores
echo "Setting the cores"

set -e

numberofcores=$(grep -c ^processor /proc/cpuinfo)

if [ $numberofcores -gt 1 ]
then
        echo "You have " $numberofcores" cores."
        echo "Changing the makeflags for "$numberofcores" cores."
        sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j'$(($numberofcores+1))'"/g' /etc/makepkg.conf;
        echo "Changing the compression settings for "$numberofcores" cores."
        sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -T '"$numberofcores"' -z -)/g' /etc/makepkg.conf
else
        echo "No change."
fi

echo ""

sudo pacman -Syu --noconfirm --needed

# -------------------
# Sound
# -------------------

echo "Setting Sound"

sudo pacman -S pulseaudio --noconfirm --needed
sudo pacman -S pulseaudio-alsa --noconfirm --needed
sudo pacman -S pavucontrol  --noconfirm --needed
sudo pacman -S alsa-utils alsa-plugins alsa-lib alsa-firmware --noconfirm --needed

echo ""

# -----------------
# Bluetooth
# -----------------

echo "Setting Bluetooth"

sudo pacman -S --noconfirm --needed pulseaudio-bluetooth
sudo pacman -S --noconfirm --needed bluez
sudo pacman -S --noconfirm --needed bluez-libs
sudo pacman -S --noconfirm --needed bluez-utils
sudo pacman -S --noconfirm --needed blueberry

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf

echo "reboot your system then ..."
echo "set with bluetooth icon in bottom right corner"
echo "change to have a2dp if needed"

echo ""

# -----------------
# Network Discovery
# -----------------

echo "Setting Network Discovery"

sudo pacman -S --noconfirm --needed wget curl
sudo pacman -S --noconfirm --needed network-manager-applet
sudo pacman -S --noconfirm --needed avahi
sudo systemctl enable avahi-daemon.service
sudo systemctl start avahi-daemon.service

#shares on a mac
sudo pacman -S --noconfirm --needed nss-mdns

#shares on a linux
sudo pacman -S --noconfirm --needed gvfs-smb

#first part
sudo sed -i 's/files mymachines myhostname/files mymachines/g' /etc/nsswitch.conf
#last part
sudo sed -i 's/\[\!UNAVAIL=return\] dns/\[\!UNAVAIL=return\] mdns dns wins myhostname/g' /etc/nsswitch.conf

echo ""

# --------------------
# Battery for Laptops
# --------------------

echo "Install tlp for battery life - laptops"

sudo pacman -S --noconfirm --needed cbatticon

echo ""

# --------------------
# Basic Linux Stuff
# --------------------

# software from standard Arch Linux repositories
# Core, Extra, Community, Multilib repositories
echo "Installing category Accessories"

sudo pacman -S --noconfirm --needed cronie # For cronjobs
sudo pacman -S --noconfirm --needed flameshot # For screenshoots

echo "Installing category Development"

sudo pacman -S --noconfirm --needed vim
sudo pacman -S --noconfirm --needed python python2
sudo pacman -S --noconfirm --needed python-pip python2-pip

echo "Installing category Graphics"

sudo pacman -S --noconfirm --needed gimp
sudo pacman -S --noconfirm --needed eog

echo "Installing category Internet"

sudo pacman -S --noconfirm --needed chromium
sudo pacman -S --noconfirm --needed firefox
sudo pacman -S --noconfirm --needed qbittorrent
sudo pacman -S --noconfirm --needed lynx
sudo pacman -S --noconfirm --needed tor
sudo pacman -S --noconfirm --needed torbrowser-launcher
sudo pacman -S --noconfirm --needed nyx
sudo pacman -S --noconfirm --needed thunderbird
sudo pacman -S --noconfirm --needed pidgin # For social media

echo "Installing category Multimedia"

sudo pacman -S --noconfirm --needed simplescreenrecorder
sudo pacman -S --noconfirm --needed vlc
sudo pacman -S --noconfirm --needed youtube-dl

echo "Installing category Office"

sudo pacman -S --noconfirm --needed evince
sudo pacman -S --noconfirm --needed libreoffice-fresh

echo "Installing category System"

sudo pacman -S --noconfirm --needed accountsservice
sudo pacman -S --noconfirm --needed git
sudo pacman -S --noconfirm --needed glances
sudo pacman -S --noconfirm --needed gparted
sudo pacman -S --noconfirm --needed grsync
sudo pacman -S --noconfirm --needed gvfs gvfs-mtp
sudo pacman -S --noconfirm --needed hardinfo
sudo pacman -S --noconfirm --needed hddtemp
sudo pacman -S --noconfirm --needed htop
sudo pacman -S --noconfirm --needed lsb-release
sudo pacman -S --noconfirm --needed mlocate
sudo pacman -S --noconfirm --needed net-tools
sudo pacman -S --noconfirm --needed noto-fonts
sudo pacman -S --noconfirm --needed numlockx
sudo pacman -S --noconfirm --needed neofetch
sudo pacman -S --noconfirm --needed tmux
sudo pacman -S --noconfirm --needed termite
sudo pacman -S --noconfirm --needed thunar
sudo pacman -S --noconfirm --needed thunar-archive-plugin
sudo pacman -S --noconfirm --needed thunar-volman
sudo pacman -S --noconfirm --needed ttf-ubuntu-font-family
sudo pacman -S --noconfirm --needed ttf-droid
sudo pacman -S --noconfirm --needed tumbler
sudo pacman -S --noconfirm --needed virtualbox-host-modules-arch
sudo pacman -S --noconfirm --needed virtualbox
sudo pacman -S --noconfirm --needed unclutter
sudo pacman -S --noconfirm --needed rxvt-unicode
sudo pacman -S --noconfirm --needed urxvt-perls
sudo pacman -S --noconfirm --needed xdg-user-dirs
sudo pacman -S --noconfirm --needed xdo
sudo pacman -S --noconfirm --needed xdotool
sudo pacman -S --noconfirm --needed zenity
sudo pacman -S --noconfirm --needed man
sudo pacman -S --noconfirm --needed cmake
sudo pacman -S --noconfirm --needed ranger
sudo pacman -S --noconfirm --needed reflector
sudo pacman -S --noconfirm --needed mlocate
sudo pacman -S --noconfirm --needed dnsutils
sudo pacman -S --noconfirm --needed xorg-xbacklight
sudo pacman -S --noconfirm --needed grc
sudo pacman -S --noconfirm --needed xclip
sudo pacman -S --noconfirm --needed jq
sudo pacman -S --noconfirm --needed fish # Fish shell
sudo pacman -S --noconfirm --needed nfs-utils
sudo pacman -S --noconfirm --needed tree
sudo pacman -S --noconfirm --needed remmina
sudo pacman -S --noconfirm --needed rdesktop
sudo pacman -S --noconfirm --needed calcurse
sudo pacman -S --noconfirm --needed sysstat
sudo pacman -S --noconfirm --needed task

###############################################################################################

# installation of zippers and unzippers
sudo pacman -S --noconfirm --needed unace unrar zip unzip sharutils uudeview arj cabextract file-roller tar bzip2 gzip p7zip pbzip2

echo ""

# -------------------
# AUR Packages
# -------------------

echo "Installing yay"

if ! type "yay" &>/dev/null
then
        cd ~
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd ~/InstallArchI3
 else
        echo "Yay installed, skipping..."
 fi

echo "Installing category System"

yay -S --noconfirm --needed downgrade
yay -S --noconfirm --needed font-manager-git
yay -S --noconfirm --needed inxi
yay -S --noconfirm --needed oxy-neon
yay -S --noconfirm --needed pamac-aur
yay -S --noconfirm --needed sardi-icons
yay -S --noconfirm --needed sardi-orb-colora-variations-icons-git
yay -S --noconfirm --needed surfn-icons-git
yay -S --noconfirm --needed the_platinum_searcher-bin
yay -S --noconfirm --needed ttf-font-awesome
yay -S --noconfirm --needed ttf-mac-fonts
yay -S --noconfirm --needed nerd-fonts-hack 
yay -S --noconfirm --needed brave-nightly-bin
yay -S --noconfirm --needed gksu
yay -S --noconfirm --needed cherrytree
yay -S --noconfirm --needed remmina-plugin-rdesktop

# these come always last

yay -S --noconfirm --needed hardcode-fixer-git
sudo hardcode-fixer

echo "" 

# --------------------
# Display Manager
# --------------------

echo "Setting Display Manager"


sudo pacman -S i3-gaps i3blocks --noconfirm --needed
yay -S --noconfirm --needed ly-git
sudo systemctl enable ly.service
sudo systemctl disable getty@tty2.service



echo ""

# -------------------------
# Arch Linux Repo Distro Specific
# -------------------------

echo "DESKTOP SPECIFIC APPLICATIONS"

echo "Installing category Accessories"

sudo pacman -S xfce4-terminal --noconfirm --needed

echo "Installing category System"

sudo pacman -S arandr --noconfirm --needed
sudo pacman -S awesome-terminal-fonts --noconfirm --needed
sudo pacman -S picom  --noconfirm --needed
sudo pacman -S dmenu  --noconfirm --needed
sudo pacman -S feh --noconfirm --needed
sudo pacman -S gtop --noconfirm --needed
sudo pacman -S imagemagick --noconfirm --needed
sudo pacman -S lxappearance-gtk3 --noconfirm --needed
sudo pacman -S lxrandr --noconfirm --needed
sudo pacman -S playerctl --noconfirm --needed
sudo pacman -S thunar --noconfirm --needed
sudo pacman -S w3m  --noconfirm --needed
sudo pacman -S xfce4-appfinder --noconfirm --needed
sudo pacman -S xfce4-power-manager --noconfirm --needed
sudo pacman -S xfce4-settings --noconfirm --needed
sudo pacman -S xfce4-notifyd --noconfirm --needed

echo ""

# ----------------------
# Aur Repo Specific
# ----------------------

echo "AUR - DESKTOP SPECIFIC APPLICATIONS "

yay -S --noconfirm --needed gtk2-perl
yay -S --noconfirm --needed perl-linux-desktopfiles
yay -S --noconfirm --needed xtitle
yay -S --noconfirm --needed urxvt-resize-font-git
yay -S --noconfirm --needed i3exit

echo ""

# --------------------
# Fonts
# --------------------

echo "Installing fonts and themes from Arch Linux repo"

sudo pacman -S adobe-source-sans-pro-fonts --noconfirm --needed
sudo pacman -S cantarell-fonts --noconfirm --needed
sudo pacman -S noto-fonts --noconfirm --needed
sudo pacman -S ttf-bitstream-vera --noconfirm --needed
sudo pacman -S ttf-dejavu --noconfirm --needed
sudo pacman -S ttf-droid --noconfirm --needed
sudo pacman -S ttf-hack --noconfirm --needed
sudo pacman -S ttf-inconsolata --noconfirm --needed
sudo pacman -S ttf-liberation --noconfirm --needed
sudo pacman -S ttf-roboto --noconfirm --needed
sudo pacman -S ttf-ubuntu-font-family --noconfirm --needed
sudo pacman -S tamsyn-font --noconfirm --needed
sudo pacman -S breeze --noconfirm --needed
sudo pacman -S otf-hermit --noconfirm --needed

echo ""

# ----------------
# Pentesting
# ----------------

echo "Installing Tools for Pentesting"

# Pacman repo
sudo pacman -S --noconfirm --needed nmap
sudo pacman -S --noconfirm --needed aircrack-ng
sudo pacman -S --noconfirm --needed bettercap
sudo pacman -S --noconfirm --needed inetutils
sudo pacman -S --noconfirm --needed openssh
sudo pacman -S --noconfirm --needed iputils traceroute whois dnsutils
sudo pacman -S --noconfirm --needed impacket
sudo pacman -S --noconfirm --needed hydra medusa
sudo pacman -S --noconfirm --needed john hashcat
sudo pacman -S --noconfirm --needed nikto
sudo pacman -S --noconfirm --needed sqlmap
sudo pacman -S --noconfirm --needed wireshark-qt tcpdump
sudo pacman -S --noconfirm --needed proxychains-ng
sudo pacman -S --noconfirm --needed dsniff
sudo pacman -S --noconfirm --needed ettercap-gtk
sudo pacman -S --noconfirm --needed hping
sudo pacman -S --noconfirm --needed ngrep
sudo pacman -S --noconfirm --needed metasploit
sudo pacman -S --noconfirm --needed masscan
sudo pacman -S --noconfirm --needed zaproxy
sudo pacman -S --noconfirm --needed smbclient
sudo pacman -S --noconfirm --needed kxmlrpcclient
sudo pacman -S --noconfirm --needed radare2
sudo pacman -S --noconfirm --needed parallel
sudo pacman -S --noconfirm --needed mysql
sudo pacman -S --noconfirm --needed perl-image-exiftool
#For windows
sudo pacman -S --noconfirm --needed nbtscan
# For Wifi
sudo pacman -S --noconfirm --needed wpscan
sudo pacman -S --noconfirm --needed reaver bully
sudo pacman -S --noconfirm --needed macchanger
sudo pacman -S --noconfirm --needed hcxdumptool hcxtools

# AUR Repo
yay -S --noconfirm --needed exploit-db-git
yay -S --noconfirm --needed cutycapt-qt5-git
yay -S --noconfirm --needed routersploit-git

echo ""


# ----------------
# Personal Configuration
# ----------------

sudo pacman -S --noconfirm --needed telegram-desktop

# Antivirus
sudo pacman -S --noconfirm --needed clamav

# Uncomplicated Firewall
sudo pacman -S --noconfirm --needed ufw

# Criptography
sudo pacman -S --noconfirm --needed gnupg

# Eyes
sudo pacman -S --noconfirm --needed redshift

