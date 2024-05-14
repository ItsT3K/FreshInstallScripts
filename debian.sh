#!/bin/bash
#
#  -------------------------------------------------
# | T3K's Fresh Install Scripts                     |
# |-------------------------------------------------|
# | This is a bash file for when I do fresh installs|
# | on my Debian computers                          |
#  -------------------------------------------------

# Start before the menu
echo "T3K's fresh install script - Debian Edition"
echo "-------------------------------------------"
read -r -p "How many cores: " n0
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="T3K's Clean Install Script"
TITLE="T3K's Clean Installer"
MENU="Choose one of the following options:"

OPTIONS=(1 "Install The Basics"
         2 "Install Bluebird"
         3 "Install Telegram"
	 4 "Install other libraries")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            sudo apt install -y build-essential emacs opencubicplayer vlc cmake autoconf automake joe 
	    ./debian.sh
	    ;;
        2)
	    # Start by downloading and installing the icon package required by Bluebird
     	#directory things
	    cd ~/                            # Make sure we are in the home dir 
	    mkdir git                        
	    cd git
	    git clone https://github.com/shimmerproject/elementary-xfce
	    cd elementary-xfce
	    sudo apt install -y libgtk2.0-dev libgtk-3-dev optipng libgdk-pixbuf2.0-dev librsvg2-dev sassc
	    ./configure
	    make -j $n0
	    sudo make install -j $n0
	    sudo make icon-caches -j $n0
	    cd ~/git
	    # Bluebird portion
	    git clone https://github.com/shimmerproject/bluebird
	    cd bluebird
	    ./autogen.sh
	    make -j $n0
	    sudo make install
	    cd ~/
	    ./debian.sh
            ;;
        3)
            sudo apt install -y telegram-desktop
	    # More programs will go here soon
	    ./debian.sh
            ;;
	4)
	    sudo apt install libvte-2.91-dev libsdl2-dev
	    ./debian.sh
	    ;;
esac
