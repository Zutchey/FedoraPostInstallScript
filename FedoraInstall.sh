#!/bin/bash

# Background sudo refresh
while true; do
  sudo -v
  sleep 300
done &
SUDO_PID=$!
trap 'kill $SUDO_PID' EXIT

# Append max_parallel_downloads setting to dnf.conf
cat << EOF | sudo tee -a /etc/dnf/dnf.conf
max_parallel_downloads=20
EOF

# Create directories
mkdir -p ~/.config/obs-studio/plugins ~/.config/kitty ~/.config/fastfetch

# Download and install OBS plugin
wget -qO- "https://github.com/dimtpap/obs-pipewire-audio-capture/releases/download/1.2.1/linux-pipewire-audio-1.2.1.tar.gz" | \
tar -xzf - -C ~/.config/obs-studio/plugins
rm -f ~/.config/obs-studio/plugins/linux-pipewire-audio-1.2.1.tar.gz

#Swap FedoraFlatpak to FlathubFlatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo --user
#apps=$(flatpak list --app-runtime=org.fedoraproject.Platform --columns=application)
#if [ -n "$apps" ]; then
#  sudo flatpak install --reinstall flathub $apps -y
#fi
#sudo flatpak remote-delete fedora

# Change computer name
sudo hostnamectl set-hostname fedora

# Add repositories
sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release -y
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf copr enable -y derisis13/ani-cli
#sudo dnf copr enable -y sneexy/floorp
sudo dnf copr enable -y kylegospo/wallpaper-engine-kde-plugin
#sudo dnf copr enable -y brycensranch/gpu-screen-recorder-git
#sudo dnf copr enable -y ilyaz/LACT

#Multimedia Codecs
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y
sudo dnf swap mesa-vulkan-drivers mesa-vulkan-drivers-freeworld -y
sudo dnf swap mesa-va-drivers.i686 mesa-va-drivers-freeworld.i686 -y
sudo dnf swap mesa-vdpau-drivers.i686 mesa-vdpau-drivers-freeworld.i686 -y
sudo dnf swap mesa-vulkan-drivers.i686 mesa-vulkan-drivers-freeworld.i686 -y

# Install packages
sudo dnf install -y --skip-unavailable --skip-broken --allowerasing --refresh \
    steam ani-cli trash-cli cargo java cmatrix fastfetch gapless \
    gedit pavucontrol kitty gnome-disk-utility cowsay fortune-mod gimp vlc \
    heroic neovim gnome-boxes mpv curl cabextract xorg-x11-font-utils fontconfig \
    qbittorrent obs-studio umu-launcher lutris goverlay mangohud docker docker-compose \
    testdisk winetricks snapd chromium falcond gnome-tweaks g4music \
    kdenlive krita wallpaper-engine-kde-plugin protontricks htop bison \
    obs-studio-plugin-vkcapture cpu-x pokeget timeshift discord flex \
    freetype-devel libX11-devel libXext-devel libXcursor-devel libXfixes-devel \
    libXrandr-devel libXrender-devel libXi-devel libXinerama-devel gtk3-devel \
    mesa-libGL-devel mesa-libEGL-devel libxslt-devel libpng-devel zlib-devel \
    cups-devel dbus-devel alsa-lib-devel pulseaudio-libs-devel openldap-devel \
    libudev-devel libv4l-devel gphoto2-devel libusb1-devel 

# Install Gnome
#sudo dnf group install gnome-desktop -y

# Enable services
sudo systemctl enable --now falcond
sudo systemctl enable --now docker.service
#sudo systemctl disable NetworkManager-wait-online.service
sudo usermod -aG docker $USER

#Install WinBoat (AppImage also exists)
sudo rpm -i winboat-0.8.7-x86_64.rpm

# Install fonts
sudo rpm --nodigest -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FantasqueSansMono.zip
unzip -q FantasqueSansMono.zip -d ~/.local/share/fonts/
rm FantasqueSansMono.zip
fc-cache -f

# System configuration
echo 'OBS_VKCAPTURE=1' | sudo tee -a /etc/environment
#gsettings set org.gnome.mutter experimental-features "['variable-refresh-rate']"

# Install flatpaks
flatpak install -y --system \
    flathub io.github.ryubing.Ryujinx it.mijorus.gearlever org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/25.08 \
    io.missioncenter.MissionCenter org.localsend.localsend_app com.spotify.Client \
    dev.bragefuglseth.Keypunch org.nickvision.tubeconverter com.dec05eba.gpu_screen_recorder \
    io.gitlab.theevilskeleton.Upscaler garden.jamie.Morphosis com.usebottles.bottles \
    dev.vencord.Vesktop com.github.wwmm.easyeffects fr.handbrake.ghb com.protonvpn.www \
    me.proton.Pass io.github.sigmasd.stimulator com.mattjakeman.ExtensionManager \
    ca.desrt.dconf-editor io.github.flattool.Ignition com.github.tchx84.Flatseal \
    org.vinegarhq.Sober com.vysp3r.ProtonPlus io.github.ilya_zlobintsev.LACT \
    com.valvesoftware.Steam.CompatibilityTool.Proton-GE org.azahar_emu.Azahar sh.ppy.osu

flatpak repair

#Flatpak Permission Fixes
flatpak override --user --filesystem=/home/$USER/.icons/:ro
flatpak override --user --filesystem=/usr/share/icons/:ro
flatpak override --user --env=XCURSOR_PATH=$HOME/.icons
flatpak override --user --filesystem=xdg-config/MangoHud:ro

# Install Snaps (Losslesscut AppImage)
#sudo snap install spotify losslesscut

# Configure shell
grep -qF 'alias update-system' ~/.bashrc || cat << 'EOF' >> ~/.bashrc
export PATH="$HOME/.cargo/bin:$PATH"
pokeget random --hide-name | fastfetch --file-raw -
alias system-update='sudo snap refresh && sudo dnf update -y --refresh && flatpak update -y'
EOF

# Configure Kitty
cat << 'EOF' > ~/.config/kitty/kitty.conf
font_family FantasqueSansM Nerd Font Mono Bold
font_size 16.0
bold_font auto
italic_font auto
bold_italic_font auto

background_opacity 0.9
dynamic_background_opacity 1
confirm_os_window_close 0

cursor_trail 1
linux_display_server auto
scrollback_lines 2000
wheel_scroll_min_lines 1
enable_audio_bell no
window_padding_width 4

selection_foreground none
selection_background none

foreground #dddddd
background #000000
cursor #dddddd
EOF

# Configure Fastfetch
cat << 'EOF' > ~/.config/fastfetch/config.jsonc
{
"$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
"logo": {"padding": {"top": 1}},
"display": {"separator": " 󰑃  "},
"modules": [
    "break",
    {
    "type": "title",
    "format": "{#1}╭───────────── {#}{user-name-colored}",
    "formatColor": "yellow"
    },
    {"type": "os", "key": " DISTRO", "keyColor": "yellow"},
    {"type": "kernel", "key": "│ ├", "keyColor": "yellow"},
    {"type": "packages", "key": "│ ├󰏖", "keyColor": "yellow"},
    {"type": "shell", "key": "│ └", "keyColor": "yellow"},
    {"type": "de", "key": "󰧨 DE/WM", "keyColor": "blue"},
    {"type": "wm", "key": "│ ├", "keyColor": "blue"},
    {"type": "wmtheme", "key": "│ ├󰉼", "keyColor": "blue"},
    {"type": "icons", "key": "│ ├󰀻", "keyColor": "blue"},
    {"type": "cursor", "key": "│ ├", "keyColor": "blue"},
    {"type": "terminalfont", "key": "│ ├", "keyColor": "blue"},
    {"type": "terminal", "key": "│ ├", "keyColor": "blue"},
    {"type": "uptime", "key": "│ └󰅐", "keyColor": "blue"},
    {"type": "host", "key": "󰌢 SYSTEM", "keyColor": "green"},
    {"type": "cpu", "key": "│ ├󰻠", "keyColor": "green"},
    {"type": "gpu", "key": "│ ├󰢮", "format": "{2}", "keyColor": "green"},
    {"type": "memory", "key": "│ ├󰍛", "keyColor": "green"},
    {"type": "disk", "key": "│ ├󰋊", "keyColor": "green"},
    {"type": "display", "key": "│ └󰍹", "keyColor": "green", "compactType": "original-with-refresh-rate"},
    {"type": "sound", "key": " AUDIO", "format": "{2}", "keyColor": "magenta"},
    "break"
    ]
}
EOF

echo "Setup complete! Reboot recommended."
read -p "Reboot now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo reboot
fi
