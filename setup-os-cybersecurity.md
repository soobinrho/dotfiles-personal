<br>

## How to configure fresh `os-cybersecurity`

Avoid creating a Kali Linux installation USB from Windows because Defender will most likely corrupt the installation files.
Instead, create it from a Linux system following https://www.kali.org/docs/usb/live-usb-install-with-linux/

```bash
# Example. Follow the link above for most up-to-date guidelines.
sudo fdisk -l
sudo dd if=kali-linux-amd64.iso of=/dev/sdc conv=fsync bs=4M status=progress
```

<br>

After installation, save the following code block as `setup-os-main.sh`.

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

echo '[INFO] Setting up git...'
git config --global user.name 'Soobin Rho'
git config --global user.email 'soobinrho@gmail.com'
git config --global core.editor vim
git config --global init.defaultBranch main
git config --global alias.c 'commit -s'
git config --global alias.s 'status'
git config --global alias.l 'log --pretty=oneline --graph --abbrev-commit'
git config --global alias.lp 'log --patch'

echo '[INFO] Installing my favorite tools...'
sudo apt install -y tmux git-delta ripgrep &>> $PATH_SETUP_OS_CYBERSECURITY_LOG

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
sudo chmod +x ./setup-os-main.sh
./setup-os-main.sh
```

<br>

## Notes

```bash
# How to restore my taskbar setup.
cp ./home/soobinrho/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
reboot

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
