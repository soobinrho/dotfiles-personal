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

<!--
On GitHub README.MD files, we can make folder structure
examples by using the bash command `tree`. 
-->
