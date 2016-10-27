#!/usr/bin/env bash

if [ $(dpkg-query -W -f='${Status}' ansible 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
    echo "Add APT repositories"
    export DEBIAN_FRONTEND=noninteractive
    sudo apt-get install -y --force-yes python-software-properties
    sudo apt-get install -y --force-yes python-setuptools

    echo "Installing Ansible"
    sudo easy_install pip
    sudo pip install ansible
    echo "Ansible installed"
fi
#source /opt/ansible/hacking/env-setup
sudo pip install jinja2
sudo apt-get install -y --force-yes software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update -y --force-yes
sudo apt-get install -y --force-yes ansible
ansible-playbook /vagrant/provisioning/vagrant.yml -c local -i localhost,
