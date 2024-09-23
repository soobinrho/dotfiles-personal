```bash
# Repository Structure
# You can get this with `tree -a`
  ├── .config
  │   ├── alacritty
  │   │   └── alacritty.toml
  │   ├── konsolerc
  │   └── obs-studio
  │       └── basic
  │           └── profiles
  │               └── rhetorics_practice
  │                   ├── basic.ini
  │                   └── service.json
  │           └── scenes
  │               └── rhetorics_practice.json
  ├── .gnupg
  │   └── gpg-agent.conf
  ├── .local
  │   └── share
  │       └── konsole
  │           ├── Breeze.colorscheme
  │           └── Profile1.profile
  ├── .bashrc
  ├── .tmux.conf
  └── .zshrc
```

<br>
<br>

## Steps
[1.](#1-how-i-set-up-my-fedora) How I set up my Fedora<br>
[2.](#2-how-i-set-up-my-ubuntu) How I set up my Ubuntu<br>
[3.](#3-how-i-set-up-my-vps) How I set up my VPS<br>
[4.](#4-workflows-i-find-useful) Workflows I find useful


<br>
<br>

# 1. How I set up my Fedora

```bash
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

# Install neovim: more extensible fork of vim.
sudo dnf install -y neovim python3-neovim

# Install gh: GitHub CLI.
sudo dnf install -y gh
gh auth login
gh auth setup-git

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

# Install nerd-fonts: fonts with better icons support.
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
nerd-fonts/install.sh
rm -rf nerd-fonts
```

<br>

# 2. How I set up my Ubuntu

I personally use https://kubuntu.org/ because I like its style better than Gnome.

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
sudo apt install -y curl tree git git-lfs wipe ffmpeg \
    jpegoptim irssi neofetch htop ncdu glances asciinema \
    xournal vlc gimp obs-studio bat powerstat

sudo apt remove -y nano

sudo snap install pinta tldr
tldr -u

# Install gh: GitHub CLI.
sudo apt remove -y ksshaskpass
sudo apt install -y gh
gh auth login
gh auth setup-git

# Install nerd-fonts: fonts with better icons support.
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
nerd-fonts/install.sh
rm -rf nerd-fonts
```

<br>

# 3. How I set up my VPS

## Infrastructure

| ***Program*** | ***Purpose*** |
| ---- | ---- |
| ***Hetzner*** | I use this for hosting my servers. Main applications server = 3 vCPU, 4GB RAM, 80GB disk. Security logging and monitoring server = 2 vCPU, 4GB RAM, 40GB disk. |
| ***rsyslog*** | "Rocket-fast System for Log Processing." I use this for collecting all my logs in my centralized logging server. |
| ***Tarsnap*** | One of the most, if not the most, secure backup service. I use this for regular backups of my servers. |

> [!NOTE]  
> syslog is a plaintext logging system, [1] while journald is a binary
> logging system. journald was created more recently, but I chose to
> use syslog-ng because syslog is said to be better at remote logging
> at central logging & monitoring server than journald.
> [1] https://datatracker.ietf.org/doc/html/rfc5424

## Applications

| ***Program*** | ***Purpose*** |
| ------------- | ------------- |
| nsustain.com | Help the e[N]vironment and [sustain]ability by coding for anyone who works in the field. Open to any programmer who wants to contribute to environmental sustainability. |
| BeeMovr.nsustain.com | Help beekeepers by coding whatever they need for their bees. |
| GoodLifeFarms.nsustain.com | Help local producers (farmers, beekeeprs, florists, and so on) by giving them a free, low-maintenance platform to sell their goods to local consumers. Deisnged to be as self-sustainable as possible: the UI is Google Sheets and Google Forms instead of fancy, expensive databases. |

```bash
# ---------------------------------------------------------------------
# 1. Create a VPS at Hetzner and setup an SSH access:
#      https://docs.digitalocean.com/products/droplets/how-to/add-ssh-keys/to-existing-droplet/
# ---------------------------------------------------------------------

# How to configure sshd after booting up a fresh VPS.
# ===================================================
# Source:
#   https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys
adduser soobinrho sudo

# Change the hostname if desired.
hostnamectl set-hostname newHostName

# Copy the authorized ssh pub key from root to new user.
mkdir /home/soobinrho/.ssh
cp ~/.ssh/authorized_keys /home/soobinrho/.ssh/
chown -R soobinrho:soobinrho /home/soobinrho/.ssh

# Login to the new user.
su - soobinrho

# Test ssh connection to the new user.
# Then, open the sshd config file for more secure settings.
sudo vim /etc/ssh/sshd_config

# Add these two lines at the end of the config file:
PasswordAuthentication no
PermitRootLogin no

# Restart SSH
sudo service sshd restart    # Fedora
sudo service ssh restart    # Ubuntu

# How I set up my client-side SSH configs.
# ========================================
# Source:
#   https://unix.stackexchange.com/questions/708206/ssh-timeout-does-not-happen-and-not-disconnect

# How to configure the SSH client to time-out less frequently.
cat >> ~/.ssh/config
Host *
  ServerAliveInterval 15
  ServerAliveCountMax 3

# How to create an alias so that we can `ssh myserver` instead of
# `ssh main@ip_address` everytime.
cat >> ~/.ssh/config
Host myserver
    HostName ip_address
    User main

# How to setup public / private key access for private GitHub repo.
# =================================================================
# Source:
#   https://leangaurav.medium.com/setup-ssh-key-with-git-github-clone-private-repo-using-ssh-d983ab7bb956
ssh-keygen -t ed25519 -C "name@example.com"

# Copy and paste the public key to github.com repo - Code - SSH .
vim ~/.ssh/id_ed25519.pub

# How to check the https header on command line.
curl --insecure -vvI https://nsustain.com 2>&1

# -------------------------------------------------------------------
# 2. On Hetzner firewall settings, Allow any inbound IPv4 or IPv6 for
#    port 80 and 443, but only allow your whitelisted IP address for
#    incoming port 22 traffic.
# -------------------------------------------------------------------
# How to get your public IP address.
curl https://ipinfo.io/ip

# -------------------------------------------------------------------
# 3. Configure rsyslog server and clients.
# -------------------------------------------------------------------
# Configure the logging and monitoring server.
# ============================================
sudo systemctl start rsyslog
sudo systemctl enable rsyslog

# Configure the client's Docker settings.
# =======================================
# Change the Docker's default logging driver from json to syslog.
sudo vim /etc/docker/daemon.json

# Copy and paste | Start
{
  "log-driver": "syslog",
  "log-opts": {
    "syslog-address": "unixgram:///dev/log",
    "tag" : "docker/{{.Name}}"
  }
}
# Copy and paste | End

# Restart docker.
cd ~/deploy-nsustain.com
docker compose down
sudo service docker restart
docker compose up -d

# Confirm Docker's logging driver is correctly configured to syslog.
docker inspect <containerName> | grep -A 5 LogConfig

# How to check if rsyslog server is listening.
echo "This is a test log message." | nc <server_ip> <port>

# Configure logrotate so that logs don't take too much space.
# ===========================================================
sudo vim /etc/logrotate.d/docker

# Copy and paste | Start
/var/log/docker/*.log {
    daily
    rotate 7
    copytruncate
    compress
    delaycompress
    notifempty
    missingok
}
# Copy and paste | End

# Configure the client's rsyslog configs.
# =======================================
# Source:
#   https://chabik.com/rsyslog-and-docker/
sudo mkdir /var/log/docker
sudo chmod -R 0755 /var/log/docker
sudo chown -R syslog:adm /var/log/docker
sudo vim /etc/rsyslog.conf

# Copy and paste | Start
template(name="DockerLogFileName" type="list") {
   constant(value="/var/log/docker/")
   property(name="syslogtag" securepath="replace" regex.expression="docker/\\(.*\\)\\[" regex.submatch="1")
   constant(value=".log")
}

if $programname == "docker" then {
  if $syslogtag contains "docker/" then {
    ?DockerLogFileName
  } else {
    action(type="omfile" file="/var/log/docker/no_tag.log")
  }
  stop
}
# Copy and paste | End

# After restarting, the logs will go to /var/log/docker_all.log
# By the way, `sudo service rsyslog restart` works perfectly fine as
# well. `service` = more high level abstraction than `systemctl`.
sudo systemctl restart rsyslog


# TODO: Use TCP protocol for logging in the central log server, and
# enable SSL/TLS encryption through stunnel.
# Source:
#   https://github.com/jmaas/rsyslog-configs
#   https://www.rsyslog.com/doc/historical/stunnel.html
#   https://www.linuxhowtos.org/Security/stunnel.htm

# ---------------------------------------------------------------------
# 4. Run Docker Compose.
# ---------------------------------------------------------------------
git clone https://github.com/soobinrho/deploy-nsustain.com.git
cd deploy-nsustain.com
docker compose build
docker compose up -d

# ---------------------------------------------------------------------
# 5. Useful workflows.
# ---------------------------------------------------------------------
# How to see which process is listening on port 80.
sudo netstat -pna | grep 80

# Install lnav: the logfile navigator.
sudo snap install -y lnav

# How to view /etc/var/syslog in pretty format.
sudo lnav

```

<br>

# 4. Workflows I find useful

```bash
# ---------------------------------------------------------------------
# tmux workflows
# Source:
#   https://www.redhat.com/sysadmin/introduction-tmux-linux
# ---------------------------------------------------------------------
# Install tmux: the best terminal multiplexer.
sudo dnf install -y tmux  # Fedora
sudo apt install -y tmux  # Ubuntu

# Apply my tmux configs.
git clone https://github.com/soobinrho/dotfiles-personal.git
cd /dotfiles-personal/home/soobinrho
cp ./.tmux.conf ~/

# Install the plugin manager.
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Reload tmux configs that includes tmux plugins installation list.
tmux source ~/.tmux.conf

# Press Ctrl+a I to install the plugins.
# If tmux-mem-cpu-load installation exits with a cmake error,
# then install cmake with
sudo dnf install -y cmake  # Fedora
sudo apt install -y cmake  # Ubuntu

# How to see all sessions.
tmux ls

# How to attach to existing session.
tmux attach

# How to create a new session.
tmux new-session

# My favorite keybindings
# =======================
# Ctrl+a d = Detach from current session.
# Ctrl+a w = See all sessions, windows, and panes. Here, you can press x to kill.
# Ctrl+a Ctrl+s = Save session. This is from the tmux-resurrect plugin.
# Ctrl+a Ctrl+r = Restore session. This is from the tmux-resurrect plugin.
# =======================
# Ctrl+a Alt+<3|4|5> = Useful preset pane arrangements. 
# Ctrl+a % = Split the window into two panes horizontally.
# Ctrl+a " = Split the window into two panes vertically.
# Ctrl+a <left|right|up|down> = Move between panes.
# Ctrl+a Ctrl+<left|right|up|down> = Resize pane.
# Ctrl+a x = Close pane.
# =======================
# Ctrl+a c = Create a new window.
# Ctrl+a <0|1|2|3|4|5|6|7|8|9> = Move to window using index.
# Ctrl+a n = Move to the next window.
# Ctrl+a p = Move to the previous window.

# ---------------------------------------------------------------------
# How to install zsh and powerlevel10k theme.
# ---------------------------------------------------------------------
sudo dnf install -y zsh  # Fedora
sudo apt install -y zsh  # Ubuntu
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh-syntax-highlighting plugin.
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Apply my zsh configs.
git clone https://github.com/soobinrho/dotfiles-personal.git
cd /dotfiles-personal/home/soobinrho
cp ./.zshrc ~/

# Install zsh theme: powerlevel10k.
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
p10k configure

# If on Windows, install Oh My Posh for Powershell:
#   https://ohmyposh.dev/

# Create the profile file:
#   New-Item -Path $PROFILE -Type File -Force

# On Windows Oh My Posh, I personally like this config for `$PROFILE`:
#   oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/powerlevel10k_rainbow.omp.json" | Invoke-Expression

# Also, set opacity as 93% on Windows terminals settings, and set the
# font as MesloLGM Nerd Font, which you can download with:
#   oh-my-posh font install meslo

# ---------------------------------------------------------------------
# How to install Alacritty.
# ---------------------------------------------------------------------
# Alacritty is a fast OpenGL terminal emulator.
sudo dnf install -y alacritty  # Fedora
sudo snap install alacritty --classic  # Ubuntu

# Apply my Alacritty configs.
git clone https://github.com/soobinrho/dotfiles-personal.git
cd /dotfiles-personal/home/soobinrho
mkdir -p ~/.config/alacritty
cp ./.config/alacritty/* ~/.config/alacritty/

# ---------------------------------------------------------------------
# How to install nvim and Astrovim.
# ---------------------------------------------------------------------
# Install Astrovim.
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim

# Install specific LSP servers and language parsers.
# Source:
#   https://astronvim.github.io/
# :LspInstall
# :TSInstall <Name of the language>

# Default key shortcuts:
#   https://docs.astronvim.com/mappings

# My favorite key shortcuts:
# ==========================
# \ = Horizontal split
# | = Vertical split
# Ctrl{h|j|k|l} = Window navigation
# :q = Close window
# ---------------------------------------------------------------------
# Space + e = Neotree toggle
# Space + o = Neotree focus
# ---------------------------------------------------------------------
# :bnew = New buffer
# [b = Previous buffer
# ]b = Next buffer
# :bd = Close buffer

# Useful vim commands.
# ====================
# gc = Comment visual mode.
# gcc = Comment out a line.
# gcap = Comment out a paragraph.
# :7,17Commentary = Comment out with line numbers.
# ---------------------------------------------------------------------
# m[A-Z] = Set a marker and `'[A-Z]` go to the marker.
# <Select multiple lines with visual mode> :norm! @a = Execute a macro on multiple lines.
# q: = Open command-history buffer.
# :ene|e = Edit a file in a new buffer, short for `:enew|edit`.

# ---------------------------------------------------------------------
# How to install Node.js
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

# Install TypeScript: a JavaScript superset with types.
# Install tldr: similar to [man], but with simple examples.
# Install loadtest: server load testing tool.
# Install svg-term-cli: asciinema to svg converter.
pnpm add -g typescript ts-node svg-term-cli

# ---------------------------------------------------------------------
# Copy and paste my config files.
# ---------------------------------------------------------------------
git clone https://github.com/soobinrho/dotfiles-personal.git
cd /dotfiles-personal/home/soobinrho

# Konsole configs.
cp ./.config/konsolerc ~/.config/
cp ./.local/share/konsole/* ~/.local/share/konsole/

# GPG agent configs.
cp ./.gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf

# Go to Shortcuts settings and unbind Konsole's Ctrl + Alt + t shortcut.
# Bind alacritty to Ctrl + Alt + t.

# ---------------------------------------------------------------------
# (For laptops only) Laptop battery healthcare.
# ---------------------------------------------------------------------
# Install tlp: power management and battery care.
sudo dnf install -y tlp tlp-rdw  # Fedora only
sudo dnf remove power-profiles-daemon  # Fedora only
systemctl enable tlp.service  # Fedora only
systemctl mask systemd-rfkill.service systemd-rfkill.socket  # Fedora only

sudo add-apt-repository ppa:linrunner/tlp  # Ubuntu only
sudo apt update -y  # Ubuntu only
sudo apt install -y tlp tlp-rdw  # Ubuntu only

# "If the laptop is plugged most of the time and rarely unplugged,
# maximizing battery lifetime at the cost of a greatly reduced runtime
# may be acceptable, with values like starting charge at 40% and
# stopping at 50%.
#
# On the contrary, if you use it unplugged most of the time, starting
# charge at 85% and stopping at 90% would allow for a much longer
# runtime and still give a lifespan benefit over the factory settings.
# Default TLP settings (only if you uncomment the relevant lines) are
# slightly more protective regarding lifespan, with 75/80% charge
# thresholds."
# Source:
#   https://linrunner.de/tlp/faq/battery.html#how-to-choose-good-battery-charge-thresholds

# Note: I don't use my laptop a lot, so 70%/80% threshold.
# Reminder to change it to 40%/50% once I graduate.

# Uncomment START_CHARGE_THRESH_BAT0 and others.
sudo vim /etc/tlp.conf

sudo tlp start

# See running status of tlp.
sudo tlp-stat -s

# See power statistics.
tlp-stat --psup

# Install powerstat: Power consumption measurement.
sudo dnf install -y powerstat  # Fedora

# ---------------------------------------------------------------------
# How to install Anaconda and disable automatic activation.
# ---------------------------------------------------------------------
# Download https://www.anaconda.com/download and then:
~/anaconda3/bin/conda init zsh
conda config --set auto_activate_base false

# ---------------------------------------------------------------------
# How to create a new SSH key.
# Source:
#   https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04
# ---------------------------------------------------------------------
# Create a key with the length of 4096 bits
ssh-keygen -b 4096

# Copy the public key to the SSH server
ssh-copy-id root@ip_address

# ---------------------------------------------------------------------
# How to configure git.
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
# How to see all git configs.
# ---------------------------------------------------------------------
# See global configs.
git config --global --edit

# See local configs.
git config --edit

# ---------------------------------------------------------------------
# How to delete untracked files and folders in git.
# ---------------------------------------------------------------------
git clean -fd

# ---------------------------------------------------------------------
# How to rebase in git, including squashing.
# ---------------------------------------------------------------------
git rebase -i HEAD~15

# ---------------------------------------------------------------------
# How to reset commit history in a git repository.
# Source:
#   https://stackoverflow.com/a/26000395
# ---------------------------------------------------------------------
git checkout --orphan latest_branch
git add -A
git commit -am"refactor: reset all commit history for security"
git branch -D main  # Delete the original branch.
git branch -m main  # Rename the orphan branchto main.
git push -f origin main

# ---------------------------------------------------------------------
# DANGER: Secure devices only.
# How to copy both the public and private GPG keys to secondary laptop.
# ---------------------------------------------------------------------
# Note that I'm copying my private key as well
# because both the SSH server and client are my personal laptops.
# Never transfer your private keys, unless you absolutely need to.
rsync --archive ~/.gnupg $(whoami)@ip_address:~

# The --archive option preserves
# all permissions, modification times, and
# everytihng inside the directory recursively

# ---------------------------------------------------------------------
# DANGER: Secure devices only.
# How to copy both the public and private SSH keys to secondary laptop.
# ---------------------------------------------------------------------
# This also copies `authorized_keys`, `config`, and `known_hosts`.
# Again, never transfer your private keys, unless you absolutely need to.
rsync --archive ~/.ssh $(whoami)@ip_address:~
rsync --archive ~/.gitconfig $(whoami)@ip_address:~/.gitconfig

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

# Quick mode (overwrite only 4 times).
wipe -rq ./folder

# ---------------------------------------------------------------------
# How to encrypt and decypt files using GPG.
# ---------------------------------------------------------------------
# Encrypt.
gpg -e important_document.pdf

# Decrypt.
gpg important_document.pdf.gpg

# Encrypt all files recursively.
find . -type f -not -name "*.gpg" -not -path '*/.*' | xargs gpg -v --batch --yes --recipient soobinrho@gmail.com --encrypt-files

# Decrypt all files recursively.
find . -type f -name "*.gpg" | xargs gpg -v --batch --decrypt-files

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
# Source:
#   https://obsproject.com/forum/resources/how-to-set-up-your-own-private-rtmp-server-using-nginx.50
# ---------------------------------------------------------------------

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

# ---------------------------------------------------------------------
# Journal entries on extra random tips.
# ---------------------------------------------------------------------
# June 3, 2022
# ============
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

# June 4, 2022
# ============
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

# June 21, 2022
# =============
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

# June 21, 2022
# =============
# For the README.MD for my "Latex Template for College Assignments"
# I had to add an example image. After x, y, and z, I decided
# that I needed to add a light grey (HTML Color Code F6F8FA)
# border around the picture so that it doesn't just blend in too much
# with a white background -- e.g. GitHub on desktop.
# I used Gimp. 'Filter' 'Decor' 'Border' size 4, D value 1
#
# Plus, you can see the HTML color code on any website on Chrome
# on Chrome Developer's mode by typing Ctrl + Shift + c

# June 22, 2022
# =============
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

# July 24, 2022
# =============
# ctrl + shift + u and then type unicode and then space
# 2192 = right arrow →

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

# Codes should describe what they do themselves.
# Comments, in the other hand, should describe
# why those codes are there.
```

![Calc II Tips](https://user-images.githubusercontent.com/19341857/184079510-d7899b35-e114-4f50-a8a8-ab0c3a1384d5.png)
***A random tip for Calc II.***

<br>
<br>
<br>
