# Update and Upgrade
sudo apt update
sudo apt upgrade

# Auto hide the dock
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false

# Install Sublime Text (http://tipsonubuntu.com/2017/05/30/install-sublime-text-3-ubuntu-16-04-official-way/)
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# Install git
sudo apt install git -y