<br>

## How to configure fresh `os-dev`

Use Quickemu to install `os-dev` as a VM.

```bash
# Reference: https://github.com/quickemu-project/quickemu/wiki/01-Installation
sudo apt update
sudo apt upgrade -y
sudo apt install quickemu qemu-system-modules-spice
quickget ubuntu
quickemu --vm ubuntu*.conf

# Install OpenSSH server inside `os-dev`.
sudo apt update
sudo apt upgrade -y
sudo apt install openssh-server -y
sudo systemctl status ssh
ssh -p 22220 soobinrho@localhost

# TODO: Schedule `os-dev` to run at startup.
quickemu --vm ubuntu*.conf --display none
```

After installation, save the following code block as `setup-os-dev.sh`.

```bash
#!/usr/bin/env bash

export PATH_SETUP_OS_DEV_LOG='setup-os-dev.log'

echo '[INFO] Upgrading the system packages...'
sudo apt update &>> $PATH_SETUP_OS_DEV_LOG
sudo apt upgrade -y &>> $PATH_SETUP_OS_DEV_LOG

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
  &>> $PATH_SETUP_OS_DEV_LOG

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
sudo apt remove -y nano &>> $PATH_SETUP_OS_DEV_LOG

echo '[INFO] Setting up bat...'
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

echo '[INFO] Installing ncdu...'
wget https://dev.yorhel.nl/download/ncdu-2.9.1-linux-x86_64.tar.gz &>> $PATH_SETUP_OS_DEV_LOG
tar xvf ./ncdu*.tar.gz &>> $PATH_SETUP_OS_DEV_LOG
sudo chmod 755 ./ncdu
mv ./ncdu ~/.local/bin/
rm ./ncdu*.tar.gz

echo '[INFO] Installing Docker...'
curl -fsSL https://get.docker.com -o get-docker.sh &>> $PATH_SETUP_OS_DEV_LOG
sudo sh ./get-docker.sh &>> $PATH_SETUP_OS_DEV_LOG
sudo groupadd docker
sudo usermod -aG docker $USER

echo '[INFO] Enabling auto updates to get the security patches regularly...'
sudo apt install -y unattended-upgrades &>> $PATH_SETUP_OS_DEV_LOG
sudo dpkg-reconfigure -plow unattended-upgrades

echo '[INFO] Installing zsh4humans: a battery-included Zsh framework...'
sudo apt install -y zsh &>> $PATH_SETUP_OS_DEV_LOG
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
sudo chmod +x ./setup-os-dev.sh
./setup-os-dev.sh
```

<br>
