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

## Install Startship cross-shell prompt
* [Starship.rs](https://starship.rs/)
```bash
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

```
* Ensure .zshrs/.bashrc has the init script at the end of the configfiles.
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
* Create GPG keys - [STEPS](https://help.github.com/en/articles/generating-a-new-gpg-key)
* Update GPG keys on Github - [STEPS](https://help.github.com/en/articles/telling-git-about-your-signing-key)
* Update global GPG settings to sign with gpg keys.
```bash
git config --global commit.gpgsign true 

```
