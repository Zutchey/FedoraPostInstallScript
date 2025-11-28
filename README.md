## FedoraPostInstallScript


## Important Warnings & Prerequisites

* **NOT TESTED ON NVIDIA OR INTEL GPUS!** This script primarily uses configurations favorable for **AMD** users.
* **Fresh Install Recommended:** Running this on an existing system **might delete your already set configurations**. Proceed with caution.
* **Sudo Password:** You may be prompted for your `sudo` password more than once.
* **Purpose:** This script is intended to ease new users into the Linux ecosystem by automating complex setup steps.

---

## 1. Core System Setup & Optimization (Main Install)

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
