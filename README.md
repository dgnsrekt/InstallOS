# InstallOS - Desktop setup

## Install PopOS
* [PopOS](https://pop.system76.com/)

## Create common folders 
```bash
mkdir ~/bin
mkdir ~/Development
mkdir ~/Development/python
mkdir ~/Development/javascript
mkdir ~/Development/rust
mkdir ~/Development/docker

```

## Update system and switch to vanilla gnome
```bash
sudo apt update
sudo apt upgrade
sudo apt install gnome-session

```
* Restart computer and login with gnome.

## Install Chrome
* [Google Chrome](https://www.google.com/chrome/)

## Install Standard Applications
* [htop](https://github.com/htop-dev/htop)
* gdebi
* [glances](https://nicolargo.github.io/glances/)
* [neovim](https://github.com/neovim/neovim)
* zsh
* tree
* [lolcat](https://github.com/jaseg/lolcat)
* [neofetch](https://github.com/dylanaraps/neofetch)
* gnome-tweak-tool
* [gnome-shell-extensions](https://extensions.gnome.org)
* [snapd](https://snapcraft.io/snapd)
* [batcat](https://github.com/sharkdp/bat#installation)
* [bpytop](https://github.com/aristocratos/bpytop)
* [ffmpeg](https://ffmpeg.org/)
* [flameshot](https://github.com/flameshot-org/flameshot)
* vlc

```bash
sudo apt install htop gdebi glances neovim zsh tree lolcat neofetch gnome-tweak-tool gnome-shell-extensions snapd bat bpytop ffmpeg flameshot vlc -y

```

## Remove Packages
```bash
sudo apt remove --purge libreoffice-core
sudo apt clean
sudo apt autoremove

```

## Gnome Shell Extensions
* How to list extensions
```bash
gnome-extensions list
```
* install all current_gnome_extensions.txt

## Install Mononoki Nerd font
```bash
cd ~/.local/share

mkdir fonts

cd fonts

wget https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/Mononoki/Regular/complete/mononoki-Regular%20Nerd%20Font%20Complete.ttf

# Refresh font cache
fc-cache -f -v 

# Check if font is installed properly
fc-list | grep "mononoki" 

```

## Install SpaceVim 
* Note: May need to install nvm/node/yarn before installing markdown-preview.
* Fix: [markdown-preview.nvim: building failed issue.](https://github.com/SpaceVim/SpaceVim/issues/4234#issuecomment-962674451)
* [SpaceVim](https://spacevim.org/)
```bash
curl -sLf https://spacevim.org/install.sh | bash
```

## Update GNOME Terminal Settings
* Settings > Text > TextApperance - Turn off Custom Font

## GNOME Tweaks
* Apperance - Change everything to **POP**
* Extensions - *LAPTOP ONLY* turn on **System76 Power Management**
* Fonts - Monospace Text: **Mononoki Nerd Font Bold 14**
* Keyboard & Mouse - Additional Layout Options > Caps Lock Behavor > **Make Caps Lock an additional Esc**
* Top Bar - *LAPTOP ONLY* turn on **Battery Percentage**
* Top Bar - Turn on **Weekday**
* Workspaces - Trun on **Worspaces span displays**

## System Settings
* Power - Change blank screen to 15 minutes.
* Keyboard > Keyboard Shortcuts > Navigation > Move to Workspace Above add Super+UP
* Keyboard > Keyboard Shortcuts > Navigation > Move to Workspace Below add Super+Down

## Install Oh-My-ZSH
* [Oh-My-ZSH](https://ohmyz.sh/)
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

```
* Logout and log back in.
* Check the shell and path for any issues.
```bash
echo $SHELL
# Should return zsh.

echo $PATH
# Check path is clean. No duplicates paths.
```

## Install Starship cross-shell prompt
* [Starship.rs](https://starship.rs/)
```bash
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

```
* Ensure [.zshrc](.zshrc) / [.bashrc](.bashrc) has the init script at the end of the configfiles.
```bash
# ~/.bashrc

eval "$(starship init bash)"

# ~/.zshrc

eval "$(starship init zsh)"

```

## Setup Git / Github
* Update global settings
```bash
git config --global user.email "dgnsrekt@pm.me"
git config --global user.name "dgnsrekt"
git config --global core.editor "vim"

```
* Create SSH Keys and start the agent
```bash
ssh-keygen -t rsa -b 4096 -C "dgnsrekt@pm.me" # Generate key
eval "$(ssh-agent -s)"                        # Starts ssh-agent in the background
ssh-add ~/.ssh/id_rsa                         # Adds keys to ssh agent
cat ~/.ssh/id_rsa.pub                         # Shows public key

```
* Copy public key to GitHub Account Settings > SSH and GPG Keys > SSH keys
* Test SSH key works with github
```bash
ssh -T git@github.com

```
* Create GPG keys - [Follow steps](https://help.github.com/en/articles/generating-a-new-gpg-key)
* Update GPG keys on Github - [Follow steps](https://help.github.com/en/articles/telling-git-about-your-signing-key)
* Update global GPG settings to sign with gpg keys.
```bash
git config --global commit.gpgsign true 

```

## Install Dev Extras
```bash
sudo apt install httpie pkg-config libssl-dev build-essential -y

```

## Install Python
* Install pip / virtualenv / [pipx](https://github.com/pypa/pipx/)
```bash
sudo apt install python-is-python3
sudo apt install python3-pip python3-venv -y
python3 -m pip install --user pipx

```
* Ensure [.zshrc](.zshrc) / [.bashrc](.bashrc) have the $HOME/.local/bin set.
```bash
# set PATH so it includes user's private bin if it exists
# Needed for pipx / userpath
if [ -d "$HOME/.local/bin" ] ; then
PATH="$HOME/.local/bin:$PATH"
fi

```
* Install [Black](https://github.com/psf/black)
* Install [pytest-watch](https://github.com/joeyespo/pytest-watch)
```bash
pipx install black
pipx install pytest-watch

```
* Install [isort](https://github.com/PyCQA/isort)
* Install [pylint](https://github.com/PyCQA/pylint)
* Install [jedi](https://github.com/davidhalter/jedi)
```bash
pipx install isort pylint
pip install jedi

```

## Install Rust
* Install latests version of [Rust](https://www.rust-lang.org/tools/install)
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

```

## Install NVM/Node
* Install Node Version Manager
```bash
sudo apt-get install build-essential libssl-dev -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

```
* Ensure [.zshrc](.zshrc) / [.bashrc](.bashrc) have the NVM export
```bash
# Export for Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

```
* Check NVM version
```bash
nvm --version

```
* Install Node
```bash
nvm install 12

```
* Install [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/#debian-stable)
```bash
npm install --global yarn

```


## Install Docker
* Install [Docker Engine](https://docs.docker.com/engine/install/ubuntu/)
* Install [docker-compose](https://docs.docker.com/compose/install/)
* Make sure you can run docker without `sudo`.

## Install Visual Studio Code
* [vscode](https://code.visualstudio.com/)
### Extenstions
* Install `Python`
* Install `VIM`
* Add the following to File > Preferences > Settings > keyboard.dispatch > `keyCode` for vim fix.
```
I've swapped Escape and Caps Lock with setxkbmap and VSCodeVim isn't respecting the swap
This is a known issue in VS Code, as a workaround you can set "keyboard.dispatch": "keyCode" and restart VS Code.

```
* Install `Markdown All in One`
* Sync settings

## Install Third Party Desktop Applications
* [Telegram Flatpak](https://flathub.org/apps/details/org.telegram.desktop)
* [Discord](https://discord.com/)
* [Slack](https://slack.com/downloads/linux)
* [OBS Studio](https://obsproject.com/)
```bash
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update
sudo apt install ffmpeg v4l2loopback-dkms obs-studio -y
```
* [GitKraken](https://www.gitkraken.com/)
* [BeeKeeper Studio Snap](https://snapcraft.io/beekeeper-studio)
```bash
sudo snap install beekeeper-studio

```
* [Spotify](https://www.spotify.com/us/download/linux/)
```bash
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt update
sudo apt install spotify-client
```
* [Postman](https://snapcraft.io/postman)
```bash
sudo snap install postman

```
* [Krita](https://krita.org/en/)
```bash
sudo apt install krita

```
* [Zellij](https://github.com/zellij-org/zellij)
```bash
cargo install zellij

```
## Install Extras
```bash
sudo apt install ubuntu-restricted-extras vlc gimp unrar zip unzip p7zip-full p7zip-rar rar -y

```

## Fixes for MBP
* [FN key fix](https://unix.stackexchange.com/questions/121395/on-an-apple-keyboard-under-linux-how-do-i-make-the-function-keys-work-without-t)
* [Fix FAN mbpfan](https://github.com/linux-on-mac/mbpfan)
