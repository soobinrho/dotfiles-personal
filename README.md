<p align="center">
  <img src="https://user-images.githubusercontent.com/19341857/183757248-3d542f5c-81cd-42a4-b2bc-363fb9110fc4.png" width="600">
</p>

***How exactly do you use this repository?***
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

***Which OS do you use?***
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
├── home
│   └── soobinrho
│       ├── .bashrc
│       ├── .config
│       │   └── htop
│       │       └── htoprc
│       ├── .editorconfig
│       ├── global_extra_conf.py
│       ├── .gnupg
│       │   └── gpg-agent.conf
│       ├── .local
│       │   └── share
│       │       └── konsole
│       │           ├── Breeze.colorscheme
│       │           └── Profile1.profile
│       ├── .pureline.conf
│       ├── .vim
│       │   └── plugins.vim
│       └── .vimrc
```

<br>
<br>

## Steps
[1.](#1-dotfiles-and-dev-tools) Dotfiles and Dev Tools<br>
&#160;&#160;&#160;&#160;[A.](#installation) Installation<br>
&#160;&#160;&#160;&#160;[B.](#bash-configs) Bash Configs<br>
&#160;&#160;&#160;&#160;[C.](#vim-configs) Vim Configs<br>
&#160;&#160;&#160;&#160;[D.](#git-configs) Git Configs<br>
[2.](#2-optional-ssh-server-configs) (Optional) SSH Server Configs<br>
[3.](#3-optional-virtual-private-server-configs) (Optional) Virtual Private Server Configs<br>


<br>
<br>

# 1. Dotfiles and Dev Tools

## Installation

```bash
# Add yourself to the sudo group.
sudo usermod -aG wheel $(whoami)

# Install git.
sudo dnf install -y git

# Install Dotbot.
pip install dotbot

# Install all the dotfiles.
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

Here's how the rest of my setup
goes, installing all of the softwares I use:

**Installing system utilities**

```bash
# Install dnf-automatic
# so that dnf updates everyday automatically.
sudo dnf install -y dnf-automatic
sudo systemctl enable --now dnf-automatic-install.timer

# Enable RPM Fusion repositories.
sudo dnf install -y \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

<br>

**Installing Node.js**

```bash
# Install nvm: Node version manager.
# After installing nvm, close and reopen terminal,
# in order for new paths to take effect.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install Node.js: JavaScript runtime.
nvm install node
```

<br>

**Installing programming environments**

```bash
# Install neovim: more extensible fork of vim.
sudo dnf install -y neovim python3-neovim vim

# Install steghide: steganography library.
sudo dnf install -y steghide

# Install gh: GitHub CLI.
sudo dnf install -y gh

# Install git-lfs: Git Large File Storage.
sudo dnf install -y git-lfs

# Install Chrome.
# https://www.google.com/intl/en_us/chrome/

# Install Java.
# https://www.oracle.com/java/technologies/downloads/

# Install LaTex environment.
sudo dnf install -y texlive-scheme-full texstudio

# Install Anaconda.
# https://www.anaconda.com/
# In my case, because of Anaconda,
# my shell startup time became slower.
# You can fix this with the following command.
conda config --set auto_activate_base false

# Now, your shell startup time will be normal again.
# Whenever you need Anaconda, run
# `conda activate`
```

<br>

**Installing additional utilities**

```bash
# Install neofetch: system information viewer.
sudo dnf install -y neofetch

# Install htop: process viewer.
sudo dnf install -y htop ncdu

# Install yarn: faster, parallel package manager.
npm install -g yarn

# Install tldr: like man, but with simple examples.
npm install -g tldr

# Install bat: colored, cooler version of cat.
sudo dnf install -y bat

# Install asciinema: terminal session recording tool.
sudo dnf install -y asciinema

# Install xournal: pdf annotation tool.
sudo dnf install -y xournal

# Install obs-studio: screencasting tool.
sudo dnf install -y obs-studio

# Install simplescreenrecorder: light-weight screencasting tool.
sudo dnf install -y simplescreenrecorder

# Install vlc: video player.
sudo dnf install -y vlc

# Install hstr: shell history search tool.
sudo dnf install -y hstr

# Install colorls: colored, cooler version of ls.
sudo dnf install -y ruby-devel
sudo dnf group install -y "C Development Tools and Libraries"
gem install colorls

# Install nerd-fonts: fonts with better icons support.
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
nerd-fonts/install.sh
rm -rf nerd-fonts

# Install fzf: shell fuzzy finder.
# My favorite option for fzf: `cat **<Tab>`
# https://github.com/junegunn/fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install z.lua: faster, cooler version of cd.
# My favorite option for z.lua: `z dotfiles`
# https://github.com/skywind3000/z.lua.git
git clone https://github.com/skywind3000/z.lua.git ~/.local/z.lua/

# Install glow: markdown reader.
# My favorite option for glow: `glow -p README.md`
# https://github.com/charmbracelet/glow
echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=0' | sudo tee /etc/yum.repos.d/charm.repo
sudo yum install -y glow

# Install http-tanker: interactive http-requests tool.
curl -sSL https://raw.githubusercontent.com/PierreKieffer/http-tanker/master/install/install_tanker64_linux.sh | bash
```

<br>

## Bash Configs

**Setting up PureLine
[[GitHub](https://github.com/chris-marsh/pureline)]**

```bash
# Install PureLine.
cd ~
git clone https://github.com/chris-marsh/pureline.git
```

<br>

## Vim Configs

**Adding Vim Plugins
[[Original article by Alex Hunt](https://medium.com/@huntie/10-essential-vim-plugins-for-2018-39957190b7a9)]**

```bash
# Install vim-plug.
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install YouCompleteMe.
sudo dnf install -y cmake gcc-c++ make python3-devel golang
cd ~/.vim/plugged
git clone --recurse-submodules https://github.com/ycm-core/YouCompleteMe.git
cd YouCompleteMe
python3 install.py --all

# Install vim-prettier.
npm install -g prettier
mkdir -p ~/.vim/pack/plugins/start
cd ~/.vim/pack/plugins/start
git clone https://github.com/prettier/vim-prettier

# Install rest of the plugins listed at
# `./home/$(whoami)/.vim/plugins.vim`
vim
:PlugInstall
```

<br>

## Git Configs

**(Optional) Signing git commits with a GPG key
[[Original article by Wouter De Schuyter](https://wouterdeschuyter.be/blog/verified-signed-commits-on-github)]**

```bash
# Set up git name and email.
git config --global user.name "Soobin Rho"
git config --global user.email "soobinrho@gmail.com"

# Create a GPG key.
gpg --full-generate-key

# Select RSA and RSA.
1

# Select the length to be 4096.
4096

# Set the key to never expire.
0

# Set the key's user ID as my name and
# GitHub email address.
Soobin Rho
soobinrho@gmail.com

# Get the key's key ID.
# You'll get an output like this:
# sec    rsa4096/BC0596A444D39F64 2022-07-06
# BC0596A444D39F64 is the key ID.
gpg --list-secret-keys --keyid-format LONG

# Copy and paste the key's public key
# to GitHub's GPG Key section settings.
gpg --armor --export BC0596A444D39F64

# Configure git to sign all commits with the key.
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

# Set default branch name to main
# instead of master.
git config --global init.defaultBranch main
```

<br>
<br>

# 2. (Optional) SSH Server Configs

***Why do you use a SSH server?***
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

**Starting a SSH server on my second laptop
[[Original article by Justin Ellingwood](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys)]**

```bash
# Start the SSH server.
sudo service sshd start

# When you're done with SSH, stop the SSH server.
# Actually, it stops automaticaly when you reboot
# but you can stop it without rebooting.
sudo service sshd stop
```

<br>

**Configuring `sshd_config`
[[Original article by Justin Ellingwood](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys)]**

```bash
# Open the config file.
sudo vim /etc/ssh/sshd_config

# Disallow password authentication
# so that only the RSA SSH key can be used.
PasswordAuthentication no

# Disable root login.
PermitRootLogin no

# Restart SSH.
sudo service sshd restart    # Fedora
sudo service ssh restart    # Ubuntu
```

<br>

**(DANGER) Copying both the public GPG key and private GPG key
from my primary laptop to my second laptop**

```bash
# (DANGER) Copy both the private and public GPG keys.
# Note that I'm copying my private key as well
# because both the SSH server and client are my personal laptops.
# Never transfer your private keys, unless you absolutely need to.
rsync --archive ~/.gnupg $(whoami)@ip_address:~

# The --archive option preserves
# all permissions, modification times, and
# everytihng inside the directory recursively.

```

<br>

**(DANGER) Copying both the public SSH key and private SSH key
from my primary laptop to my second laptop**

```bash
# (DANGER) Copy both the private and public SSH keys.
# This also copies `authorized_keys`, `config`, and `known_hosts`.
# Again, never transfer your private keys, unless you absolutely need to.
rsync --archive ~/.ssh $(whoami)@ip_address:~
rsync --archive ~/.gitconfig $(whoami)@ip_address:~/.gitconfig
```

<br>

**(Optional) Creating a key as a SSH client on my primary laptop
[[Original article by Brian Boucheron](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04)]**

```bash
# Create a key with the length of 4096 bits.
ssh-keygen -b 4096

# Copy the public key to the SSH server.
ssh-copy-id root@ip_address
```

<br>

**(Optional) Client-side SSH configuration I use on my primary laptop
[[Original Answer by laur](https://unix.stackexchange.com/questions/708206/ssh-timeout-does-not-happen-and-not-disconnect)]**

```bash
# Configuring your SSH client to
# time-out less frequently.
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

**(Optional) Disableing updates for specific packages
[[Original Article by Techmint](https://www.tecmint.com/exclude-package-updates-yum-dnf-command/)]**

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

**Initializing an Ubuntu server on DigitalOcean
[[Original article by Brian Boucheron](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04)]**

```bash
# SSH into the server.
ssh root@ip_address

# Set up the firewall.
ufw allow OpenSSH
ufw enable

# Create a user account.
adduser main
usermod -aG sudo main

# Copy the public key from the root
# to the user that we just created.
rsync --archive --chown=main:main /root/.ssh /home/main
```

<br>

**Installing Docker Engine on Ubuntu
[[Original article by Docker](https://docs.docker.com/engine/install/ubuntu/)]**

```bash
# Update apt.
sudo apt update

# Add the official Docker repository to apt.
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

**Installing Docker Engine on Fedora
[[Original article by Docker](https://docs.docker.com/engine/install/fedora/)]**

```bash
# Add the official Docker repository to dnf.
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

# Install Docker Engine.
sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# On Ubuntu, Docker service starts automatically,
# but on Fedora, Docker service should be started with
sudo systemctl start docker

# Add your account to the group docker
# so that you can use it without sudo.
sudo groupadd docker
sudo usermod -aG docker $USER

# Re-login so that the changes can be applied.
su -l $USER
```

<br>
<br>
<br>

<!--
**Converting a screencast video into
a gif file with high quality
[[GitHub](https://github.com/ImageOptim/gifski)]**

```bash
# 1. Screencast with the simplescreenrecorder package.

# 2. First, go to gifski's GitHub page and then build from source.

# 3. Convert the video into png.
ffmpeg -i example.mkv frame%04d.png

# 4. COnvert to gif.
~/gifski/target/release/gifski -o output.gif frame*.png --repeat 0 -Q 100 --fps 60 -W 1920 -H 1080
```
-->
