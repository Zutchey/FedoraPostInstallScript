## FedoraPostInstallScript

Table Of Contents:
- [Installation](https://github.com/Zutchey/FedoraPostInstallScript/tree/main?tab=readme-ov-file#installation-instructions)
- [Video Guide]
- [IMPORTANT](https://github.com/Zutchey/FedoraPostInstallScript/tree/main?tab=readme-ov-file#important)
- [Linux App Store](https://github.com/Zutchey/FedoraPostInstallScript/tree/main?tab=readme-ov-file#linux-app-store)
- [Things To Note](https://github.com/Zutchey/FedoraPostInstallScript/tree/main?tab=readme-ov-file#things-to-note)
- [Optional Additional Applications](https://github.com/Zutchey/FedoraPostInstallScript/tree/main?tab=readme-ov-file#optional-additional-applications)

---

## Important Warnings & Prerequisites

* **NOT TESTED ON NVIDIA OR INTEL GPUS!** This Script Was Specifically Made With AMD In Mind.
* **Fresh Install Recommended:** Proceed with caution. Running This On An Existing System **Might Delete Your Already Set Configurations**.
* **Purpose:** This Script Is Intended To Ease New Users Into Fedora Linux By Automating Setup Steps. This Script Is Meant To Be A One Input Plug And Play Script, However You May Be Prompted For Your `sudo` Password More Than Once, Due To Sudo Timeout. The Main Script Handles Updating System, Enabling Repositories, Proper Codec Installation, Package Installation, And A Few Tweaks. The Second Script Is Optional And Only Contains Additional Applications


---

### **Installation Instructions**

Copy And Paste Block Below Into Your Terminal And Let It Run:
* **Computer Will Reboot Automatically**
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
* (e.g. **Do Not Use "gamemoderun %command%" On Steam**)

## Linux App Store
- **Bazaar** (Recommended For New Linux Users)
- Only Flatpaks Will Show Up Here, Native Will Not. Steam Is Native, So It Will Not Show Up As Installed.

**If You're Unfamiliar With Any Of The Applications Listed Below, I Recommend Looking Into Them As Each Has Enough Value To Me To Remain Part Of The Core Setup**

## Gaming Applications Installed
- Steam (**Native**)
- Heroic (**Native**)
- Lutris (**Native**)
- Bottles (**Flatpak**)
- ProtonPlus (For Installing Proton-GE) (**Flatpak**)

## Important Applications
- BTRFS Assistant (System Snapshots) (**Native**)
- Gear Lever (For AppImages) (**Flatpak**)
- Flatseal (Managing Flatpak permissions) (**Flatpak**)
- Mission Center (Linux's Task Manager) (**Flatpak**)
- Disks//Gnome Disk Utility (Disk Manager) (**Native**)

## Other Applications
- GPU Screen Recorder (Better Shadow Play) (**Flatpak**)
- Discord (Discord) (**Native**)
- OBS (OBS) (**Native**)
- MangoHud/Goverlay (Performance Overlay) (**Native**)
- LACT (GPU Overclocking) (**Flatpak**)
- Winboat (For Windows Applications That Don't Run Through Wine) (**.rpm File**)
- Krita (Painting) (**Flatpak**)
- GIMP (Photo Editor) (**Flatpak**)
- Kdenlive (Video Editor) (**Flatpak**)
- Sober (Roblox) (**Flatpak**)
- Easy Effects (Auio Processor) (**Flatpak**)
- Extension Manager (Make Gnome Usable) (**Flatpak**)

## Things to Note
- **OBS Vulkan Layer And MangoHud Are Set Globally**, So You Do Not Need To Enable Them Manually For Vulkan Games
- **MangoHud Is Preconfigured** By The Script; Right Shift + F12 While In Game To Enable / Left Shift + F2 To Log That Data Into ~/Documents/MangoHud/
- Windows Fonts Installed
- BTRFS Assistant Is A Life Saver, Especially For New Users
- Games Probably Will Not Launch If Installed On NFTS Drives
- Use Proton-GE Whenever Available
- On Steam, I Would Recommend Turning On Background Processing Of Vulkan Shaders Under Download Settings
- Using "Disks" Is The Simplest Way, IMO, To Auto Mount Drives On Boot
- For New Linux Users; Linux Isn't Windows. Check Bazaar And/Or Discover/Software Before Downloading Software Off The Internet
- [IMPORTANT](https://github.com/Zutchey/FedoraPostInstallScript/tree/main?tab=readme-ov-file#important)

  
## Extra Terminal Commands Added
- `system-update` - Updates Your System's Native Packages And Flatpaks
- `mesa-git-install` - Installs Development Mesa Vulkan Drivers (Most Recent)
- `mesa-git-update` - Updates Development Mesa Vulkan Drivers
- `mesa-git-remove` - Development Back To Stable Vulkan Drivers

---

## Optional Additional Applications

```bash
cd ~/Downloads/FedoraPostInstallScript
chmod +x additionalSoftware.sh
systemd-inhibit --what=idle:sleep --why="Script running" ./additionalSoftware.sh
```
- Gedit (**Flatpak**)
- ani-cli (**Native**)
- qBittorrent (**Flatpak**)
- Gapless (**Flatpak**)
- kitty (**Native**)
- LocalSend (**Flatpak**)
- Spotify (**Flatpak**)
- Keypunch (**Flatpak**)
- Parabolic (**Flatpak**)
- Upscaler (**Flatpak**)
- Morphosis (**Flatpak**)
- Handbrake (**Flatpak**)
- ProtonVPN (**Flatpak**)
- osu! (**Flatpak**)
- Warehouse (**Flatpak**)
- Faugus (**Native**)


