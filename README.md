## FedoraPostInstallScript


## Important Warnings & Prerequisites

* **NOT TESTED ON NVIDIA OR INTEL GPUS!** This script primarily uses configurations favorable for **AMD** users.
* **Fresh Install Recommended:** Running this on an existing system **might delete your already set configurations**. Proceed with caution.
* **Purpose:** This script is intended to ease new users into the Linux ecosystem by automating setup steps. You may be prompted for your `sudo` password more than once.

---

## Core Setup

This main script handles foundational setup, driver configuration, and system optimizations. It must be run first.

### **Installation Instructions**

Copy and paste the entire block below into your terminal to start the process:

```bash
sudo dnf install git -y
cd ~/Downloads
git clone https://github.com/Zutchey/FedoraPostInstallScript
cd FedoraPostInstallScript
chmod +x InstallScript.sh
systemd-inhibit --what=idle:sleep --why="Script running" ./InstallScript.sh
```
---

## IMPORTANT!!!!

**GAMEMODE WAS REMOVED IN FAVOR OF FALCOND.**  
Attempting to run a game with Gamemode will **not** work and the game **will not launch**.  
Falcond repository: https://github.com/PikaOS-Linux/falcond

---

## Linux App Store
- **Bazaar** (Recommended for new Linux users)

---

**If you're unfamiliar with any of the packages listed below, I recommend looking into them as each is valuable enough to remain part of the core setup.**

---
## Gaming Packages Installed
- Steam  
- Heroic  
- Lutris  
- Bottles  
- ProtonPlus (for installing Proton-GE)

---

## Important Packages
- GPU Screen Recorder  
- Discord  
- OBS (with custom plugins)  
- Winboat (for Windows applications that don't run through Wine)  
- BTRFS Assistant (Snapshots)  
- MangoHud / GOverlay  
- Gear Lever (for AppImages)  
- Flatseal  
- LACT (GPU overclocking)

---

## Things to Note
- **OBS Vulkan Layer is set globally**, so you do not need to enable it manually for Vulkan games.
- **MangoHud is preconfigured** by the script.

---

## Optional Additional Applications

```bash
cd ~/Downloads/FedoraPostInstallScript
chmod +x additionalSoftware.sh
systemd-inhibit --what=idle:sleep --why="Script running" ./additionalSoftware.sh
```
- Gedit
- ani-cli
- qBittorrent
- Gapless
- Protontricks
- htop
- kitty
- LocalSend
- Spotify
- Keypunch
- Parabolic
- Upscaler
- Morphosis
- Handbrake
- ProtonVPN
- osu!
- Warehouse
- Faugus


