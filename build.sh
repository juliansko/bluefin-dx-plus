#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Add EduVPN
curl -O https://app.eduvpn.org/linux/v4/rpm/app+linux@eduvpn.org.asc
rpm --import app+linux@eduvpn.org.asc
cat << 'EOF' | tee /etc/yum.repos.d/python-eduvpn-client_v4.repo
[python-eduvpn-client_v4]
name=eduVPN for Linux 4.x (Fedora $releasever)
baseurl=https://app.eduvpn.org/linux/v4/rpm/fedora-$releasever-$basearch
gpgcheck=1
EOF
dnf install eduvpn-client -y

# Install Brave
curl -fsSLo /etc/yum.repos.d/brave-browser.repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
dnf install brave-browser -y

# Add Proton Apps
wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-unstable/protonvpn-beta-release/protonvpn-beta-release-1.0.2-1.noarch.rpm"
dnf install --nogpgcheck ./protonvpn-beta-release-1.0.2-1.noarch.rpm -y 
dnf install --nogpgcheck proton-vpn-gnome-desktop -y 

# Add Flutter Dev Dependencies
dnf install ninja-build clang cmake pkg-config gtk3-devel xz-devel xz-libs libstdc++-devel -y
