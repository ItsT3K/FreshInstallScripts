#!/bin/bash
#
#  -------------------------------------------------
# | T3K's Fresh Install Scripts                     |
# |-------------------------------------------------|
# | This is a bash file for when I do fresh installs|
# | on my Debian computers                          |
#  -------------------------------------------------

# Start before the menu
clear
echo "Checking for prerequisites"
	if ! command -v git &> /dev/null	# check to see if git is installed, if it isnt, install it
	then
		echo "Installing git..."
		sudo apt install -y git
	else
		echo "Git Found!"
	fi
	# check for dialog
	if ! command -v dialog &> /dev/null
	then
		echo "Installing dialog..."
		sudo apt install -y dialog
	else
		echo "Dialog Found!"
	fi
sleep 5		# let 'er rest for a lil bit so it's not crazy
clear
echo "T3K's fresh install script - Debian Edition"
echo "-------------------------------------------"
read -r -p "How many cores: " n0			# makes a flag for gcc/g++ to read from for core count
# ---- DIALOG SETTINGS ----
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
# ---- END DIALOG SETTINGS ----
clear
case $CHOICE in
        1)
            sudo apt install -y build-essential emacs opencubicplayer vlc cmake autoconf automake joe 
	    	./debian.sh # restart the program
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
