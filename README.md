# Overview

These are the configuration dotfiles that I use personally,
including `.vimrc` and `.bashrc`. You can find them here:

```bash
.
├── home
│   └── soobinrho
│       ├── .bashrc
│       ├── .vim
│       │   └── plugins.vim
│       └── .vimrc
```

# Examples

**Adding `Vim` Plugins
[[Original article by Alex Hunt](https://medium.com/@huntie/10-essential-vim-plugins-for-2018-39957190b7a9)]**

```bash
# Copy and paste .vimrc and plugins.vim
cd git/dotfiles-personal/home/soobinrho
cp .vimrc ~/.vimrc
cp .vim/plugins.vim ~/vim/plugins.vim

# Install the plugins.
vim
:PlugInstall 
```

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
```

**Creating a key for SSH
[[Original article by Brian Boucheron](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys-on-ubuntu-20-04)]**

```bash
# Create a key with the length of 4096 bits. 
ssh-keygen -b 4096

# Copy the public key to the SSH server.
ssh-copy-id root@ip_address
```

**Setting up a Ubuntu server on DigitalOcean
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
# to the user.
rsync --archive --chown=main:main /root/.ssh /home/main
```

**Configuring sshd_config on a Ubuntu server
[[Original article by Justin Ellingwood](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys)]**

```bash
# Open the config file.
sudo vim /etc/ssh/sshd_config

# Disallow password authentication
# so that only the RSA SSH key can be used.
PasswordAuthentication no

# Only allow certain users to ssh.
AllowUsers soobinrho

# Disable root login.
PermitRootLogin no

# Restart ssh.
sudo service ssh restart
```

**Using a Fedora machine as a temporary ssh server
[[Original article by Justin Ellingwood](https://www.digitalocean.com/community/tutorials/ssh-essentials-working-with-ssh-servers-clients-and-keys)]**

```bash
# Start the ssh server.
sudo service sshd start

# (Optional) Stop sshd. Note that sshd will be 
# stopped automatically after rebooting.
# However, we can manually stop it by:
sudo service sshd stop
```




<!--
On GitHub README.MD files, we can make folder structure
examples by using the bash command `tree`. 
-->
