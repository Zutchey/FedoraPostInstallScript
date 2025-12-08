#!/bin/bash

#Log Terminal Output
LOGFILE="$HOME/Downloads/FedoraPostInstallScript/additionalSoftware.log"
exec > >(tee -a "$LOGFILE") 2>&1

#Trap Sudo
while true; do
  sudo -v
  sleep 300
done &
SUDO_PID=$!

#Enable Copr Repos
sudo dnf copr enable -y derisis13/ani-cli
sudo dnf copr enable -y kylegospo/wallpaper-engine-kde-plugin
sudo dnf -y copr enable faugus/faugus-launcher

#Install Native Software
sudo dnf install -y --allowerasing --refresh protontricks
sudo dnf install -y --allowerasing ani-cli
sudo dnf install -y --allowerasing wallpaper-engine-kde-plugin
sudo dnf install -y --allowerasing zsh
sudo dnf install -y --allowerasing kitty
sudo dnf install -y --allowerasing faugus-launcher

#Kill sudo loop
kill "$SUDO_PID"

#Install Flatpaks
flatpak install -y flathub \
    org.localsend.localsend_app \
    com.spotify.Client \
    dev.bragefuglseth.Keypunch \
    org.nickvision.tubeconverter \
    io.gitlab.theevilskeleton.Upscaler \
    garden.jamie.Morphosis \
    fr.handbrake.ghb \
    com.protonvpn.www \
    org.azahar_emu.Azahar \
    io.github.ryubing.Ryujinx \
    sh.ppy.osu \
    io.github.flattool.Warehouse \
    org.gnome.Boxes \
    org.gnome.gedit \
    org.qbittorrent.qBittorrent \
    com.github.neithern.g4music 
