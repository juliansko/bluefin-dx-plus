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

# Add Flutter Dev Dependencies
dnf install ninja-build clang cmake pkg-config gtk3-devel xz-devel xz-libs libstdc++-devel -y

# Add Pop Shell
dnf install gnome-shell-extension-pop-shell
