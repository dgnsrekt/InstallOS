# InstallOS - Desktop setup

## Install PopOS
* [PopOS link](https://pop.system76.com/)

## Create common folders 
```bash
mkdir ~/bin
mkdir ~/Development

```

## Update system and switch to vanilla gnome
```bash
sudo apt update
sudo apt upgrade
sudo apt install gnome-session

```

## Install Chrome
* [Chrome link](https://www.google.com/chrome/)

## Install Standard Applications #TODO: add links
* htop
* gdebi
* glances
* neovim
* tmux
* zsh
* tree
* lolcat
* neofetch
* gnome-tweak-tool
* snapd

```bash
sudo apt install htop gdebi glances neovim tmux zsh tree lolcat neofetch gnome-tweak-tool snapd -y

```

## Install Nerd font
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

## Install Spacevim 
* [SpaceVim Link](https://spacevim.org/)
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
* Top Bar - *LAPTOP* turn on **Battery Percentage**
* Top Bar - Turn on **Weekday**
* Workspaces - Trun on **Worspaces span displays**





