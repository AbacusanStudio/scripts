#!/bin/bash

# note: designed for xubuntu/linux mint/similar, assumes fresh OS install
# Update system

sudo apt-get update && sudo apt-get -y dist-upgrade

# Install dependencies

sudo apt-get -y install arduino squeak-vm gksu

# Create ~/tmp/ if doesn't exist

if [ ! -d $HOME/tmp ]
then
	mkdir $HOME/tmp
fi

# download studuino v2 and v1

wget -P $HOME/tmp/ http://abacusan.hu/wp-content/uploads/robotist_raspberry_pi.tar.bz2
wget -P $HOME/tmp/ http://abacusan.hu/wp-content/uploads/robotist_raspberry_pi_v2.tar.bz2

# Original source of files:
#wget -P $HOME/tmp/ http://www.artec-kk.co.jp/studuino/data/robotist_raspberry_pi.tar.bz2
#wget -P $HOME/tmp/ http://www.artec-kk.co.jp/studuino/data/robotist_raspberry_pi_v2.tar.bz2

# create ~/.local/opt/ if doesn't exist

if [ ! -d $HOME/.local/opt ]
then
	mkdir $HOME/.local/opt
fi

# create directories for install

mkdir $HOME/.local/opt/studuino2
mkdir $HOME/.local/opt/studuino1

# extract studuino v2 into ~/.local/opt/

tar -C $HOME/.local/opt/studuino2 -xjvf $HOME/tmp/robotist_raspberry_pi_v2.tar.bz2
tar -C $HOME/.local/opt/studuino1 -xjvf $HOME/tmp/robotist_raspberry_pi.tar.bz2


# create ~/.local/share/applications if doesn't exist

if [ ! -d $HOME/.local/share/applications ]
then
	mkdir $HOME/.local/share/applications
fi

# create .desktop file

DESKTOPFILE2="[Desktop Entry]\n \
Type=Application\n \
Name=Studuino2\n \
Comment=Studuino 2 Block Programming Environment\n \
Exec=gksudo $HOME/.local/opt/studuino2/Robotist/bpe.sh"

DESKTOPFILE1="[Desktop Entry]\n \
Type=Application\n \
Name=Studuino1\n \
Comment=Studuino 1 Block Programming Environment\n \
Exec=gksudo $HOME/.local/opt/studuino1/Robotist/bpe.sh"

echo -e $DESKTOPFILE2 > $HOME/tmp/studuino2.desktop
echo -e $DESKTOPFILE1 > $HOME/tmp/studuino1.desktop

sudo cp $HOME/tmp/studuino*.desktop /usr/share/applications/

# clean up temp files

rm -r $HOME/tmp/*
