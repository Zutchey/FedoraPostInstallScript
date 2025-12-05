#!/bin/bash

#Trap Sudo
while true; do
  sudo -v
  sleep 300
done &
SUDO_PID=$!

#Change computer name
sudo hostnamectl set-hostname fedora-pc

#Configure shell
grep -qF 'pokeget random' ~/.bashrc || cat << 'EOF' >> ~/.bashrc

if [[ $- == *i* ]]; then
    pokeget random --hide-name | fastfetch --file-raw -
fi

EOF

#Configure Kitty
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

#Configure Fastfetch
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

#Kill sudo loop
kill "$SUDO_PID"
