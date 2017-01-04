#!/usr/bin/env bash

sudo pip install virtualenvwrapper
mkdir $HOME/.virtualenvs
cat <<EOT >> ~/.bash.rc
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh
EOT

source ~/.bashrc
mkvirtualenv ansible2 --system-site-packages
workon ansible2

