#Adding parteners for skype
sudo dpkg --add-architecture i386
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"


sudo apt-get update
sudo apt-get upgrade

#Set up CLI
sudo apt-get install emacs23-nox emacs23-el zsh screen most git 
chsh -s /bin/zsh


# Set up GUI
sudo apt-get install chromium-browser ratpoison pepperflashplugin-nonfree flashplugin-installer skype libpulse0:i386 conky wicd xchat
sudo cp .ratpoison.desktop  /usr/share/xsessions/ratpoison.desktop

