## Description
Script(s) for setting up a dev environment from a fresh ubuntu install.
## Usage
Requires wget and bash.
You are recommended to read scripts to find out what they do before executing them.
```
wget 'https://raw.githubusercontent.com/alec-w/ubunut-setup/master/setup.sh'
bash setup.sh
```
## What will be installed
1. An update and upgrade will be run (this should always be the first step after an fresh install).
2. The dock will be set to autohide (because it gets annoying).
3. `vim` will be installed (useful editor and we'll use it later).
4. `sublime-text` will be installed (more fully featured editor for actual coding).
5. `git` will be installed and `vim` will be set as it's default editor (see, told you we'd come back to that).
6. `docker` will be installed, made available to the current user without sudo (restart required to take effect) and set to run at boot.
7. `docker-compose` will be installed with bash completion.
