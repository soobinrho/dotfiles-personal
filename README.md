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
        ├── .gnupg
        │   └── gpg-agent.conf
        ├── .local
        │   └── share
        │       └── konsole
        │           ├── Breeze.colorscheme
        │           └── Profile1.profile
        ├── .p10k.zsh
        └── .zshrc
```

<br>
<br>

## Steps
[1.](#1-how-i-set-up-my-fedora) How I set up my Fedora<br>
[2.](#2-how-i-set-up-my-ubuntu) How I set up my Ubuntu<br>
[3.](#3-workflows-i-find-useful) Workflows I find useful


<br>
<br>

# 1. How I set up my Fedora

```bash
# ---------------------------------------------------------------------
# Install dev tools.
# ---------------------------------------------------------------------
# Install nvm: Node version manager.
# After installing nvm, close and reopen terminal,
# in order for new paths to take effect.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Install Node.js
nvm install node

# Install pnpm: a faster, parallel package manager.
npm install -g pnpm
pnpm setup

# If you're using zsh:
source ~/.zshrc

# If you're using bash:
source ~/.bashrc

# Install TypeScript: a JavaScript superset with types.
# Install tldr: similar to [man], but with simple examples.
# Install loadtest: server load testing tool.
# Install svg-term-cli: asciinema to svg converter.
pnpm add -g typescript ts-node tldr loadtest svg-term-cli

# Update everyday automatically.
sudo dnf install -y dnf-automatic
sudo systemctl enable --now dnf-automatic-install.timer

# Update.
sudo dnf update -y

# Install git.
sudo dnf install -y git

# Install R.
sudo dnf install -y R

# Install PowerShell.
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo rpm -Uvh https://packages.microsoft.com/config/centos/8/packages-microsoft-prod.rpm
sudo dnf update -y
sudo dnf install -y powershell

# Install Alacritty, a fast OpenGL terminal emulator.
# I normally use Konsole because - unlike Alacritty - Konsole
# remembers the last window position. When I need speed, however,
# Alacritty tends to be better smoother and faster because
# it knows how to use both the CPU and the graphics cards.
sudo dnf install -y alacritty

# Install neovim: more extensible fork of vim.
sudo dnf install -y neovim python3-neovim

# Install gh: GitHub CLI.
sudo dnf install -y gh

# Install git-lfs: Git Large File Storage.
sudo dnf install -y git-lfs

# Install wipe: file/folder eraser.
sudo dnf install -y wipe

# Install jpegoptim: jpeg compressor.
sudo dnf install -y jpegoptim

# Install neofetch: system information viewer.
sudo dnf install -y neofetch

# Install htop: process viewer.
sudo dnf install -y htop

# Install ncdu: disk usage viewer.
sudo dnf install -y ncdu

# Install glances: system resources viewer.
sudo dnf install -y glances

# Install bat: colored, cooler version of cat.
sudo dnf install -y bat

# Install asciinema: terminal session recording tool.
sudo dnf install -y asciinema

# Install Pinta and GIMP: image editing tools.
sudo dnf install -y pinta gimp

# Install xournal: pdf annotation tool.
sudo dnf install -y xournal

# Install obs-studio: screencasting/streaming tool.
sudo dnf install -y obs-studio

# Install FFmpeg: multimedia encoding/decoding tool.
sudo dnf install -y ffmpeg

# Install vlc: video player.
sudo dnf install -y vlc

# Install nerd-fonts: fonts with better icons support.
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
nerd-fonts/install.sh
rm -rf nerd-fonts

# Remove nano in order to make vim the default editor.
sudo dnf remove -y nano

# Install irssi: irs client.
sudo dnf install -y irssi

# Add default channel and enable auto log-in.
# Source:
#   https://irssi.org/documentation/manual/automation/
# irssi
# /SERVER MODIFY -auto irc.libera.chat
# /CHANNEL ADD -auto #freebsd-soc liberachat
# /NETWORK ADD -sasl_username yourname -sasl_password yourpassword -sasl_mechanism PLAIN liberachat
# /SET window_default_hidelevel hidden joins parts quits
# /SET autolog on

# Install zsh.
sudo dnf install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh theme: powerlevel10k.
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# ---------------------------------------------------------------------
# Configure git.
# ---------------------------------------------------------------------
git config --global user.name "Soobin Rho"
git config --global user.email "soobinrho@gmail.com"
git config --global core.editor vim
git config --global init.defaultBranch main
git config --global alias.c 'commit -s'

# Get the key's key ID.
# You'll get an output like this:
# sec    rsa4096/BC0596A444D39F64 2022-07-06
# BC0596A444D39F64 is the key ID.
gpg --list-secret-keys --keyid-format LONG

# Copy and paste the key's public key to GitHub's GPG Key section settings.
gpg --armor --export BC0596A444D39F64

# Configure git to sign all commits with the key.
git config --global user.signingkey BC0596A444D39F64
git config --global commit.gpgSign true

# ---------------------------------------------------------------------
# Configure nvim.
# ---------------------------------------------------------------------
# Install Astrovim.
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim

# Open nvim.
nvim

# Install specific LSP servers and language parsers.
# Source:
#   https://astronvim.github.io/
# :LspInstall
# :TSInstall <Name of the language>

# Install debugger.
# Follow instructions at:
#   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

# Install Chrome.
#   https://www.google.com/intl/en_us/chrome/

# Install Java.
#   https://www.oracle.com/java/technologies/downloads/

# Install VS Code.
#   https://code.visualstudio.com/download

# ---------------------------------------------------------------------
# Copy and paste my config files.
# ---------------------------------------------------------------------
git clone https://github.com/soobinrho/dotfiles-personal.git
cd /dotfiles-personal/home/soobinrho

# Alacritty configs.
mkdir -p ~/.config/alacritty
cp ./.config/alacritty/* ~/.config/alacritty/

# Konsole configs.
cp ./.config/konsolerc ~/.config/
cp ./.local/share/konsole/* ~/.local/share/konsole/

# Font configs.
mkdir -p ~/.local/share/font
cp ./.local/share/font/* ~/.local/share/font
fc-cache -f -v
```

<br>

# 2. How I set up my Ubuntu

```bash
# Allow _apt to write to the download folders.
# Source:
#   https://askubuntu.com/questions/908800/what-does-this-apt-error-message-download-is-performed-unsandboxed-as-root
sudo chown -Rv _apt:root /var/cache/apt/archives/partial/
sudo chmod -Rv 700 /var/cache/apt/archives/partial/

# ---------------------------------------------------------------------
# Install development tools.
# ---------------------------------------------------------------------
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl zsh git gh git-lfs wipe bat ffmpeg \
    jpegoptim irssi neofetch htop ncdu glances asciinema xournal vlc \
    pinta gimp obs-studio

sudo apt remove -y nano

# Execute each line one at a time. Do not copy and paste multiple at a time.
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
nerd-fonts/install.sh
rm -rf nerd-fonts

# ---------------------------------------------------------------------
# Install Anaconda.
# ---------------------------------------------------------------------
# Download https://www.anaconda.com/download and then:
~/anaconda3/bin/conda init zsh
conda config --set auto_activate_base false

# ---------------------------------------------------------------------
# Install Node.js
# ---------------------------------------------------------------------
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
nvm install node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install pnpm: a faster, parallel package manager.
npm install -g pnpm
pnpm setup

# If you're using zsh:
source ~/.zshrc

# If you're using bash:
source ~/.bashrc

pnpm add -g typescript ts-node tldr loadtest svg-term-cli

# ---------------------------------------------------------------------
# Configure git.
# ---------------------------------------------------------------------
git config --global user.name "Soobin Rho"
git config --global user.email "soobinrho@gmail.com"
git config --global core.editor vim
git config --global init.defaultBranch main
git config --global alias.c 'commit -s'
git config --global user.signingkey BC0596A444D39F64
git config --global commit.gpgSign true

# ---------------------------------------------------------------------
# Configure nvim.
# ---------------------------------------------------------------------
# Install neovim.
cd /usr/bin
sudo curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod +x nvim.appimage
sudo ln -s /usr/bin/nvim.appimage /usr/bin/nvim

# Install Astrovim.
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim

# Open nvim.
nvim

# Install specific LSP servers and language parsers.
# Source:
#   https://astronvim.github.io/
# :LspInstall
# :TSInstall <Name of the language>

# Install debugger.
# Follow instructions at:
#   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

# Install Chrome.
#   https://www.google.com/intl/en_us/chrome/

# Install Java.
#   https://www.oracle.com/java/technologies/downloads/

# Install VS Code.
#   https://code.visualstudio.com/download

# ---------------------------------------------------------------------
# Copy and paste my config files.
# ---------------------------------------------------------------------
git clone https://github.com/soobinrho/dotfiles-personal.git
cd /dotfiles-personal/home/soobinrho

# Alacritty configs.
mkdir -p ~/.config/alacritty
cp ./.config/alacritty/* ~/.config/alacritty/

# Konsole configs.
cp ./.config/konsolerc ~/.config/
cp ./.local/share/konsole/* ~/.local/share/konsole/

# Font configs.
mkdir -p ~/.local/share/font
cp ./.local/share/font/* ~/.local/share/font
fc-cache -f -v
```

<br>

# 3. Workflows I find useful

```bash
# ---------------------------------------------------------------------
# How to disable updates for specific packages in dnf.
# ---------------------------------------------------------------------
sudo vim /etc/dnf/dnf.conf

# Add the following line. For example, exclude=kernel*
exclude=package-name-version18*

# ---------------------------------------------------------------------
# How to increase number of kernels retained in Fedora.
# ---------------------------------------------------------------------
sudo vim /etc/dnf/dnf.conf

# Change this:
installonly_limit=<number>

# ---------------------------------------------------------------------
# How to enable ~/.bash_history from multiple shells.
# ---------------------------------------------------------------------
echo '# Avoid duplicates
HISTCONTROL=ignoredups:erasedups

# When the shell exits, append to the history file instead of overwritting it.
shopt -s histappend

# After each command, append to the history file and reread it.
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"' >> ~/.bashrc

# ---------------------------------------------------------------------
# How to triple boot in Windows, Ubuntu, and Fedora.
# ---------------------------------------------------------------------
# Install Windows, Ubuntu, and then Fedora.

# How to make a Fedora / Ubuntu installation USB.
lsblk
sudo dd if=Fedora-KDE.iso of=/dev/sdb bs=16M oflag=direct; sync

# How to make a Windows installation USB.
sudo dnf install WoeUSB
sudo woeusb --device Win10.iso /dev/sdb --target-filesystem ntfs

# ---------------------------------------------------------------------
# How to disable GUI in Ubuntu.
# ---------------------------------------------------------------------
# Disable the GUI.
sudo apt remove lightdm

# How to re-enable the GUI.
sudo apt install lightdm
reboot

# ---------------------------------------------------------------------
# How to extract a high quality audio from a video file.
# ---------------------------------------------------------------------
ffmpeg -i sample.avi -q:a 0 -map a sample.mp3

# ---------------------------------------------------------------------
# How to make a screencast gif.
# ---------------------------------------------------------------------
# 1. Screencast with the simplescreenrecorder or obs-studio.

# 2. Go to gifski's GitHub page and then build from source.
#    https://github.com/ImageOptim/gifski

# 3. Convert the screencast video into png files.
ffmpeg -i example.mkv frame%04d.png

# 4. Convert to gif.
~/gifski/target/release/gifski -o example.gif frame*.png --repeat 0 -Q 100 --fps 50 -W 960 -H 516

# If you're just trying to turn a terminal session into a gif, there's
# a simpler way using asciinema and svg-term-cli.
asciinema rec
svg-term --cast=11345 --out example.svg

# ---------------------------------------------------------------------
# How to securely delete files.
# ---------------------------------------------------------------------
wipe -r ./folder

# ---------------------------------------------------------------------
# How to encrypt and decypt files using GPG.
# ---------------------------------------------------------------------
# Encrypt.
gpg -e important_document.pdf

# Decrypt.
gpg important_document.pdf.gpg

# ---------------------------------------------------------------------
# Useful system commands.
# ---------------------------------------------------------------------
# Go to top level of internal documentation.
# Run `info bash` and type `u`

# Reconfigure GRUB.
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# Shutdown.
poweroff

# Suspend.
systemctl suspend

# Execute the last command.
# `ctrl` + `p`

# Find files containing a certain text.
egrep -ir "Certain text"

# Read in hexadecimal
xxd <file name>

# Read in binary
hexdump -b <file name>

# Fedora window management:
# - `Windows` + `LMB` Move a window.
# - `Windows` + `RMB` Resize a window.

# Enable multiple audio outputs.
pactl load-module module-combine-sink

# ---------------------------------------------------------------------
# Useful vim commands.
# ---------------------------------------------------------------------
# - `gc` Comment visual mode.
# - `gcc` Comment out a line.
# - `gcap` Comment out a paragraph.
# - `:7,17Commentary` Comment out with line numbers.
# - `<Select multiple lines with visual mode> :norm! @a` Execute a macro on multiple lines.
# - `m[A-Z]` Set a marker and `'[A-Z]` go to the marker.
# - `q:` Open command-history buffer.
# - `:ene|e` Edit a file in a new buffer, short for `:enew|edit`.

# ---------------------------------------------------------------------
# How to install Cloudflare Tunnel.
# ---------------------------------------------------------------------
# Install Cloudflare Tunnel on the server.
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

# Run `sudo crontab -e` and then add:
# 0 0 * * 1 /home/myusername/cloudflare-ufw/cloudflare-ufw.sh > /dev/null 2>&1

# Confirm all IP rules have been set.
sudo ufw enable
sudo ufw status verbose

# ---------------------------------------------------------------------
# How to install Cloudflared Client for SSH Users.
# ---------------------------------------------------------------------
# Install Cloudflared on the computer, from which you're accessing the
# server.
#   https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/use_cases/ssh/#2-connect-as-a-user

# Add Public hostname: `ssh.example.com` and
# `Service: ssh://localhost:22` at the `Access - Tunnels - Configure`
# setting at:
#   https://one.dash.cloudflare.com/

# Edit ssh config so that ssh command authenticates using Cloudflared.
# Run `vim ~/.ssh/config` and add:
# Host ssh.example.com
# ProxyCommand /usr/bin/cloudflared access ssh --hostname %h
#
# Host devserver
#     HostName ssh.example.com
#     User myusername

# ---------------------------------------------------------------------
# How to stream OBS to yourself using Nginx.
# ---------------------------------------------------------------------
# Source:
#   https://obsproject.com/forum/resources/how-to-set-up-your-own-private-rtmp-server-using-nginx.50

# For gaining practice on my rhetorics,
# I needed a way to listen to my own speech.
# I needed a program that will play what’s recorded into the
# mic with a delay of around five seconds. The best solution for my
# use cases turned out to be OBS and a private rtmp server.

# Download the latest mainline Nginx.
# https://nginx.org

# Download the Nginx RTMP module.
wget https://github.com/sergey-dryabzhinsky/nginx-rtmp-module/archive/dev.zip

tar -zxvf nginx-1.23.3.tar.gz
unzip dev.zip
cd nginx-1.23.3

./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-dev
make
sudo make install

# Add rtmp to the Nginx conf file
# Run `vim /usr/local/nginx/conf/nginx.conf` and add:
# rtmp {
#         server {
#                 listen 1935;
#                 chunk_size 4096;
#
#                 application live {
#                         live on;
#                         record off;
#                         allow publish 127.0.0.1;
#                         deny publish all;
#                         allow play 127.0.0.1;
#                         deny play all;
#                 }
#         }
# }

# Start Nginx.
sudo /usr/local/nginx/sbin/nginx

# OBS Studio Settings:
# Settings - Stream - Server
# rtmp://127.0.0.1:1935/live

# HOW TO PLAY THE STREAM WITH VLC
# 1. Open VLC
# 2. Click "Play", the triangle thingy
# 3. Click "Network"
# 4. Enter rtmp://127.0.0.1:1935/live

# Stop Nginx when you're done
sudo /usr/local/nginx/sbin/nginx -s stop

# ---------------------------------------------------------------------
# Useful `~/.ssh/config` example.
# ---------------------------------------------------------------------
# Host dev
#     HostName <server address>
#     User <username>
#
# Host testing
#     HostName <server address>
#     IdentityFile ~/.ssh/id_rsa_testing
#     User <username>
#
# Host *
#   ServerAliveInterval 600
#   ServerAliveCountMax 3
```

<br>

<details open>
<summary>
  <b>
    Journal on extra random tips
  </b>
</summary>
  
```
###
# June 3, 2022
# Learned about git using `info gittutorial'.
# summary of what i learned today:

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
# June 4, 2022
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
```

</details>

<br>
<br>
<br>
