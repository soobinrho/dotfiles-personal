<br>

```bash
# Repository Structure
# You can get this with `tree -a`
  ├── .config
  │   ├── alacritty
  │   │   └── alacritty.toml
  │   ├── konsolerc
  │   ├── obs-studio
  │   │   └── basic
  │   │       ├── profiles
  │   │       │   └── rhetorics_practice
  │   │       │       ├── basic.ini
  │   │       │       └── service.json
  │   │       └── scenes
  │   │           └── rhetorics_practice.json
  │   └── xfce4
  │       └── xfconf
  │           └── xfce-perchannel-xml
  │               └── xfce4-panel.xml
  ├── .gnupg
  │   └── gpg-agent.conf
  ├── .local
  │   └── share
  │       └── konsole
  │           ├── Breeze.colorscheme
  │           └── Profile1.profile
  └── .tmux.conf
```

<br>
<br>

## Profile Dotfiles

I use distro specific dotfiles as a baseline and add applicable sections as I go.
No need to copy and paste entirety of what's below.
Instead, only use what's useful for your use cases.

```bash
# .zshrc

# "This option is a variant of INC_APPEND_HISTORY in which, where
# possible, the history entry is written out to the file after the
# command is finished."
# Source: https://zsh.sourceforge.io/Doc/Release/Options.html

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000000
HISTFILESIZE=10000000

# Gather history from multiple temrinals.
# Source: https://askubuntu.com/a/80380
export PROMPT_COMMAND='history -a'

export PATH="$PATH:/opt/nvim/"

# Preferred editor for local and remote sessions.
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

export MY_IP=$(ip -4 addr show tun0 2> /dev/null | grep -oP '(?<=inet\s)([0-9.]+){3}')
export MY_IP_eth0=$(ip -4 addr show eth0 2> /dev/null | grep -oP '(?<=inet\s)([0-9.]+){3}')
export MY_IP_wlan0=$(ip -4 addr show wlan0 2> /dev/null | grep -oP '(?<=inet\s)([0-9.]+){3}')

alias vim='~/.local/bin/lvim'
alias svim='sudo /opt/nvim/nvim'
alias ncdu='ncdu --color dark-bg --show-percent --show-itemcount --group-directories-first'
```

<br>

```bash
# .bashrc

# Run zsh by default.
if test -t 1; then
    exec zsh
fi

HISTSIZE=10000000
HISTFILESIZE=10000000
export PROMPT_COMMAND='history -a'
```

<br>

## Fedora Setup

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

# Install gh: GitHub CLI.
sudo dnf install -y gh
gh auth login
gh auth setup-git

# Install git-lfs: Git Large File Storage.
sudo dnf install -y git-lfs

# Install wipe: file/folder eraser.
# Btw, on Windows, Sdelete is recommended.
# Source:
#   https://uit.stanford.edu/security/data-sanitization
sudo dnf install -y wipe

# Install jpegoptim: jpeg compressor.
sudo dnf install -y jpegoptim

# Install fastfetch: system information viewer.
sudo dnf install -y fastfetch

# Install htop: process viewer.
sudo dnf install -y htop

# Install ncdu: disk usage viewer.
wget https://dev.yorhel.nl/download/ncdu-2.9.1-linux-x86_64.tar.gz
tar xvf ./ncdu-2.9.1-linux-x86_64.tar.gz
sudo chmod 755 ./ncdu
mv ./ncdu ~/.local/bin/

# Install variety: Wallpaper rotator using Bing Images of the Day.
sudo dnf install -y variety

# Install glances: system resources viewer.
sudo dnf install -y glances

# Install bat: colored, cooler version of cat.
sudo dnf install -y bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

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

# Add default channel and enable auto log-in in irssi.
# Source:
#   https://irssi.org/documentation/manual/automation/
# irssi
# /SERVER MODIFY -auto irc.libera.chat
# /CHANNEL ADD -auto #freebsd-soc liberachat
# /NETWORK ADD -sasl_username yourname -sasl_password yourpassword -sasl_mechanism PLAIN liberachat
# /SET window_default_hidelevel hidden joins parts quits
# /SET autolog on
```

<br>

## Ubuntu Setup

```bash
# ---------------------------------------------------------------------
# Enable auto updates so that security patches are installed promptly.
# ---------------------------------------------------------------------
sudo apt install -y unattended-upgrades
sudo dpkg-reconfigure -plow unattended-upgrades

# ---------------------------------------------------------------------
# Install development tools.
# ---------------------------------------------------------------------
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y curl tree git git-lfs wipe ffmpeg \
    jpegoptim irssi fastfetch htop ncdu glances asciinema \
    xournal vlc gimp obs-studio powerstat variety

sudo snap install pinta tldr
tldr -u

# Install ncdu: disk usage viewer.
wget https://dev.yorhel.nl/download/ncdu-2.9.1-linux-x86_64.tar.gz
tar xvf ./ncdu-2.9.1-linux-x86_64.tar.gz
sudo chmod 755 ./ncdu
mv ./ncdu ~/.local/bin/

# Since I only use vim, uninstall nano.
sudo apt remove -y nano

# Install bat: colored, cooler version of cat.
sudo apt install -y bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Install gh from https://cli.github.com/

# Install nerd-fonts: fonts with better icons support.
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
nerd-fonts/install.sh
rm -rf nerd-fonts
```

<br>

## Kali Linux Setup

### Error: "There was a problem reading data"

When installing, I encountered the error "There was a problem reading data."
The fix was to mount the installtion USB's partition manually with shell from Ctrl + Alt + 3.
After running the following, return to the installation interface with Ctrl + Alt + 5.

```bash
# Source: https://unix.stackexchange.com/a/473883
ls /dev
mount /dev/sdb1 /cdrom
```

<br>

### Error: No desktop manager after installation with disk encryption

This error was caused after I installed Kali on my desktop.
The desktop manager xfce wouldn't load at all and instead get stuck in an infinite underscore blinking.
Fix was to Ctrl + alt + F1 and then:

```bash
sudo apt update; sudo apt upgrade -y && reboot
```

<br>

### Nvidia Driver

At least at the time of this writing, `linux-image-6.16.8` was not compatible with the Nvidia driver.
So, I downgraded to a previous version of kernel to make it work.

```bash
uname -r
sudo apt-mark hold 6.12.38  # sudo apt-mark unhold 6.12.38 in the future if needed.
sudo apt update
sudo apt full-upgrade -y
dpkg -l | grep linux-image
sudo apt purge linux-image-6.16.8+kali-amd64
reboot

# Download: https://kali.download/kali/pool/main/l/linux/
sudo apt install ./linux-kbuild-6.12.38+kali_6.12.38-1kali1_amd64.deb
sudo apt install ./linux-headers-6.12.38+kali-common_6.12.38-1kali1_all.deb
sudo apt install ./linux-headers-6.12.38+kali-amd64_6.12.38-1kali1_amd64.deb

# Download: https://in.download.nvidia.com/XFree86/Linux-x86_64/570.153.02/NVIDIA-Linux-x86_64-570.153.02.run
chmod +x ./NVIDIA-Linux-x86_64-570.153.02.run
sudo ./NVIDIA-Linux-x86_64-570.153.02.run
reboot
sudo apt install pkg-config
sudo nvidia-settings
hashcat -I
watch -d -n 0.5 nvidia-smi
```

<br>

```bash
# How to reduce grub timeout from 5 seconds to 1 second.
sudo sed -i -e 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub
sudo update-grub

# How to restore my taskbar setup.
cp ./home/soobinrho/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
reboot

# How to open up system information on startup.
sudo apt install -y konsole
crontab -e
crontab > @reboot DISPLAY=:0.0 konsole -p 'Font=RobotoMono Nerd Font Mono,17' -e 'watch -d -n 0.5 nvidia-smi'

# How to check network connectivity status.
sudo nmcli general status
sudo nmcli radio all
sudo nmcli connection
sudo netstat --route --numeric

# How to move over files from a USB.
mkdir ~/usb
sudo mount /dev/sda3 ~/usb
rsync --progress -ua ~/usb/2025-10-16 ~/
sudo umount ~/usb

# How to control the Xorg server.
sudo service lightdm stop
sudo service lightdm start

# How to connect to a Wifi.
sudo nmcli device wifi list
sudo nmcli device wifi connect <SSID> --ask

# How to use `man`.
man --all intro  # Show intro manual pages. --all flag shows all manuals instead of just one.
man --apropos disk  # Search manuals that contain a keyword.
man --whatis nmcli  # Lookup what a program is.

# Useful utilities.
open .  # Open current directory with user's preferred program.
locate /rules  # Find folders called rules.
updatedb  # Manually the index for `locate`. Daily run by default.

# How to turn off the mic mute keyboard backlight.
sudo su -
echo 0 > /sys/class/leds/platform::micmute/brightness

# The network manager icon is white, so we have to switch to dark mode.
# Right click taskbar > Panel > Panel preferences... > Appearance > Dark Mode.

# Display my ip addresses widget on the taskbar.
# Right click taskbar > Panel > Add New Items... > Generic Monitor.
# Use three widgets with no label and a period of 90 seconds.
# 1. `/home/kali/widget_ip eth0`
# 2. `/home/kali/widget_ip tun0`
# 3. `echo target0=127.16.1.3`
# 4. `echo target1=127.16.1.10`
# 5. `echo target2=127.16.1.35`
cp dotfiles-personal/home/soobinrho/widget_ip ~/

# Appearance setup.
# Windows button > Appearance
# ./Settings > Window Scaling 2x
# ./Fonts > Default Font 14px
# ./Fonts > Default Monospace Font 14px
# ./Style > Kali-Dark
# ./Icons > Flat-Remix-Green-Dark
```

<br>

## Windows Setup

1. Enable disk-level encryption using Bitlocker.
2. Install Nvidia driver.
3. Install Chrome.
4. Run Windows Updates to install every available update.
5. Install Motu M2 driver.
6. Install VS Code. Install Black Formatter extension for Python formatting. Turn on format on save.
7. Install WSL. `Turn Windows features on or off` and then enable `Windows Hypervisor Platform` and `Windows Subsystem for Linux`.
8. Install Windows Sandbox from `Turn Windows features on or off`. It's useful for investigations.
9. Windows Terminal - Settings - Appearance - Background opacity 95%.

### Useful PowerShell Commands

```powershell
# `grep` equivalent in PowerShell
Select-String -Path ./**/* -Pattern 'PATH_CSRA' -ErrorAction SilentlyContinue
```

<br>

## My Other Useful Workflows

```bash
# ---------------------------------------------------------------------
# How to use dotfiles in this repo.
# ---------------------------------------------------------------------
# Konsole dotfiles.
cp ./.config/konsolerc ~/.config/
cp ./.local/share/konsole/* ~/.local/share/konsole/

# GPG agent configs.
cp ./.gnupg/gpg-agent.conf ~/.gnupg/gpg-agent.conf

# ---------------------------------------------------------------------
# MSI Motherboard Fan Settings
# ---------------------------------------------------------------------
# I noticed that my fan settings were all over the place and were
# making fans work too much unnecessarily even at perfectly low temp.
# These settings make my computer virtually silent at low load and
# yet powerful when the load requires it.
# 1. CPU: Auto - Smart Fan Mode.
# 2. System (All case fans): PWM - Smart Fan Mode.

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

# Go to Shortcuts settings and unbind Konsole's Ctrl + Alt + t shortcut.
# Bind alacritty to Ctrl + Alt + t.

# ---------------------------------------------------------------------
# vt-cli (VirusTotal CLI) workflows.
# ---------------------------------------------------------------------
# Install vt-cli from:
#   https://github.com/VirusTotal/vt-cli/releases
wget https://github.com/VirusTotal/vt-cli/releases/download/1.0.1/Linux64.zip
unzip Linux64.zip
sudo mv vt /usr/local/bin/

# Get an API key from:
#   https://www.virustotal.com/
vt init

# How to get a SHA256.
shasum -a 256 fileName > fileName.sha

# How to see if a file is in the VirusTotal database using SHA256.
vt file <file_SHA256_hash>

# How to get information about a website.
vt url https://example.com

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
# How I set up my client-side SSH configs.
# Source:
#   https://unix.stackexchange.com/questions/708206/ssh-timeout-does-not-happen-and-not-disconnect
# ---------------------------------------------------------------------
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
# How to compress a pdf file to reduce size.
# ---------------------------------------------------------------------
sudo apt install ghostscript
gs -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -q -o compressed.pdf original.pdf

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
hist  # View ~/.zsh_history, ~/.bash_history, etc.
!<history line number>  # Get that command from history.
!<string>  # Get the most recent command that starts with this string.

# How to use `cut` to filter data.
who | cut -c 1-8  # outputs the first eight characters.
who | cut -d' ' -f1,2  # sets the delimiter as ` ` and outputs the first and second columns.

# How to sort in reverse.
who | cut -d' ' -f2 | sort -r

# How to get unique data.
who | cut -d' ' -f1 | uniq

# How to reconfigure GRUB.
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# How to shutdown.
poweroff

# How to suspend.
systemctl suspend

# How to find files containing a certain text.
grep -R "Certain text" .

# How to read in hexadecimal.
xxd <file name>

# How to read in binary.
hexdump -b <file name>
```

<br>

### Zsh Framework

```bash
# Install zsh4humans: A preconfigured framework for Zsh.
# It aims to have everything ready to be used out of the box.
if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi
```

<br>

### Version Management

```bash
sudo apt install gh
gh auth login

git config --global user.name "Soobin Rho"
git config --global user.email "soobinrho@gmail.com"
git config --global core.editor vim
git config --global init.defaultBranch main
git config --global alias.c 'commit -s'
git config --global alias.s 'status'
git config --global alias.l 'log --pretty=oneline --graph --abbrev-commit'

# Generate a key pair.
gpg --full-gen-key

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
# How to clean .git
# ---------------------------------------------------------------------
# Source: https://stackoverflow.com/a/5277575
git reflog expire --expire=now --all
git repack -ad
git prune

# ---------------------------------------------------------------------
# How to rebase in git, including squashing.
# ---------------------------------------------------------------------
git rebase -i HEAD~15
git rebase -i --root

# ---------------------------------------------------------------------
# How to rebase a pull-request commit.
# ---------------------------------------------------------------------
git remote add upstream https://github.com/TreeHacks/website.git
git fetch upstream
git rebase upstream/2023-finaldesign
git push -f

# ---------------------------------------------------------------------
# How to erase sensitive information from git history.
# Source:
#   https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository
# ---------------------------------------------------------------------
python ../git-filter-repo.py --replace-text <(echo "password==>REDACTED_USING_GIT_FILTER_REPO") --force
python ../git-filter-repo.py --replace-message <(echo "password==>REDACTED_USING_GIT_FILTER_REPO") --force
git push --force --mirror origin

# ---------------------------------------------------------------------
# How to sign all commits with GPG.
# ---------------------------------------------------------------------
git rebase --exec 'git commit --amend --no-edit -n -S' --root

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
```

<br>

### Laptop Battery Healthcare

```bash
# Install tlp: power management and battery care.
sudo dnf install -y tlp tlp-rdw  # Fedora only
sudo dnf remove power-profiles-daemon  # Fedora only
systemctl enable tlp.service  # Fedora only
systemctl mask systemd-rfkill.service systemd-rfkill.socket  # Fedora only

sudo add-apt-repository ppa:linrunner/tlp  # Ubuntu only
sudo apt update -y  # Ubuntu only
sudo apt install -y tlp tlp-rdw  # Ubuntu only

# For Kali, build from source: https://linrunner.de/tlp/installation/others.html

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

# Set `START_CHARGE_THRESH_BAT0=70`
# Set `STOP_CHARGE_THRESH_BAT0=80`
# Set `CPU_ENERGY_PERF_POLICY_ON_AC=performance`
# Set `PLATFORM_PROFILE_ON_AC=performance`
sudo vim /etc/tlp.conf

sudo tlp start

# See running status of tlp.
sudo tlp-stat -s

# See power statistics.
tlp-stat --psup

# Install powerstat: Power consumption measurement.
sudo dnf install -y powerstat  # Fedora

# Observations for my P14s Gen 2 AMD
# ==================================
# 1. 10% brightness, no wifi = 3.7 watt
# 2. 10% brightness, wifi    = 4.7 watt
# 3. 10% brightness, wifi    = 4.7 watt
# 4. 70% brightness, wifi    = 6.0 watt
```

<br>

### Tmux

```bash
# Source: https://www.redhat.com/sysadmin/introduction-tmux-linux
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
# By default, the prefix key is ctrl + b, but I like ctrl + a better.
# This also has the advantage of being able to nest tmux in SSH sessions.
# Use the ctrl + a as main prefix, and ctrl + b will work inside nested tmux.
tmux source ~/.tmux.conf

# Press Ctrl+a I to install the plugins.
# The systme resources status bar at the bottom, for example, requires this.

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

# How I prefer to start a new terminal.
# 1. Since .zshrc is set to open tmux by default, it will open tmux and
#    then create a new sesion.
# 2. Ctrl+a w to go to original sessions and delete the newly-created
#    session if needed.

# How I prefer to close terminal at the end.
# Ctrl+a Ctrl+s = Save sessions.
# Ctrl+a d = Detach from tmux.
# Ctrl d = Exit from terminal.

# My favorite keybindings
# =======================
# Ctrl+a ? = Show all shortcuts.
# Ctrl+a d = Detach from current session.
# Ctrl+a w = See all sessions, windows, and panes. Here, you can press x to kill.
# =======================
# Ctrl+a c = Create a new window.
# Ctrl+a <0|1|2|3|4|5|6|7|8|9> = Move to window using index.
# Ctrl+a n = Move to the next window.
# Ctrl+a p = Move to the previous window.
# Ctrl+a . = Give a new index to the current window.
# Ctrl+a , = Rename window.
# =======================
# Ctrl+a :new = Create a new session.
# Ctrl+a $ = Rename session.
# =======================
# Ctrl+a Space = Rotate through major preset pane arrangements.
# Ctrl+a Alt+<3|4|5> = Useful preset pane arrangements.
# Ctrl+a % = Split the window into two panes horizontally.
# Ctrl+a " = Split the window into two panes vertically.
# Ctrl+a <left|right|up|down> = Move between panes.
# Ctrl+a <{|}> = Switch panes with each other.
# Ctrl+a Ctrl+<left|right|up|down> = Resize pane.
# Ctrl+a x = Close pane.
# =======================
# Ctrl+a I = Install plugins specified at ~/.tmux.conf
# Ctrl+a Ctrl+s = Save panes and sessions.
# Ctrl+a Ctrl+r = Load saved panes and sessions.
# Ctrl+a [ = Enter copy mode. Here, drag with mouse and press y to copy. Supported by tmux-yank.
#            Also, use vi keybindings to move around. Spacebar to select.
# =======================
# Ctrl+a cjkl = Move to a different pane (tmux-pain-control).
# Ctrl+a shift+alt+i = Log all terminal i/o from this terminal (tmux-logging).
```

<br>

### Nvim

```bash
# Install Neovim.
# Download .appimage from https://github.com/neovim/neovim/releases
sudo chmod u+x nvim-linux-x86_64.appimage
sudo mkdir -p /opt/nvim
sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim
# add `export PATH="$PATH:/opt/nvim/"` to the profile dotfile.

# Install LunarVim.
# Get the newest version from https://www.lunarvim.org/docs/installation
sudo apt install -y python3-pynvim
LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)
# :LvimUpdate
# :LvimSyncCorePlugins

# Create a config file.
cp ~/.local/share/lunarvim/lvim/utils/installer/config.example.lua ~/.config/lvim/config.lua

# Set shada (Share Data) to remember global variables and marks.
echo vim.cmd\(\":set shada=\'1000\"\) >> ~/.config/lvim/config.lua

# Install Nerd Fonts.
curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
getnf
getnf > 1-70
fc-cache -f -v

# Open system settings and set `DroidSansMNerdFont-Regular` as the default mono font.
# Open terminal setting and set `DroidSansMNerdFont-Regular` as the font.

# My favorite keybindings
# =======================
# \ = Horizontal split
# | = Vertical split
# Ctrl{h|j|k|l} = Window navigation
# :q = Close window
# =======================
# Space + e = Neotree toggle
# Space + o = Neotree focus
# =======================
# :bnew = New buffer
# [b = Previous buffer
# ]b = Next buffer
# :bd = Close buffer
# =======================
# m[A-Z] = Set a marker and `'[A-Z]` go to the marker.
# q: = Open command-history buffer.

# Vim Commands
# =======================
# gc = Comment visual mode.
# gcc = Comment out a line.
# gcap = Comment out a paragraph.
# :7,17Commentary = Comment out with line numbers.
# "ayy = Copy into the specific register.
# "ap = Paste from the specific register.
# =======================
# :norm! @a = Execute a macro on multiple lines selected via visual mode.
# :ene|e = Edit a file in a new buffer, short for `:enew|edit`.
```

<br>

### Node.js

```bash
# Install nvm: Node version manager from https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script
# After installing nvm, close and reopen terminal,
# in order for new paths to take effect.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Install Node.js
nvm install node

# Install pnpm: a faster, parallel package manager.
npm install -g pnpm
pnpm setup

# If you're using zsh:
source ~/.zshrc

# Install tldr: similar to [man], but with simple examples.
pnpm add -g tldr
tldr -u
```

<br>

### Microsoft Sound Recorder

October 17, 2024.
I just realized Sound Recorder, which ships on Windows by default, is actually quite good.
It's great for speech practice.

<br>

### Google Privacy Monitoring

Google has a feature to notify you if your personal information is found online:
https://support.google.com/websearch/answer/12719076?hl=en

Also, use https://easyoptouts.com/ to help remove personal information online.

<br>

### What is `#!/bin/bash`?

Shell scripts can have the file extension of `.sh` but it can be more useful to leave it without any extension.
Instead, just put the shebang `#!/bin/bash` at the first one.
Plus, use `chmod +x` to make this script executable.

Also, apparently, this convention called shebang is not used on windows.
`.sh` convention is used in windows.

source: https://stackoverflow.com/questions/27813563/what-is-the-bash-file-extension

<br>

### How to create borders around images with gimp

For the README.MD for my "Latex Template for College Assignments," I had to add an example image.
I added light-grey (HTML Color Code F6F8FA) borders around the picture so that it doesn't just blend in too much with a white background.
"Filter" - "Decor" - "Border" - "Size 4" - "D value 1."

Plus, you can see the HTML color code on any website with Ctrl + Shift + c.

<br>

### Where to install binaries?

1. `/usr/bin` is for distribution-managed normal user programs.
2. `/usr/local/bin` is for normal user programs not managed by the distribution package manager, e.g. locally compiled packages. You should not install them into `/usr/bin` because future distribution upgrades may modify or delete them without warning.

Source: https://unix.stackexchange.com/a/8658

<br>

### `xournal`

June 21, 2022.
For my Calc II midterm exam, I needed a proctor service.
So, I was filling out the Examination Proctor Agreement form, which was a pdf.
Here's what I found and liked: xournal.

<br>

### `info`

I am so glad to have found the "top of the INFO tree.
It has documentations for everything, including core file manipulation, Gzip, grep, etc.
Try `info '(dir)Top'`, or `info bash` and `u`.

<br>

![Calc II Tips](https://user-images.githubusercontent.com/19341857/184079510-d7899b35-e114-4f50-a8a8-ab0c3a1384d5.png)
**_A random tip for Calc II._**

<br>
<br>
<br>
