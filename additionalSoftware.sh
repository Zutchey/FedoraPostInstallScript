#!/bin/bash

#Log Terminal Output
LOGFILE="/home/jesus/Downloads/FedoraPostInstallScript/additionalSoftware.log"
exec > >(tee -a "$LOGFILE") 2>&1

#Trap Sudo
while true; do
  sudo -v
  sleep 300
done &
SUDO_PID=$!

#Install Native Software
sudo dnf install -y --allowerasing --refresh gedit
sudo dnf install -y --allowerasing ani-cli
sudo dnf install -y --allowerasing qbittorrent
sudo dnf install -y --allowerasing g4music
sudo dnf install -y --allowerasing wallpaper-engine-kde-plugin
sudo dnf install -y --allowerasing protontricks
sudo dnf install -y --allowerasing htop
sudo dnf install -y --allowerasing zsh

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
    io.github.flattool.Warehouse 

#Kill sudo loop
kill "$SUDO_PID"
