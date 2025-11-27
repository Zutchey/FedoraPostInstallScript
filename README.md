# FedoraPostInstallScript
NOT TESTED ON NVIDIA OR INTEL GPUS!!!

This is a script made by me for Fedora, and only Fedora, to be used post install. It is based on my own preferences of how I prefer my Fedora system. This script is made so that the user only has to give one input and the script does the rest.


## COPY AND PASTE INTO TERMINAL TO INSTALL

```bash
cd ~/Downloads
sudo dnf install git -y
git clone https://github.com/Zutchey/FedoraPostInstallScript
cd FedoraPostInstallScript
chmod +x FedoraInstall.sh
./InstallScript.sh
