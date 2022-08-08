<p align="center">
  <img src="https://user-images.githubusercontent.com/19341857/181281095-b56a803b-9530-4cd3-bc57-27bb0239d823.png" width="600">
</p>

These are the dotfiles and
configuration files I use personally.

```bash
# tree -a
├── home
│   └── soobinrho
│       ├── .bashrc
│       ├── .editorconfig
│       ├── .gnupg
│       │   └── gpg-agent.conf
│       ├── .local
│       │   └── share
│       │       └── konsole
│       │           └── Profile 1.profile
│       ├── .pureline.conf
│       ├── .vim
│       │   └── plugins.vim
│       └── .vimrc
```

<br>
<br>

## Configuration Files and Dotfiles
[1.](#1-dev-tools-configs) Dev Tools Configs<br>
&#160;&#160;&#160;&#160;[A.](#bash) Bash<br>
&#160;&#160;&#160;&#160;[B.](#vim) Vim<br>
&#160;&#160;&#160;&#160;[C.](#git) Git<br>
[2.](#2-virtual-private-server-configs) Virtual Private Server Configs<br>
[3.](#3-ssh-configs-for-my-laptops) SSH Configs for my Laptops<br>

<br>
<br>

# 1. Dev Tools Configs

```bash
# Install programming environment.
sudo dnf install -y vim npm steghide gh

# Install Anaconda.
# https://www.anaconda.com/

# Install Java.
# https://www.oracle.com/java/technologies/downloads/

# Install tex environment.
sudo dnf install -y texlive texstudio

# Install system monitoring tools.
sudo dnf install -y htop ncdu

# Install additional utilities.
sudo dnf install -y bat asciinema xournal vlc obs

# Install z.lua
# https://github.com/skywind3000/z.lua.git
git clone https://github.com/skywind3000/z.lua.git ~/.local/z.lua/

# Install chrome.
sudo dnf install fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install -y google-chrome-stable
```

## Bash

**Setting up PureLine
[[GitHub](https://github.com/chris-marsh/pureline)]**

```bash
# Install PureLine.
cd ~
git clone https://github.com/chris-marsh/pureline.git
cp pureline/configs/powerline_full_256col.conf ~/.pureline.conf

# Add the following lines to anywhere on ~/.bashrc
if [ "$TERM" != "linux" ]; then
    source ~/pureline/pureline ~/.pureline.conf
fi
```

<br>

## Vim

**Adding Vim Plugins
[[Original article by Alex Hunt](https://medium.com/@huntie/10-essential-vim-plugins-for-2018-39957190b7a9)]**

```bash
# Copy and paste .vimrc and plugins.vim
cd git/dotfiles-personal/home/soobinrho
cp .vimrc ~/.vimrc
cp .vim/plugins.vim ~/vim/plugins.vim

# Install the plugins.
vim
:PlugInstall

# Plus, editorconfig wan't working for me,
# but it was fixed with
cp ~/.vim/plugged/editorconfig-vim/.editorconfig ~/

# Install vim-prettier.
# https://github.com/prettier/vim-prettier
npm install prettier -g
mkdir -p ~/.vim/pack/plugins/start
git clone https://github.com/prettier/vim-prettier ~/.vim/pack/plugins/start/vim-prettier

# Install bat-style Vim color scheme.
# https://github.com/jamespwilliams/bat.vim
git clone https://github.com/jamespwilliams/bat.vim.git ~/.vim/pack/plugins/start/bat.vim
```
<br>

## Git

**Install Git Large File Storage
[[Git LFS](https://git-lfs.github.com/)]**

```bash
# Download the binaries from the
# Git LFS website. After that,
git lfs install

# Now, for example, we can tell LFS
# to track .pdf files using LFS:
# git lfs track "*.pdf"
```

<br>

**Signing git commits with a GPG key
[[Original article by Wouter De Schuyter](https://wouterdeschuyter.be/blog/verified-signed-commits-on-github)]**

```bash
# Copy and paste .bashrc
cd git/dotfiles-personal/home/soobinrho
cp .bashrc ~/.bashrc

# First, create a GPG key.
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

**Copying both the public GPG key and private GPG key
to my second laptop via rsync and SSH**

```bash
# The --archive option preserves
# all permissions, modification times, and
# everytihng inside the directory recursively.
rsync --archive /home/soobinrho/.gnupg soobinrho@ip_address:/home/soobinrho
```

<br>

**Creating a key for SSH
[[Original article by Brian Boucheron](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04)]**

```bash
# Create a key with the length of 4096 bits.
ssh-keygen -b 4096

# Copy the public key to the SSH server.
ssh-copy-id root@ip_address
```

<br>

**Copying both the public SSH key and private SSH key
to my second laptop via rsync and SSH**

```bash
# Copy the private SSH key.
rsync --archive ~/.ssh/id_rsa soobinrho@ip_address:~/.ssh/id_rsa

# Copy the public SSH key.
rsync --archive ~/.ssh/id_rsa.pub soobinrho@ip_address:~/.ssh/id_rsa.pub
```

<br>
<br>

# 2. Virtual Private Server Configs

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

**Configuring `sshd_config` on an Ubuntu server
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
sudo service ssh restart
```

<br>
<br>

# 3. SSH Configs for my Laptops

**Using a Fedora machine as a temporary SSH server
[[Original article by Justin Ellingwood](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys)]**

```bash
# Start the SSH server.
sudo service sshd start

# (Optional) Stop sshd. Note that sshd will be
# stopped automatically after rebooting.
# However, we can manually stop it by:
sudo service sshd stop
```

<br>

**Client-side configuration
[[Original StackExchange by laur](https://unix.stackexchange.com/questions/708206/ssh-timeout-does-not-happen-and-not-disconnect)]**

```bash
# Configuring your SSH client
# to never timeout.
cat >> ~/.ssh/config
Host *
  ServerAliveInterval 15
  ServerAliveCountMax 3

# Creating an alias so that we can
# `ssh myserver` instead of `ssh main@ip_address`
# It's nice to be able to ssh without ip_address
cat >> ~/.ssh/config
Host myserver
    HostName ip_address
    User main
```

<br>

**Disableing Updates for Specific Packages
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
<br>
