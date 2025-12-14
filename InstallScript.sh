#!/bin/bash

#Log Terminal Output
LOGFILE="$HOME/Downloads/FedoraPostInstallScript/InstallScript.log"
exec > >(tee -a "$LOGFILE") 2>&1

#Trap Sudo
while true; do
  sudo -v
  sleep 300
done &
SUDO_PID=$!

#Kill Steam if open
killall steam

#Faster Package Downloads
grep -qxF 'max_parallel_downloads=20' /etc/dnf/dnf.conf ||
echo 'max_parallel_downloads=20' | sudo tee -a /etc/dnf/dnf.conf

#More Stable Downloads
grep -qxF 'fastestmirror=False' /etc/dnf/dnf.conf || \
echo 'fastestmirror=False' | sudo tee -a /etc/dnf/dnf.conf

#(testing) Update System
sudo -v
sudo dnf update --refresh -y --downloadonly
sudo -v
sudo dnf upgrade -y
sudo -v

#Create directories
mkdir -p ~/.config/obs-studio/plugins ~/.config/kitty ~/.config/fastfetch ~/.config/MangoHud ~/Documents/MangoHud ~/.config/FedoraPostInstallScript

#Move Mesa Git Scripts
mv ~/Downloads/FedoraPostInstallScript/extra/mesa-git-install.sh ~/.config/FedoraPostInstallScript
mv ~/Downloads/FedoraPostInstallScript/extra/mesa-git-remove.sh ~/.config/FedoraPostInstallScript
mv ~/Downloads/FedoraPostInstallScript/extra/mesa-git-update.sh ~/.config/FedoraPostInstallScript

#Make Them Executable
chmod +x ~/.config/FedoraPostInstallScript/mesa-git-install.sh
chmod +x ~/.config/FedoraPostInstallScript/mesa-git-remove.sh
chmod +x ~/.config/FedoraPostInstallScript/mesa-git-update.sh

#Download and install OBS plugin
wget -qO- "https://github.com/dimtpap/obs-pipewire-audio-capture/releases/download/1.2.1/linux-pipewire-audio-1.2.1.tar.gz" | \
tar -xzf - -C ~/.config/obs-studio/plugins

#Add Flathub Flatpaks
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-delete fedora

#Add repositories
sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release -y
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

#Core
sudo dnf group upgrade core -y

#Multimedia Codecs
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y
sudo dnf swap mesa-vulkan-drivers mesa-vulkan-drivers-freeworld -y
sudo dnf swap mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686 -y
sudo dnf swap mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686 -y
sudo dnf swap mesa-vulkan-drivers.i686 mesa-vulkan-drivers-freeworld.i686 -y

#Still Codecs (From Fedora-Noble-Setup)
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} \
  gstreamer1-plugin-openh264 gstreamer1-libav lame\* \
  --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf group install -y multimedia
sudo dnf group install -y sound-and-video

#Remove Packages
sudo dnf remove -y --noautoremove firefox

#Install packages
sudo dnf install -y --allowerasing --refresh steam
sudo dnf install -y --allowerasing cargo
sudo dnf install -y --allowerasing java
sudo dnf install -y --allowerasing fastfetch
sudo dnf install -y --allowerasing pavucontrol
sudo dnf install -y --allowerasing gnome-disk-utility
sudo dnf install -y --allowerasing heroic
sudo dnf install -y --allowerasing mpv
sudo dnf install -y --allowerasing curl
sudo dnf install -y --allowerasing obs-studio
sudo dnf install -y --allowerasing umu-launcher
sudo dnf install -y --allowerasing lutris
sudo dnf install -y --allowerasing goverlay
sudo dnf install -y --allowerasing mangohud
sudo dnf install -y --allowerasing docker
sudo dnf install -y --allowerasing docker-compose
sudo dnf install -y --allowerasing winetricks
sudo dnf install -y --allowerasing wine
sudo dnf install -y --allowerasing wine-core
sudo dnf install -y --allowerasing falcond
sudo dnf install -y --allowerasing gnome-tweaks
sudo dnf install -y --allowerasing obs-studio-plugin-vkcapture
sudo dnf install -y --allowerasing cpu-x
sudo dnf install -y --allowerasing pokeget
sudo dnf install -y --allowerasing btrfs-assistant
sudo dnf install -y --allowerasing snapper
sudo dnf install -y --allowerasing discord
sudo dnf install -y --allowerasing rocm-opencl
sudo dnf install -y --allowerasing libxcrypt-compat
sudo dnf install -y --allowerasing libcurl
sudo dnf install -y --allowerasing libcurl-devel
sudo dnf install -y --allowerasing mesa-libGLU
sudo dnf install -y --allowerasing freerdp
sudo dnf install -y --allowerasing libva-utils
sudo dnf install -y --allowerasing p7zip
sudo dnf install -y --allowerasing p7zip-plugins
sudo dnf install -y --allowerasing unrar
sudo dnf install -y --allowerasing btrbk
sudo dnf install -y --allowerasing ms-core-fonts

#Enable services
sudo systemctl enable --now falcond
sudo systemctl enable --now docker.service
sudo usermod -aG docker $USER

#Install WinBoat (AppImage also exists)
sudo dnf install -y https://github.com/TibixDev/winboat/releases/download/v0.9.0/winboat-0.9.0-x86_64.rpm

#Install fonts
sudo rpm --nodigest -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FantasqueSansMono.zip
unzip -q FantasqueSansMono.zip -d ~/.local/share/fonts/
rm FantasqueSansMono.zip
fc-cache -f

#System configuration
echo 'OBS_VKCAPTURE=1' | sudo tee -a /etc/environment
echo 'MANGOHUD=1' | sudo tee -a /etc/environment

#Gnome Changes
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

#Dual Boot Time Fix
sudo timedatectl set-local-rtc 0 --adjust-system-clock

#Enable Wine NTsync
cat << EOF | sudo tee /etc/modules-load.d/ntsync.conf > /dev/null
ntsync
EOF

#Configure shell
grep -qF 'alias system-update' ~/.bashrc || cat << 'EOF' >> ~/.bashrc
export PATH="$HOME/.cargo/bin:$PATH"

alias system-update='sudo dnf update -y --refresh && flatpak update -y'

alias mesa-git-install='~/.config/FedoraPostInstallScript/mesa-git-install.sh'

alias mesa-git-remove='~/.config/FedoraPostInstallScript/mesa-git-remove.sh'

alias mesa-git-update='~/.config/FedoraPostInstallScript/mesa-git-update.sh'
EOF

#Configure MangoHud
cat << 'EOF' > ~/.config/MangoHud/MangoHud.conf
################### File Generated by Goverlay ###################
legacy_layout=false

background_alpha=0.6
round_corners=10
background_alpha=0.6
background_color=000000

font_size=24
text_color=FFFFFF
position=top-left
toggle_hud=Shift_R+F12
no_display
pci_dev=0:03:00.0
table_columns=3
gpu_text=GPU
gpu_stats
gpu_temp
gpu_power
gpu_color=2E9762
cpu_text=CPU
cpu_stats
core_load
core_bars
cpu_temp
cpu_power
cpu_color=FF0000
swap
ram
ram_color=C26693
fps
gpu_name
vulkan_driver
wine
wine_color=EB5B5B
frame_timing
frametime_color=00FF00
fps_limit_method=late
toggle_fps_limit=Shift_L+F1

fps_limit=0
resolution
winesync
custom_text=Session:
exec=echo $XDG_SESSION_TYPE
#offset=0

output_folder=~/Documents/MangoHud
log_duration=180
autostart_log=0
log_interval=100
toggle_logging=Shift_L+F2
log_versioning
upload_logs

blacklist=pamac-manager,lact,ghb,bitwig-studio,ptyxis,yumex
EOF

# Wooting Support
sudo tee /etc/udev/rules.d/70-wooting.rules > /dev/null << 'EOF'
# Wooting One Legacy
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff01", TAG+="uaccess"
SUBSYSTEM=="usb",    ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff01", TAG+="uaccess"

# Wooting One update mode
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2402", TAG+="uaccess"

# Wooting Two Legacy
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff02", TAG+="uaccess"
SUBSYSTEM=="usb",    ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="ff02", TAG+="uaccess"

# Wooting Two update mode
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="2403", TAG+="uaccess"

# Generic Wooting devices
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", TAG+="uaccess"
SUBSYSTEM=="usb",    ATTRS{idVendor}=="31e3", TAG+="uaccess"
EOF

# Reload udev rules
sudo udevadm control --reload-rules
sudo udevadm trigger

#Kill sudo loop
kill "$SUDO_PID"

#Install flatpaks
flatpak install -y flathub --noninteractive \
    com.usebottles.bottles \
    it.mijorus.gearlever \
    org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/25.08 \
    io.missioncenter.MissionCenter \
    com.dec05eba.gpu_screen_recorder \
    com.github.wwmm.easyeffects \
    io.github.sigmasd.stimulator \
    com.mattjakeman.ExtensionManager \
    ca.desrt.dconf-editor \
    io.github.flattool.Ignition \
    com.github.tchx84.Flatseal \
    com.vysp3r.ProtonPlus \
    io.github.ilya_zlobintsev.LACT \
    org.vinegarhq.Sober \
    io.github.kolunmi.Bazaar \
    org.kde.krita \
    org.kde.kdenlive \
    org.gimp.GIMP \
    org.mozilla.firefox

#Flatpak Permission Fixes
#flatpak override --user --filesystem=/home/$USER/.icons/:ro
#flatpak override --user --filesystem=/usr/share/icons/:ro
#flatpak override --user --env=XCURSOR_PATH=$HOME/.icons
flatpak override --user --filesystem=xdg-config/MangoHud:ro
flatpak override --user --device=input org.vinegarhq.Sober

#Enable Steam h.264 (Auto closes after 2 minutes)
steam steam://unlockh264/ & sleep 120; kill $(pgrep steam)

echo "Setup complete! Rebooting in 30 seconds."
sleep 30
reboot
