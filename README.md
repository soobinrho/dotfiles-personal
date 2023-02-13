<p align="center">
  <img src="https://user-images.githubusercontent.com/19341857/184075267-9818b003-480e-4ceb-a172-f7e6a1d686c7.gif">
</p>

***How exactly do you use this repository?***<br>
Whenever I reinstall my devices
for whatever reason, I go through
each step below.
These include the dotfiles and
configuration files I use.
For example, `.purelines.conf`
and `.bashrc` will give you the same
look as the image shown above.
Also included are all the softwares
I use daily.

***Which OS do you use?***<br>
I dual-boot on KDE Fedora and Windows.
On my primary laptop which has
two SSD's, I install Fedora
on the bigger disk and Windows on
the smaller disk, since Fedora is my main drive.
My second laptop, however, has
only one SSD, so it's
divided into two partitions --
e.g. 190GB for Fedora and 50GB for Windows.

```bash
# Repository Structure
# You can get this with `tree -a`
└── home
    └── soobinrho
        ├── .bashrc
        ├── .config
        │   ├── alacritty
        │   │   └── alacritty.yml
        │   ├── htop
        │   │   └── htoprc
        │   ├── konsolerc
        │   ├── neofetch
        │   │   └── config.conf
        │   ├── nvim
        │   │   ├── init.lua
        │   │   └── lua
        │   │       └── plugins.lua
        │   │           └── settings.lua
        │   └── obs-studio
        │       └── basic
        │           └── scenes
        │               └── rhetorics_practice.json
        ├── .editorconfig
        ├── global_extra_conf.py
        ├── .gnupg
        │   └── gpg-agent.conf
        ├── .local
        │   └── share
        │       └── konsole
        │           ├── Breeze.colorscheme
        │           └── Profile1.profile
        ├── .p10k.zsh
        ├── pureline.conf
        └── .zshrc
```

<br>
<br>

## Steps
[1.](#1-dev-tools-and-dotfiles) Dev Tools and Dotfiles<br>
&#160;&#160;&#160;&#160;[A.](#dev-tools) Dev Tools<br>
&#160;&#160;&#160;&#160;[B.](#git-configs) Git Configs<br>
&#160;&#160;&#160;&#160;[C.](#vim-configs) Vim Configs<br>
&#160;&#160;&#160;&#160;[D.](#dotfiles-installation) Dotfiles Installation<br>
[2.](#2-optional-ssh-server-configs) (Optional) SSH Server Configs<br>
[3.](#3-optional-virtual-private-server-configs) (Optional) Virtual Private Server Configs<br>
[4.](#4-optional-random-tips-i-find-useful) (Optional) Random Tips I Find Useful


<br>
<br>

# 1. Dev Tools and Dotfiles

## Dev Tools

### `Installing zsh`

```bash
# Install zsh
sudo dnf install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh theme: powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

<br>

### `Installing Node.js`

```bash
# Install nvm: Node version manager.
# After installing nvm, close and reopen terminal,
# in order for new paths to take effect.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install Node.js
nvm install node

# Install TypeScript
npm install -g typescript
```

<br>

### `Installing Nvidia Driver for Quadro T1000`

https://developer.nvidia.com/cuda-toolkit

<br>

### `Installing programming environments`

```bash
# Add yourself to the sudo group
sudo usermod -aG wheel $(whoami)

# dnf-automatic updates everyday automatically
sudo dnf install -y dnf-automatic
sudo systemctl enable --now dnf-automatic-install.timer

# Install git
sudo dnf install -y git

# Enable RPM Fusion repositories
sudo dnf install -y \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install R
sudo dnf install -y R

# Install PowerShell
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo rpm -Uvh https://packages.microsoft.com/config/centos/8/packages-microsoft-prod.rpm
sudo dnf update -y
sudo dnf install -y powershell

# Install Alacritty, a fast OpenGL terminal emulator.
# I normally use Konsole because - unlike Alacritty - Konsole
# remembers the last window position. When I need speed, however,
# Alacritty tends to be better smoother and faster because
# it knows how to use both the CPU and the graphics cards.
git clone https://github.com/alacritty/alacritty.git
cd alacritty
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup override set stable
rustup update stable
sudo dnf install -y cmake freetype-devel fontconfig-devel libxcb-devel libxkbcommon-devel g++
cargo build --release
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
cd ..
rm -rf ./alacritty

# Install neovim: more extensible fork of vim
sudo dnf install -y vim wl-clipboard xclip ripgrep fd-find
bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/rolling/utils/installer/install-neovim-from-release)
ln -s /home/$USER/.local/bin/nvim /usr/local/bin/nvim

# Install Visual Studio Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code

# Install steghide: steganography library
sudo dnf install -y steghide

# Install gh: GitHub CLI
sudo dnf install -y gh

# Install git-lfs: Git Large File Storage
sudo dnf install -y git-lfs

# Install LaTex environment
sudo dnf install -y texlive-scheme-full texstudio

# Install Chrome
# https://www.google.com/intl/en_us/chrome/

# Install Java
# https://www.oracle.com/java/technologies/downloads/

# Install Anaconda:
#   https://www.anaconda.com/
# In my case, because of Anaconda,
# my shell startup time became slower.
# You can fix this with the following command.
conda init
conda config --set auto_activate_base false
conda update anaconda
conda update jupyterlab

# Now, your shell startup time will be normal again.
# Whenever you need Anaconda, run
# `conda activate`
```

<!--
# Install MariaDB
sudo dnf install -y mariadb

# Install MariaDB server
sudo dnf install -y mariadb-server

# Install MariaDB ODBC
sudo dnf install -y mariadb-connector-odbc

-->

<br>

### `Installing additional utilities`

```bash
# Install neofetch: system information viewer
sudo dnf install -y neofetch

# Install htop: process viewer
sudo dnf install -y htop

# Install ncdu: disk usage viewer
sudo dnf install -y ncdu

# Install yarn: a faster, parallel package manager
npm install -g yarn

# Install tldr: similar to [man], but with simple examples
npm install -g tldr

# Install bat: colored, cooler version of cat
sudo dnf install -y bat

# Install loadtest: server load testing tool
npm install -g loadtest

# Install asciinema: terminal session recording tool
sudo dnf install -y asciinema

# Install svg-term-cli: asciinema to svg converter
npm install -g svg-term-cli

# Install xournal: pdf annotation tool
sudo dnf install -y xournal

# Install obs-studio: screencasting/streaming tool
sudo dnf install -y obs-studio

# Install FFmpeg: multimedia encoding/decoding tool
sudo dnf install -y ffmpeg

# Install simplescreenrecorder: light-weight screencasting tool
sudo dnf install -y simplescreenrecorder

# Install vlc: video player
sudo dnf install -y vlc

# Install hstr: shell history search tool
sudo dnf install -y hstr

# Install Ruby
# Source:
#   https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
~/.rbenv/bin/rbenv init
rbenv install 3.1.2
rbenv global 3.1.2
gem install bundler
rbenv rehash
dnf install -y gcc rust patch make bzip2 openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel
sudo dnf group install -y "C Development Tools and Libraries"

# Install colorls: colored, cooler version of ls
gem install colorls

# Install nerd-fonts: fonts with better icons support
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
nerd-fonts/install.sh
rm -rf nerd-fonts

# Install fzf: shell fuzzy finder
# My favorite option for fzf: `cat **<Tab>`
# https://github.com/junegunn/fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install z.lua: a faster, cooler version of cd
# My favorite option for z.lua: `z dotfiles`
git clone https://github.com/skywind3000/z.lua.git ~/.local/z.lua/

# Install glow: markdown reader
echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=0' | sudo tee /etc/yum.repos.d/charm.repo
sudo yum install -y glow

# Install http-tanker: interactive http-requests tool
curl -sSL https://raw.githubusercontent.com/PierreKieffer/http-tanker/master/install/install_tanker64_linux.sh | bash

# Install PureLine: bash powerline
git clone https://github.com/chris-marsh/pureline.git ~/pureline

# Remove nano in order to make vim the default editor
sudo dnf remove -y nano
```

<br>
<br>

## Git Configs

### `(Optional) Signing git commits with a GPG key` [[Source](https://wouterdeschuyter.be/blog/verified-signed-commits-on-github)]

```bash
# Set up git name, email, and default editor
git config --global user.name "Soobin Rho"
git config --global user.email "soobinrho@gmail.com"
git config --global core.editor vim

# Create a GPG key
gpg --full-generate-key

# Select RSA and RSA
1

# Select the length to be 4096
4096

# Set the key to never expire
0

# Set the key's user ID as my name and GitHub email address
Soobin Rho
soobinrho@gmail.com

# Get the key's key ID.
# You'll get an output like this:
# sec    rsa4096/BC0596A444D39F64 2022-07-06
# BC0596A444D39F64 is the key ID.
gpg --list-secret-keys --keyid-format LONG

# Copy and paste the key's public key to GitHub's GPG Key section settings
gpg --armor --export BC0596A444D39F64

# Configure git to sign all commits with the key
git config --global user.signingkey BC0596A444D39F64
git config --global commit.gpgSign true

# Yes, your commits are now signed with
# your GPG key. Furthermore, you might want
# to signoff your commits for
# Developer Certificate of Origin (DCO)
# as well. You can do this by running:
git config --global alias.c 'commit -s'

# Now, you can commit with
# git c -am'Commit message.'
# Your commits will be signed with
# both your GPG key and the DCO.

# Set default branch name to main instead of master
git config --global init.defaultBranch main
```

<br>
<br>

## Vim Configs

<!--
```bash
# Install Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install plugins listed at ~/.nvim/lua/plugins.lua
nvim -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```
-->
```bash
# Install Astrovim
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
nvim +PackerSync

# Open nvim
nvim

# Install specific LSP servers and language parsers
# Source:
#   https://astronvim.github.io/
:LspInstall
:TSInstall <Name of the language>

# Install debugger
# Follow instructions at:
#   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
```

<br>
<br>

### `Dotfiles Installation`

```bash
# Install Dotbot
pip install dotbot

# Install all the dotfiles
mkdir ~/git
cd ~/git
git clone https://github.com/soobinrho/dotfiles-personal.git
cd dotfiles-personal
dotbot -c ./install.conf.yaml

# The command above installs all dotfiles
# in this repository. If you'd like to
# install only a part of it, then you can
# eitehr cp individually one by one
# or edit `install.conf.yaml`
```

<br>

Now, Dotbot created symlinks
to the dotfiles located in this repository.
For example, Dotbot just created `~/.bashrc`,
which is a symlink to
`~/git/dotfiles-personal/home/soobinrho/bashrc`.

Therefore, whenever you want to
modify any of the dotfiles, we
do not have to make
changes twice both in `~/` directory
dotfiles and in `dotfiles-personal` directory.
Just modify any dotfile here
in `dotfiles-personal`.

<br>
<br>

# 2. (Optional) SSH Server Configs

***Why do you use a SSH server?***<br>
I try to use SSH servers only on
virtual private servers because I don't want
to expose port 22 on my personal device.
However, there was a time in which I needed
to SSH into my second laptop from my primary laptop.

So, here's how I set up a SSH server on my second laptop.
Port 22 is likely to be secure as long as it is updated
to the latest version and `sshd_config` is configured
securely as shown two sections below. Nevertheless,
the best way to prevent a malicious hacker from getting
into port 22 is to make it unavailable. So,stop the
SSH server as soon as you're done.

<br>

### `Starting a SSH server on my second laptop` [[Source](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys)]

```bash
# Start the SSH server
sudo service sshd start

# When you're done with SSH, stop the SSH server.
# Actually, it stops automaticaly when you reboot
# but you can stop it without rebooting.
sudo service sshd stop
```

<br>

### `Configuring sshd_config` [[Source](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys)]

```bash
# Open the config file
sudo vim /etc/ssh/sshd_config

# Disallow password authentication
# so that only the RSA SSH key can be used
PasswordAuthentication no

# Restart SSH
sudo service sshd restart    # Fedora
sudo service ssh restart    # Ubuntu
```

<br>

### `(DANGER) Copying both the public GPG key and private GPG key from my primary laptop to my second laptop`

```bash
# (DANGER) Copy both the private and public GPG keys.
# Note that I'm copying my private key as well
# because both the SSH server and client are my personal laptops.
# Never transfer your private keys, unless you absolutely need to.
rsync --archive ~/.gnupg $(whoami)@ip_address:~

# The --archive option preserves
# all permissions, modification times, and
# everytihng inside the directory recursively
```

<br>

### `(DANGER) Copying both the public SSH key and private SSH key from my primary laptop to my second laptop`

```bash
# (DANGER) Copy both the private and public SSH keys.
# This also copies `authorized_keys`, `config`, and `known_hosts`.
# Again, never transfer your private keys, unless you absolutely need to.
rsync --archive ~/.ssh $(whoami)@ip_address:~
rsync --archive ~/.gitconfig $(whoami)@ip_address:~/.gitconfig
```

<br>

### `(Optional) Creating a key as a SSH client on my primary laptop` [[Source](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04)]

```bash
# Create a key with the length of 4096 bits
ssh-keygen -b 4096

# Copy the public key to the SSH server
ssh-copy-id root@ip_address
```

<br>

### `(Optional) Client-side SSH configuration I use on my primary laptop` [[Source](https://unix.stackexchange.com/questions/708206/ssh-timeout-does-not-happen-and-not-disconnect)]

```bash
# Configuring your SSH client to time-out less frequently
cat >> ~/.ssh/config
Host *
  ServerAliveInterval 15
  ServerAliveCountMax 3

# Creating an alias so that we can
# `ssh myserver` instead of `ssh main@ip_address`
# It's nice to be able to ssh without ip_address.
cat >> ~/.ssh/config
Host myserver
    HostName ip_address
    User main
```

<br>

### `(Optional) Disableing updates for specific packages` [[Source](https://www.tecmint.com/exclude-package-updates-yum-dnf-command/)]

If you by any chance have to disable
dnf updates on specific packages:

```bash
sudo vim /etc/dnf/dnf.conf

# Add the following line:
exclude=package-name-version18*
```

<br>
<br>

# 3. (Optional) Virtual Private Server Configs

Here's how I configure my VPS's for web apps.

<br>

### `Initializing an Ubuntu server on DigitalOcean` [[Source](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04)]

```bash
# SSH into the server
ssh root@ip_address

# Set up the firewall
ufw allow OpenSSH
ufw enable

# Create a user account
adduser main
usermod -aG sudo main

# Copy the public key from the root to the user that we just created
rsync --archive --chown=main:main /root/.ssh /home/main
```

<br>

### `Installing Docker Engine on Ubuntu` [[Source](https://docs.docker.com/engine/install/ubuntu/)]

```bash
# Update apt
sudo apt update

# Add the official Docker repository to apt
sudo apt install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine.
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Add your account to the group docker
# so that you can use it without sudo.
sudo groupadd docker
sudo usermod -aG docker $USER

# Re-login so that the changes can be applied.
su -l $USER
```

<br>

### `Installing Docker Engine on Fedora` [[Source](https://docs.docker.com/engine/install/fedora/)]

```bash
# Add the official Docker repository to dnf
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

# Install Docker Engine
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# On Ubuntu, Docker service starts automatically,
# but on Fedora, Docker service should be started with
sudo systemctl start docker

# Add your account to the group docker so that you can use it without sudo
sudo groupadd docker
sudo usermod -aG docker $USER

# Re-login so that the changes can be applied
su -l $USER
```

<br>

### `Installing Kubernetes on Fedora` [[Source](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

```bash
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

sudo systemctl enable --now kubelet
```

<br>

### `Installing Cloudflare Tunnel on the Server`

```bash
# Install Cloudflare Tunnel on the server
#   https://one.dash.cloudflare.com/
#   Installation script is available at the `Access - Tunnels` setting.

# Block all IP's and then only allow Cloudflare IP addresses,
# so that the server is only accessible through Cloudflare Tunnel,
# and direct access to the server is blocked for better security.
# Source:
#   https://github.com/Paul-Reed/cloudflare-ufw
sudo ufw disable
sudo ufw reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from 192.168.1.0/24

# Allow Cloudflare's IP addresses
# Source:
cd ~
git clone https://github.com/Paul-Reed/cloudflare-ufw.git
sudo ~/cloudflare-ufw/cloudflare-ufw.sh
sudo crontab -e
```
```
0 0 * * 1 /home/myusername/cloudflare-ufw/cloudflare-ufw.sh > /dev/null 2>&1
```
```bash
# Confirm all IP rules have been set
sudo ufw enable
sudo ufw status verbose
```

<br>

### `Installing Cloudflared Client for SSH Users`

```bash
# Install Cloudflared on the computer,
# from which you're accessing the server
#   https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/use_cases/ssh/#2-connect-as-a-user

# Add Public hostname: `ssh.example.com` and
# Service: ssh://localhost:22
# at the `Access - Tunnels - Configure` setting at
#   https://one.dash.cloudflare.com/

# Edit ssh config so that ssh command authenticates using Cloudflared
vim ~/.ssh/config
```
```
# Edit example.com to your server's domain name and
# edit myusername to your user name
Host ssh.example.com
ProxyCommand /usr/bin/cloudflared access ssh --hostname %h

Host devserver
    HostName ssh.example.com
    User myusername
```

<br>

### `Disabling GUI in Ubuntu`

```bash
# Disable the GUI
sudo apt remove lightdm

# Re-enable the GUI
sudo apt install lightdm
reboot
```

<br>

### `Fedora, Ubuntu, and Windows Triple Boot`

```bash
# Install Windows, Ubuntu, and then Fedora

# How to make a Fedora / Ubuntu installation USB
lsblk -e7
sudo dd if=Fedora-KDE.iso of=/dev/sdb bs=16M oflag=direct; sync

# How to make a Windows installation USB
sudo dnf install WoeUSB
sudo woeusb --device Win10.iso /dev/sdb --target-filesystem ntfs
```

<br>
<br>

<!--

###
# June 3, 2022
# Learned about git using `info gittutorial'.
# summary of what i learned today:
# ```
# git init
# git add readme.md
# git commit -am 'description'
# git push
#
# git status
# git diff
# ```
###

###
# june 4, 2022
# shell scripts can have the file extension of `.sh` but it can
# be more useful to leave it without any extension. instead,
# just put the shebang `#!/bin/bash` at the first one.
# plus, use `chmod +x` to make this script executable.
#
# also, apparently, this convention called shebang is not used
# on windows. `.sh` convention is used in windows. since i'm using
# fedora, i'm going to stick to the shebang convention.
#
# source: https://stackoverflow.com/questions/27813563/what-is-the-bash-file-extension
###

###
# June 21, 2022
# For my Calc II midterm exam, I needed a proctor service.
# So, I was filling out the Examination Proctor Agreement form,
# which was a pdf. However, okular, the default pdf viewer for
# Fedora happens to have a not-so-perfect annotation functionality.
# The annotations I make in okular would not be visible in any
# other software than okular itself. So, I tried to find
# pdf editing softwares with good annotation functionality.
# Here's what I found and used and liked: xournal
#
# sudo dnf install -y xournal
#

###
# June 21, 2022
# For the README.MD for my "Latex Template for College Assignments"
# I had to add an example image. After x, y, and z, I decided
# that I needed to add a light grey (HTML Color Code F6F8FA)
# border around the picture so that it doesn't just blend in too much
# with a white background -- e.g. GitHub on desktop.
# I used Gimp. 'Filter' 'Decor' 'Border' size 4, D value 1
#
# Plus, you can see the HTML color code on any website on Chrome
# on Chrome Developer's mode by typing Ctrl + Shift + c

###
# June 22, 2022
# Building Unreal Engine 5
# When executing GenerateProjectFiles.sh, my computer
# kept throwing an error related to SSL certs.
# Solution turns out to be this:
# https://forums.unrealengine.com/t/error-compiling-unreal-engine-on-arch-linux/549637/12
# sudo dnf reinstall openssl
# sudo mkdir /usr/local/ssl
# sudo ln -s /etc/ssl/certs /usr/local/ssl
# sudo mkdir /usr/lib/ssl
# sudo ln -s /etc/ssl/certs /usr/lib/ssl

###
# July 24, 2022
# ctrl + shift + u and then type unicode and then space
# 2192 = right arrow →

###
# by the way, you can copy something on to the clipboard on vim
# and then paste it onto another console by
# ```
# v
# "+y
# ctrl+shift+v
# ```
# this functionality is not available on normal vim though.
# on fedora, you can use this functionality by installing
# `vimx` and - of course - by using vimx to edit the files.

# I am so glad to have found the "top of the INFO tree."
# It has documentations for everything, including
# core file manipulation, Gzip, grep, etc.
# `info '(dir)Top'`, or `info bash` and 'u'.

# *cut* command
# This command is useful for filtering data.
# `who | cut -c 1-8' outputs the first eight characters.
# 'who | cut -d' ' -f1,2' sets the delimiter as ' ' and
# outputs the first and second columns.

# *sort* command
# Example: 'who | cut -d' ' -f2 | sort -r' outputs
# the data in the reversed order.

# *uniq* command
# Example: 'who | cut -d' ' -f1 | uniq' removes
# all the dulplicates and outputs only the unique data.

![Calc II Tips](https://user-images.githubusercontent.com/19341857/184079510-d7899b35-e114-4f50-a8a8-ab0c3a1384d5.png)

Codes should describe what they do themselves.
Comments, in the other hand, should describe
why those codes are there.

-->

# 4. (Optional) Random Tips I find Useful

### `How to make a screencast gif`

```bash
# 1. Screencast with the simplescreenrecorder or obs-studio.

# 2. Go to gifski's GitHub page and then build from source.
#    https://github.com/ImageOptim/gifski

# 3. Convert the screencast video into png files.
ffmpeg -i example.mkv frame%04d.png

# 4. Convert to gif.
~/gifski/target/release/gifski -o example.gif frame*.png --repeat 0 -Q 100 --fps 50 -W 960 -H 516
```

<br>

If you're just trying to turn a terminal
session into a gif, there's a simpler way
using asciinema and svg-term-cli.

```bash
# Record a terminal session
asciinema rec

# Convert the asciinema into a svg file
svg-term --cast=11345 --out example.svg
```

<br>

### `How to stream OBS to yourself using Nginx` [[Source](https://obsproject.com/forum/resources/how-to-set-up-your-own-private-rtmp-server-using-nginx.50)]

For gaining practice on my rhetorics,
I needed a way to listen to my own speech.
I needed a program that will play what’s recorded into the
mic with a delay of around five seconds. The best solution for my
use cases turned out to be OBS and a private rtmp server.

```bash
# Download the latest mainline Nginx
wget http://nginx.org/download/nginx-1.23.3.tar.gz

# Download the Nginx RTMP module
wget https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/archive/dev.zip

tar -zxvf nginx-1.23.3.tar.gz
unzip dev.zip
cd nginx-1.23.3

./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-dev
make
sudo make install

# Add rtmp to the Nginx conf file
vim /usr/local/nginx/conf/nginx.conf
```

Copy and paste the following to the end of the file.

```
rtmp {
        server {
                listen 1935;
                chunk_size 4096;
                deny all;
                allow 127.0.0.1;

                application live {
                        live on;
                        record off;
                }
        }
}
```
```bash
# Start Nginx
sudo /usr/local/nginx/sbin/nginx

# HOW TO PLAY THE STREAM WITH VLC
# 1. Open VLC
# 2. Click "Play", the triangle thingy
# 3. Click "Network"
# 4. Enter rtmp://127.0.0.1:1935/live

# Stop Nginx when you're done
sudo /usr/local/nginx/sbin/nginx -s stop
```

<br>

### `School WIFI`

https://cat.eduroam.org

<br>

### `My favorite keyboard shortcuts`

**Fedora**
- `Windows` + `LMB` Move a window.
- `Windows` + `RMB` Resize a window.
- `ctrl` + `alt` + `T` Open a terminal.

```bash
# Enable multiple audio outputs.
pactl load-module module-combine-sink
```

**Vim**
- `gc` Comment visual mode.
- `gcc` Comment out a line.
- `gcap` Comment out a paragraph.
- `:7,17Commentary` Comment out with line numbers.
- `m[A-Z]` Set a marker and `'[A-Z]` go to the marker.
- `q:` Open command-history buffer.
- `:ene|e` Edit a file in a new buffer, short for `:enew|edit`.
- `:Start` Open a terminal.
This will work only if you've installed
vim-dispatch. If you followed the
steps above, vim-dispatch is
already installed. However, if you'd like
an alternative that works without
vin-dispatch or any other plugin,
`:! konsole` works too, but
`:! konsole` defaults back to the vanilla
Konsole look, while `:Start` looks amazing
since it's able to load all our styles.

**Bash**
```bash
# Shutdown
poweroff

# Suspend
systemctl suspend

# Execute the last command
`ctrl` + `p`

# Go to top level of internal documentation
info bash
u

# Find files containing a certain text/
egrep -ir "Certain text"

# Edit files with sudo access
sudoedit ...

# Read in hexadecimal
xxd ...

# Git rebase
git rebase -i HEAD~2

# ncat: check if a port is exposed
nc -vz <HOSTNAME> 9000
```

<!---
Vim commands
/search-term  |   n   |   shift + n   |   Search
:%s/search-term/replaceterm/gc   |   Search and replace
visual-mode-selection + :s/^/#   |   Comment block
ctrl + v + shift + i   |   Visual block mode

A good example of bash installation script
https://github.com/IBM-Cloud/ibm-cloud-cli-release/releases/


OBS Studio Settings
Settings - Stream - Server:
rtmp://127.0.0.1:1935/live

This rhetorics settings requires Nginx server.
The installation is described in my Google Docs

Extracting a high quality audio from a video file
ffmpeg -i sample.avi -q:a 0 -map a sample.mp3
-->

<br>
<br>
<br>
