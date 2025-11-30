## FedoraPostInstallScript


## Important Warnings & Prerequisites

* **NOT TESTED ON NVIDIA OR INTEL GPUS!** This Script Was Specifically Made With AMD In Mind.
* **Fresh Install Recommended:** Proceed with caution. Running This On An Existing System **Might Delete You Already Set Configurations**.
* **Purpose:** This Script Is Intended To Ease New Users Into Fedora Linux By Automating Setup Steps. This Script Is Meant To Be A One Input Plug And Play Script, However You May Be Prompted For Your `sudo` Password More Than Once, Due To Sudo Timeout.

---

## Core Setup

This Main Script Handles Updating System, Enabling Repositories, Proper Codec Installation, Package Installation, And A Few Tweaks. The Second Script Is Optional And Only Contains Additional Applications

### **Installation Instructions**

Copy And Paste Block Below Into Your Terminal And Let The Magic Happen:
* **(CTRL + SHIFT + V TO PASTE INTO TERMINAL)**

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

**GAMEMODE WAS REMOVED IN FAVOR OF FALCOND**  
* Attempting To Run A Game With Gamemode Will **Not** Workd And The Game **Will Not Launch**.
* Falcond Repository: https://github.com/PikaOS-Linux/falcond

---

## Linux App Store
- **Bazaar** (Recommended For New Linux Users)

---

**If You're Unfamiliar With Any Of The Applications Listed Below, I Recommend Looking Into Them As Each Has Enough Value To Me To Remain Part Of The Core Setup**

---
## Gaming Applications Installed
- Steam  
- Heroic  
- Lutris  
- Bottles  
- ProtonPlus (For Installing Proton-GE)

---

## Important Applications
- GPU Screen Recorder (Better Shadow Play)
- Discord (Discord)
- OBS (With Custom Plugins)  
- Winboat (For Windows Applications That Don't Run Through Wine)  
- BTRFS Assistant (System Snapshots)  
- MangoHud/Goverlay (Performance Overlay)
- Gear Lever (For AppImages)  
- Flatseal (Managing Flatpak permissions)
- LACT (GPU Overclocking)
- Mission Center (Linux's Task Manager)

---

## Other Applications
- Disks//Gnome Disk Utility (Disk Manager)
- Krita (Painting)
- Kdenlive (Video Editor)
- Sober (Roblox)
- Easy Effects (Auio Processor)
- Extension Manager (Make Gnome Usable)

---

## Things to Note
- **OBS Vulkan Layer And MangoHud Are Set Globally**, So You Do Not Need To Enable It Manually For Vulkan Games
- **MangoHud Is Preconfigured** By The Script
- **MangoHud**: Right Shift + F12 While In Game To Enable / Left Shift + F2 To Log That Data Into ~/Documents/MangoHud
- Windows Fonts Installed
- BTRFS Assistant Is A Life Saver, Especially For New Users
- Games Probably Will Not Launch If Installed On NFTS Drives
- Use Proton-GE Whenever Available
- On Steam, I Would Recommend Turning On Background Processing Of Vulkan Shaders Under Download Settings
- Using Disks Is The Simplest Way, IMO, To Auto Mount Drives On Boot

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


