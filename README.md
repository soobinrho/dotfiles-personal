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

## Fresh Installs

[1.](setup-os-main.md) How to configure fresh `os-main`<br>
[2.](setup-os-cybersecurity.md) How to configure fresh `os-cybersecurity`<br>
[3.](setup-os-dev.md) How to configure fresh `os-dev`<br>
[4.](setup-os-backup.md) How to configure fresh `os-backup`

<br>

| Hostname | Purpose |
| -------- | ------- |
| `os-main` | A Windows instance used for my main tasks. |
| `os-cybersecurity` | A Kali Linux instance used for cybersecurity tasks. |
| `os-dev` | An Ubuntu instance as a VM inside `os-main`. Used for all development tasks. Isolated as a VM to mitigate the risk of supply-chain attacks. Treat as DMZ. This system must not have access to any of my sensitive information including my Google account, GitHub credentials, etc. |
| `os-backup` | An Ubuntu instance storing my offline backup files in case of failure in my cloud backups. Isolated from all other systems as much as possible to minimize the attack surface. |

<br>
<br>

## Profile Dotfiles

I use distro specific dotfiles as a baseline and add applicable sections as I go.
No need to copy and paste entirety of what's below.
Instead, only use what's useful for your use cases.

```bash
# .zshrc

# Modify the Zsh4humans default tmux startup command. Otherwise, it's super weird
# to use a regular terminal and VS Code terminal at the same time.
zstyle ':z4h:' start-tmux command tmux new-session

# "This option is a variant of INC_APPEND_HISTORY in which, where
# possible, the history entry is written out to the file after the
# command is finished."
# Source: https://zsh.sourceforge.io/Doc/Release/Options.html

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000000
HISTFILESIZE=10000000

# Use bat for manuals.
# Source: https://youtu.be/J0m_iHOTAY4?si=9A7_pkS3x0fB9-Gu
export MANPAGER="bat -l man -p"

# Gather history from multiple temrinals.
# Source: https://askubuntu.com/a/80380
export PROMPT_COMMAND='history -a'

export MY_IP=$(ip -4 addr show tun0 2> /dev/null | grep -oP '(?<=inet\s)([0-9.]+){3}')
export MY_IP_eth0=$(ip -4 addr show eth0 2> /dev/null | grep -oP '(?<=inet\s)([0-9.]+){3}')
export MY_IP_wlan0=$(ip -4 addr show wlan0 2> /dev/null | grep -oP '(?<=inet\s)([0-9.]+){3}')

export PATH="$PATH:/opt/nvim/"
alias vim='nvim'
alias svim='sudo /opt/nvim/nvim'
alias delta='delta --line-numbers'
alias ncdu='ncdu --color dark-bg --show-percent --show-itemcount --group-directories-first'
alias dockerrm="docker ps -aq | xargs docker stop | xargs docker rm"
alias dockervolumerm="docker volume ls -q | xargs docker volume rm"
alias dockerrmi="docker images -q | xargs docker rmi -f"

# Soruce: https://youtu.be/J0m_iHOTAY4?si=8feHtV51SHfeuUuF&t=355
alias ls='eza --icons'
alias ll='eza --icons --lh --git'
alias la='eza --icons --lah --git'

# Preferred editor for local and remote sessions.
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Zoxide makes `cd` much easier for long paths.
# Reference: https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"
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

## Notes

### Laptop Battery Healthcare

```bash
# Install tlp: power management and battery care.
sudo dnf install -y tlp tlp-rdw  # Fedora only
sudo dnf remove power-profiles-daemon  # Fedora only
systemctl enable tlp.service  # Fedora only
systemctl mask systemd-rfkill.service systemd-rfkill.socket  # Fedora only

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

# Uncomment and modify the following lines on `tlp.conf`.
# START_CHARGE_THRESH_BAT0=40
# STOP_CHARGE_THRESH_BAT0=50
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

### Useful PowerShell Commands

```powershell
# `grep` equivalent.
Select-String -Path ./**/* -Pattern 'PATH_CSRA' -ErrorAction SilentlyContinue
Get-ChildItem -Recurse *.* | Select-String -Pattern "print\(e\)"

# `tail -f` equivalent.
Get-Content ./file.txt -Tail 5 -Wait

# `diff` equivalent.
fc ./1 ./2

# Set encoding to UTF-8.
Get-Content .\uv.toml | Set-Content -Encoding utf8 ./uv.utf8.toml
```

<br>

### Tmux

```bash
# Source: https://www.redhat.com/sysadmin/introduction-tmux-linux
# Install tmux: the best terminal multiplexer.
sudo dnf install -y tmux  # Fedora
sudo apt install -y tmux  # Ubuntu

# Apply my tmux configs.
wget https://raw.githubusercontent.com/soobinrho/dotfiles-personal/refs/heads/main/home/soobinrho/.tmux.conf
mv ./.tmux.conf ~/

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
sudo dnf groupinstall -y "Development Tools" "Development Libraries"  # Fedora
sudo apt install -y cmake build-essential  # Ubuntu

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
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage
sudo chmod u+x ./nvim-linux-x86_64.appimage
sudo mkdir -p /opt/nvim
sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim
# add `export PATH="$PATH:/opt/nvim/"` to the profile dotfile.

# Install LazyVim.
git clone https://github.com/LazyVim/starter ~/.config/nvim

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
# Ctrl + q = Enter visual mode.
# gc = Comment visual mode.
# gcc = Comment out a line.
# gcap = Comment out a paragraph.
# :7,17Commentary = Comment out with line numbers.
# "ayy = Copy into the specific register.
# "ap = Paste from the specific register.
# =======================
# :norm! @a = Execute a macro on multiple lines selected via visual mode.
# :ene|e = Edit a file in a new buffer, short for `:enew|edit`.
# =======================
# :%s/HERE(\d+)/\1HERE/g = \1 means first () group, \2 means second () group, and so on.
# :%s/^\d+/&,/g = & means entire match
```

<br>

### Delta

```bash
sudo apt install -y git-delta
git config --global core.pager 'delta'
git config --global interactive.diffFilter 'delta'
git config --global core.pager 'delta'
git config --global delta.navigate 'true'
```

<br>

### Ripgrep

```bash
rg REGEX_TO_SEARCH
rg -tpy PYTHON_FILES
rg -Tpy NOT_PYTHON_FILES
rg -u INCLUDE.GITIGNORED_FILES
rg -uu INCLUDE.GITIGNORED_FILES_AND_HIDDEN_FILES
rg -uuu INCLUDE.GITIGNORED_FILES_AND_HIDDEN_FILES_AND_BINARY_FILES
```

<br>

### Docker

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
sudo groupadd docker
sudo usermod -aG docker $USER
```

<br>

### Version Control (Git)

```bash
sudo apt install gh
gh auth login

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

# ---------------------------------------------------------------------
# How to reset file permissions in git.
# Source:
#   https://stackoverflow.com/a/4408378
# ---------------------------------------------------------------------
git diff -p -R --no-ext-diff --no-color --diff-filter=M \
    | grep -E "^(diff|(old|new) mode)" --color=never  \
    | git apply

# ---------------------------------------------------------------------
# Git commands to run to get an overview when starting a new project.
# Source:
#   https://news.ycombinator.com/item?id=47687273
# ---------------------------------------------------------------------
# Which file changes the most?
git log --format=format: --name-only --since="1 year ago" | sort | uniq -c | sort -nr | head -20

# Who built this?
git shortlog -sn --no-merges

# Where are the current bugs?
git log -i -E --grep="fix|bug|broken|todo" --name-only --format='' | sort | uniq -c | sort -nr | head -20

# ---------------------------------------------------------------------
# How to download the latest from a GitHub Releases page.
# Source:
#   https://stackoverflow.com/a/26738019
# ---------------------------------------------------------------------
wget $(curl -sL https://api.github.com/repos/VirusTotal/vt-cli/releases/latest | grep browser_download_url | grep 'Linux64.zip' | cut -d '"' -f 4)
```

<br>

### Node.js

```bash
# Install nvm: Node version manager from https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script
# After installing nvm, close and reopen terminal,
# in order for new paths to take effect.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/refs/heads/master/install.sh | bash

# Install Node.js
nvm install node

# Install pnpm: a faster, parallel package manager.
npm install -g pnpm
pnpm setup

# If you're using zsh:
source ~/.zshrc
```

<br>

### uv (Python Package Manager)

Install from https://docs.astral.sh/uv/getting-started/installation/

```bash
# =======================================
# Reduce the risk of supply-chain attacks
# =======================================
# Linux
echo 'exclude-newer = "7 days"' >> ~/.config/uv/uv.toml

# Windows
New-Item -ItemType Directory -Force -Path $env:APPDATA\uv
echo 'exclude-newer = "7 days"' >> $env:APPDATA\uv\uv.toml
```

<br>

### ruff (Python Linter and Formatter)

Install from https://docs.astral.sh/ruff/installation/ and install the VS Code extension for ruff.
Add these configs to `User Settings (JSON)`:

```json
  "notebook.formatOnSave.enabled": true,
  "notebook.codeActionsOnSave": {
    "notebook.source.fixAll": "explicit",
    "notebook.source.organizeImports": "explicit",
  },
  "[python]": {
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": "explicit",
      "source.organizeImports": "explicit",
    },
    "editor.defaultFormatter": "charliermarsh.ruff",
  },
  "ruff.format.preview": true,
  "[markdown]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "charliermarsh.ruff",
  },
```

<br>

### Font: Maple Mono NF

Reference: https://news.ycombinator.com/item?id=47575403

Download and install Maple Mono NF (Nerd Font) (Select unhinted) from https://github.com/subframe7536/maple-font/releases

- **QTerminal**: `Maple Mono NF`
- **VS Code**: `Maple Mono NF`
- **MS Terminal**: `Maple Mono NF`

On VS Code, add these configs to `User Settings (JSON)`:

```json
  "editor.fontFamily": "'Maple Mono NF'",
  "editor.inlineSuggest.fontFamily": "'Maple Mono NF'",
  "debug.console.fontFamily": "'Maple Mono NF'",
  "editor.codeLensFontFamily": "'Maple Mono NF'",
  "editor.inlayHints.fontFamily": "'Maple Mono NF'",
  "terminal.integrated.fontFamily": "'Maple Mono NF'",
  "notebook.markup.fontFamily": "'Maple Mono NF'",
  "notebook.output.fontFamily": "'Maple Mono NF'",
  "chat.editor.fontFamily": "'Maple Mono NF'",
  "chat.fontFamily": "'Maple Mono NF'",
  "editor.fontLigatures": true,
```

Note: ligatures feature is nice to have.
Any [TODO], [NOTE], [FIXME], and [WARNING] inside the code get super nice graphics thanks to Maple Mono's ligatures.

1. Download the Nerd Font zip and unzip.
2. Select all `.ttf` files inside
3. Install:
   - **Windows** — select all → right-click → Install
   - **Linux** — copy to `~/.local/share/fonts/` then run `fc-cache -fv`

<br>

### Microsoft Sound Recorder

October 17, 2024.
I just realized Sound Recorder, which ships on Windows by default, is actually quite good.
It's great for speech practice.

<br>

### Microsoft Flight Simulator 2024

For security best practices, create a dedicated account for MSFS so that my friends can play it on my computer without giving them access to my main user account.
All flight sim including MSFS as well as add-ons and drivers should be installed under this account.

<br>

Configure the Logitech Radio Panel driver to run at login:

1. Open Task Scheduler
2. Create Task...
3. Configure it to run at login and execute `"C:\Program Files\Logitech\Microsoft Flight Simulator Plugin\LogiMicrosoftFlightSimulator.exe" --run --force`

<br>

### Flight Sim Key Bindings

First, go to each axis and set deadzone as 0.1.
For the view axis x and y, set deadzone as 0.3.

Then, configure:

#### Primary Control Surface

- Rudder axis
- Aileron axis
- Elevator axis

<br>

#### View Controls

- Cockpit quick view left / right 40°
- Cockpit quick view up / down
- Cockpit view left / right / up / down axis
- External quick view left / right / up
- External view left / right / up / down axis
- Cockpit view zoom in / out
- External view zoom in / out
- Cockpit view reset
- External view reset

<br>

#### Other Controls

- Throttle axis
- Flaps axis
- Gear up / down
- Brake axis
- Individual toe left / right brake axis (Right click the z axis on VPC Configuration software and create two virtual axis based on the z axis: Lz & Rz)
- Parking brake on / off
- Spoilers toggle

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

### My Other Useful Workflows

```bash
# ---------------------------------------------------------------------
# How to install tldr.
# ---------------------------------------------------------------------
# Do not install from `sudo apt install`. This installs an older
# version that can error out.
uv tool add pipx
uv tool add tldr
tldr -u

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
sudo apt install -y alacritty  # Ubuntu

# Apply my Alacritty configs.
wget https://raw.githubusercontent.com/soobinrho/dotfiles-personal/refs/heads/main/home/soobinrho/.config/alacritty/alacritty.toml
mkdir -p ~/.config/alacritty
mv ./alacritty.toml ~/.config/alacritty/

# Go to Shortcuts settings and unbind Konsole's Ctrl + Alt + t shortcut.
# Bind alacritty to Ctrl + Alt + t.

# ---------------------------------------------------------------------
# vt-cli (VirusTotal CLI) workflows.
# ---------------------------------------------------------------------
# Install vt-cli from:
#   https://github.com/VirusTotal/vt-cli/releases/latest
wget $(curl -sL https://api.github.com/repos/VirusTotal/vt-cli/releases/latest | grep browser_download_url | grep 'Linux64.zip' | cut -d '"' -f 4)
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
# How to block distracting websites at work (Windows).
# ---------------------------------------------------------------------
# Ctrl + x and then Windows PowerShell (Admin)
cd C:\Windows\System32\drivers\etc
"`n127.0.0.1 news.ycombinator.com www.linkedin.com www.reddit.com reddit.com amazon.com ebay.com apnews.com www.bbc.com cnn.com www.foxnews.com www.theguardian.com" | out-file -encoding UTF8 -append hosts
```

<br>

![Calc II Tips](https://user-images.githubusercontent.com/19341857/184079510-d7899b35-e114-4f50-a8a8-ab0c3a1384d5.png)

**_A random tip for Calc II._**

<br>
<br>
<br>
