[Go Back to Homepage](https://github.com/soobinrho/dotfiles-personal/tree/main#procedures-for-fresh-installs)

<br>

## How to configure fresh `os-cybersecurity`

This is a Kali Linux VM instance inside `os-main`.
Download https://www.kali.org/get-kali/#kali-virtual-machines

Then, save the following code block as `setup-os-cybersecurity.sh`.

```bash
#!/usr/bin/env bash

export PATH_SETUP_OS_CYBERSECURITY_LOG='setup-os-cybersecurity.log'

echo '[INFO] Upgrading the system packages...'
sudo apt update &>> $PATH_SETUP_OS_CYBERSECURITY_LOG
sudo apt full-upgrade -y &>> $PATH_SETUP_OS_CYBERSECURITY_LOG

echo '[INFO] Reducing GRUB timeout from 5 seconds to 1 second...'
sudo sed -i -e 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub &>> $PATH_SETUP_OS_CYBERSECURITY_LOG
sudo update-grub >> $PATH_SETUP_OS_CYBERSECURITY_LOG

echo '[INFO] Enabling the HiDPI mode...'
kali-hidpi-mode enable &>> $PATH_SETUP_OS_CYBERSECURITY_LOG

echo '[INFO] Installing my favorite tools...'
sudo apt install -y \
  tmux \
  git-delta \
  ripgrep \
  gh \
  bat \
  curl \
  tree \
  wget \
  git \
  git-lfs \
  wipe \
  ffmpeg \
  jpegoptim \
  xournal \
  neofetch \
  htop \
  glances \
  powerstat \
  lnav \
  eza \
  zoxide \
  &>> $PATH_SETUP_OS_CYBERSECURITY_LOG

echo '[INFO] Setting up git...'
git config --global user.name 'Soobin Rho'
git config --global user.email 'soobinrho@gmail.com'
git config --global core.editor vim
git config --global init.defaultBranch main
git config --global alias.c 'commit -s'
git config --global alias.s 'status'
git config --global alias.l 'log --pretty=oneline --graph --abbrev-commit'
git config --global alias.lp 'log --patch'

echo '[INFO] Uninstalling nano so that vim becomes the default...'
sudo apt remove -y nano &>> $PATH_SETUP_OS_CYBERSECURITY_LOG

echo '[INFO] Setting up bat...'
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

echo '[INFO] Installing ncdu...'
wget https://dev.yorhel.nl/download/ncdu-2.9.1-linux-x86_64.tar.gz &>> $PATH_SETUP_OS_CYBERSECURITY_LOG
tar xvf ./ncdu*.tar.gz &>> $PATH_SETUP_OS_CYBERSECURITY_LOG
sudo chmod 755 ./ncdu
mv ./ncdu ~/.local/bin/
rm ./ncdu*.tar.gz

echo '[INFO] Installing Docker...'
curl -fsSL https://get.docker.com -o get-docker.sh &>> $PATH_SETUP_OS_CYBERSECURITY_LOG
sudo sh ./get-docker.sh &>> $PATH_SETUP_OS_CYBERSECURITY_LOG
sudo groupadd docker
sudo usermod -aG docker $USER

echo '[INFO] Installing zsh4humans: a battery-included Zsh framework...'
sudo apt install -y zsh &>> $PATH_SETUP_OS_CYBERSECURITY_LOG
sudo ln -s /usr/local/bin/zsh /bin/zsh
if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi
```

<br>

Then, run the code block.

```pwsh
sudo chmod +x ./setup-os-cybersecurity.sh
./setup-os-cybersecurity.sh
```

<br>

## Notes

```bash
# How to restore my taskbar setup.
wget https://raw.githubusercontent.com/soobinrho/dotfiles-personal/refs/heads/main/home/soobinrho/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
mv ./xfce4-panel.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
reboot

# How to control the Xorg server.
sudo service lightdm stop
sudo service lightdm start

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
