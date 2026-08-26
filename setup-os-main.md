[Go Back to Homepage](https://github.com/soobinrho/dotfiles-personal/tree/main#procedures-for-fresh-installs)

<br>

## How to configure fresh `os-main`

First, save the following code block as `setup-os-main.psh`.

```pwsh
$Env:PATH_SETUP_OS_MAIN_LOG = "setup-os-main.log.txt"
Write-Host "[INFO] Installation log: ""${env:PATH_SETUP_OS_MAIN_LOG}""" -ForegroundColor Green

Write-Host '[INFO] Uninstalling softwares I don''t need...' -ForegroundColor Green
Write-Host '[INFO] Note that Copilot, Onedrive, and Xbox Live need to be deleted manually from Settings.' -ForegroundColor Yellow
Get-AppxPackage -allusers '*communications*' | Remove-AppxPackage -allusers *>> $env:PATH_SETUP_OS_MAIN_LOG
Get-AppxPackage -allusers '*CandyCrushSaga*' | Remove-AppxPackage -allusers *>> $env:PATH_SETUP_OS_MAIN_LOG
Get-AppxPackage -allusers '*CandyCrushSodaSaga*' | Remove-AppxPackage -allusers *>> $env:PATH_SETUP_OS_MAIN_LOG
Get-AppxPackage -allusers '*Feedback*' | Remove-AppxPackage -allusers *>> $env:PATH_SETUP_OS_MAIN_LOG
Get-AppxPackage -allusers '*officehub*' | Remove-AppxPackage -allusers *>> $env:PATH_SETUP_OS_MAIN_LOG
Get-AppxPackage -allusers '*outlook*' | Remove-AppxPackage -allusers *>> $env:PATH_SETUP_OS_MAIN_LOG
Get-AppxPackage -allusers '*solitairecollection*' | Remove-AppxPackage -allusers *>> $env:PATH_SETUP_OS_MAIN_LOG
Get-AppxPackage -allusers '*bing*' | Remove-AppxPackage -allusers *>> $env:PATH_SETUP_OS_MAIN_LOG
Get-AppxPackage -allusers '*gamingapp*' | Remove-AppxPackage -allusers *>> $env:PATH_SETUP_OS_MAIN_LOG
Get-AppxPackage -allusers '*msteams*' | Remove-AppxPackage -allusers *>> $env:PATH_SETUP_OS_MAIN_LOG

Write-Host '[INFO] Disabling Windows'' Welcome message for new users...' -ForegroundColor Green
$path_winlogon = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' *>> $env:PATH_SETUP_OS_MAIN_LOG
if (-not (Test-Path $path_winlogon)) { New-Item -Path $path_winlogon -Force *>> $env:PATH_SETUP_OS_MAIN_LOG }
New-ItemProperty -Path $path_winlogon -Name 'EnableFirstLogonAnimation' -Value 0 -PropertyType DWORD -Force *>> $env:PATH_SETUP_OS_MAIN_LOG

$path_oobe = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows'
if (-not (Test-Path $path_oobe)) { New-Item -Path $path_oobe -Force *>> $env:PATH_SETUP_OS_MAIN_LOG }
New-ItemProperty -Path $path_oobe -Name 'DisablePrivacyExperience' -Value 1 -PropertyType DWORD -Force *>> $env:PATH_SETUP_OS_MAIN_LOG
New-ItemProperty -Path $path_oobe -Name 'PrivacyConsentStatus' -Value 1 -PropertyType DWORD -Force *>> $env:PATH_SETUP_OS_MAIN_LOG

Write-Host '[INFO] Disabling Logitech''s annoying popus...' -ForegroundColor Green
# Remove the Logitech bloatware.
$path_bloat = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'
if ((Get-Item $path_bloat).Property -contains 'Logitech Download Assistant') { Remove-ItemProperty -Path $path_bloat -Name 'Logitech Download Assistant' *>> $env:PATH_SETUP_OS_MAIN_LOG }

Write-Host '[INFO] Installing WSL...' -ForegroundColor Green
if (-not (Get-Command wsl -ErrorAction SilentlyContinue)) { wsl --install *>> $env:PATH_SETUP_OS_MAIN_LOG }

Write-Host '[INFO] Installing Chocolatey: a package manager for Windows...' -ForegroundColor Green
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) *>> $env:PATH_SETUP_OS_MAIN_LOG

Write-Host '[INFO] Installing my favorite tools...' -ForegroundColor Green
choco install -y neovim googlechrome firefox vscode.install 7zip.install rufus sqlite git git-lfs.install *>> $env:PATH_SETUP_OS_MAIN_LOG

Write-Host '[INFO] Provisioning appropriate users...' -ForegroundColor Green
# This assumes that the account you're running this from is `admin-soobin`.

Write-Host '[INFO] Enter the password for "soobinrho": ' -NoNewline -ForegroundColor Green
$Password = Read-Host -AsSecureString
net user 'soobinrho' /add
Set-LocalUser -Name 'soobinrho' -Password $Password

Write-Host '[INFO] Enter the password for "anonymous": ' -NoNewline -ForegroundColor Green
$Password = Read-Host -AsSecureString
net user 'anonymous' /add
net user 'anonymous-guests' /add
Set-LocalUser -Name 'anonymous' -Password $Password
```

<br>

Then, run the code block.

```pwsh
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
./setup-os-main.psh
```

<br>

## Notes

- Enable disk-level encryption using Bitlocker.
- Update Windows.
- Install WSL. `Turn Windows features on or off` and then enable `Windows Hypervisor Platform` and `Windows Subsystem for Linux`.
- Use `oobe\bypassnro` at startup if stuck with wifi driver issues.
- Alternatively, to solve the root cause, download all critical drivers from https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-p-series-laptops/thinkpad-p14s-gen-6-type-21qt-21qu/downloads/driver-list and extract to a folder. Copy that folder into the installation USB. When Windows first boots in and is not able to find a drive, it will give you an option to install all drivers in a specific dir.
- To avoid my `C:\Users` folder from being truncated by Windows to `soobi`, create a local user without MS account first; set the username to `soobinrho`; and finally link the account to Microsoft.

<br>
