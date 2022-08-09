<p align="center">
  <img src="https://user-images.githubusercontent.com/19341857/181281095-b56a803b-9530-4cd3-bc57-27bb0239d823.png" width="600">
</p>

***How exactly do you use this repository?***
Whenever I reset my devices
for whatever reason, I go through
each step below.
These include the dotfiles and
configuration files I use.
For example, `.purelines.conf`
and `.bashrc` can give you the same
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
│       ├── .editorconfig
│       ├── global_extra_conf.py
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

## Steps
[1.](#1-dev-tools-configs) Dotfiles and Dev Toolss<br>
&#160;&#160;&#160;&#160;[A.](#dotfiles) Installation<br>
&#160;&#160;&#160;&#160;[B.](#bash) Bash Configs<br>
&#160;&#160;&#160;&#160;[C.](#vim) Vim Configs<br>
&#160;&#160;&#160;&#160;[D.](#git) Git Configs<br>
[2.](#2-optional-ssh-configs) (Optional) SSH Server Configs<br>
[3.](#3-optional-virtual-private-server-configs) (Optional) Virtual Private Server Configs<br>


<br>
<br>

# 1. Dotfiles and Dev Tools

## Dotfiles

I use Dotbot
[**[GitHub](https://github.com/anishathalye/dotbot)**]
to manage my dotfiles.
Here's what I use whenever
I reset my computers in order to
reinstall my dotfiles in this repository:

```bash
# Install git.
sudo dnf install -y git

# Install dotbot.
pip install dotbot

# Install the dotfiles.
mkdir ~/git
cd ~/git
git clone https://github.com/soobinrho/dotfiles-personal.git
cd dotfiles-personal
dotbot -c ./install.conf.yaml
```

dotbot works by creating symlinks
to the dotfiles located in this repository.
We therefore do not have to make
changes twice both in `~/` directory
dotfiles and in `dotfiles-personal` directory.
Instead, we can just make all changes
in this repository directory and just
rerun dotbot with

```bash
# Reinstall the dotfiles if you made any change.
`dotbot -c ./install.conf.yaml`.
```

Now, all dotfiles have been installed.
In addition, here's how the rest of my setup
goes, installing all the software I use:

```bash
# Install programming environments.
sudo dnf install -y neovim python3-neovim npm steghide gh

# Install Chrome.
# https://www.google.com/intl/en_us/chrome/

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

# Install fzf.
# cat **<Tab>
# https://github.com/junegunn/fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install z.lua
# https://github.com/skywind3000/z.lua.git
git clone https://github.com/skywind3000/z.lua.git ~/.local/z.lua/

# Install glow.
# glow -p README.md
# https://github.com/charmbracelet/glow
echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=0' | sudo tee /etc/yum.repos.d/charm.repo
sudo yum install -y glow
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
# Install vim-plug.
# https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install YouCompleteMe.
sudo dnf install -y cmake gcc-c++ make python3-devel golang
cd ~/.vim/plugged
git clone https://github.com/ycm-core/YouCompleteMe.git
cd YouCompleteMe
python3 install.py --all

# Install vim-prettier.
# https://github.com/prettier/vim-prettier
npm install prettier -g
mkdir -p ~/.vim/pack/plugins/start
git clone https://github.com/prettier/vim-prettier ~/.vim/pack/plugins/start/vim-prettier

# Install the plugins.
vim
:PlugInstall
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

[2.](#2-optional-ssh-configs) (Optional) SSH Server Configs<br>
[3.](#3-optional-virtual-private-server-configs) (Optional) Virtual Private Server Configs<br>

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

# 3. Virtual Private Server Configs

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



<br>
<br>
<br>
