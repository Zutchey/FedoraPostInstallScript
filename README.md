# FedoraPostInstallScript
NOT TESTED ON NVIDIA OR INTEL GPUS!!!

This script is meant to be run on a Fresh install of Fedora!! Can be run on non-fresh installs, though it might delete your already set configs (Not Recommended).

This script is made to ease new users of Fedora into the Linux ecosystem. This script is meant to be one input for ease of use, however it may not be like that 100% of the time depending on many factors that may not be controllable. Just be aware that you may have to give your sudo password more than once on a bad day.

## COPY AND PASTE INTO TERMINAL TO INSTALL

```bash
sudo dnf install git -y
cd ~/Downloads
git clone https://github.com/Zutchey/FedoraPostInstallScript
cd FedoraPostInstallScript
chmod +x InstallScript.sh
systemd-inhibit --what=idle:sleep --why="Script running" ./InstallScript.sh
```

Important!!
GAMEMODE WAS REMOVED IN FAVOR OF FALCOND BY THE SCRIPT, DO NOT TRY TO RUN A GAME WITH GAMEMODE. IT WILL NOT RUN!!!! 

## COPY AND PASTE THIS FOR ADDITIONAL SOFTWARE
```bash
cd ~/Downloads/FedoraPostInstallScript
chmod +x additionalSoftware.sh
systemd-inhibit --what=idle:sleep --why="Script running" ./additionalSoftware.sh
```
