# Update and Upgrade
sudo apt update
sudo apt upgrade -y

# Auto hide the dock
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false

# Install vim
sudo apt install vim -y

# Install Sublime Text (http://tipsonubuntu.com/2017/05/30/install-sublime-text-3-ubuntu-16-04-official-way/)
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# Install git
sudo apt install git -y
git config --global core.editor "vim"

# Install Docker (https://docs.docker.com/install/linux/docker-ce/ubuntu/)
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# Post install steps for Docker (https://docs.docker.com/install/linux/linux-postinstall/)
# Enable running docker as non root user - system restart required to take effect
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker

# Install Docker Composer
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# Install bash completion
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.24.0/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

echo 'Restart the machine for all changes to take effect.'
