#!/usr/bin/bash
# Created by: Arash Morattab

TOP_DIR=$(cd $(dirname "$0") && pwd)

~/devstack/unstack.sh
~/devstack/clean.sh
# sudo reboot
cd /opt/stack
rm -rf ceilometer cinder glance heat* horizon keystone neutron nova noVNC os-* swift tempest dib-utils requirements
cd /usr/local/bin/
sudo rm -rf swift* keystone* cinder* ceilometer* glance* heat* neutron* nova*
cd $TOP_DIR
pip freeze > installedpips.txt
sudo pip uninstall -r installedpips.txt -y
sudo pip uninstall pip
sudo mkdir /usr/local/share/man
