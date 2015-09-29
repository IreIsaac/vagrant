#!/bin/bash

whoami

if [ "$(id -u)" != "0" ]; then
    echo "Please run this script as root"
    exit 1
fi

apt-get -y update
apt-get -y install apache2