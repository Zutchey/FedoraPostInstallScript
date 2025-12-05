#!/bin/bash

sudo dnf copr enable xxmitsu/mesa-git -y

sudo dnf swap mesa-vulkan-drivers-freeworld mesa-vulkan-drivers -y

sudo dnf copr disable xxmitsu/mesa-git -y

echo Please Reboot Computer
