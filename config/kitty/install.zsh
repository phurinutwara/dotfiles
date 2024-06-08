#!/bin/bash

while true; do
    read -p "Do you wish to install this program [y/n]? " yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
