# FedoraPostInstallScript
NOT TESTED ON NVIDIA OR INTEL GPUS!!!

This is a script made by me for Fedora, and only Fedora, to be used post install. It is based on my own preferences of how I prefer my Fedora system. This script is made so that the user only has to give one input and the script does the rest.


## COPY AND PASTE INTO TERMINAL TO INSTALL

```bash
sudo dnf install git -y
cd ~/Downloads
git clone https://github.com/Zutchey/FedoraPostInstallScript
cd FedoraPostInstallScript
chmod +x InstallScript.sh
systemd-inhibit --what=idle:sleep --why="Script running" ./InstallScript.sh
```

## COPY AND PASTE THIS FOR ADDITIONAL SOFTWARE
```bash
cd ~/Downloads/FedoraPostInstallScript
chmod +x additionalSoftware.sh
systemd-inhibit --what=idle:sleep --why="Script running" ./additionalSoftware.sh
```

## DO NOT RUN THIS UNLESS YOU KNOW WHAT YOU ARE DOING
## ADDITIONAL CONFIGURATIONS + DNS
```bash
cd ~/Downloads/FedoraPostInstallScript
chmod +x extraConfigs.sh
systemd-inhibit --what=idle:sleep --why="Script running" ./extraConfigs.sh
```
