#!/bin/bash

SCRIPT_NAME=$(basename $BASH_SOURCE)
SCRIPT_LOGFILE="./logs/"$(basename -s .sh $BASH_SOURCE)".log"


echo "running "$SCRIPT_NAME


if grep -Fxq "# installed by ubuntu-desktop-post-install/install_android.sh #" ~/.bashrc
then
	
	echo "  Android sdk, ndk, studio already installed"

else

	sudo add-apt-repository -y ppa:ubuntu-desktop/ubuntu-make &>> $SCRIPT_LOGFILE 
	sudo apt-get -y update &>> $SCRIPT_LOGFILE 
	sudo apt-get -y install ubuntu-make &>> $SCRIPT_LOGFILE 

	yes 'a' | umake android android-ndk /home/$USER/tools/android/android-ndk
	yes 'a' | umake android android-studio /home/$USER/tools/android/android-studio

	echo '' >> ~/.bashrc
	echo '#' >> ~/.bashrc
	echo '# android sdk, nkd, studio' >> ~/.bashrc
	echo '#' >> ~/.bashrc
	echo '# installed by ubuntu-desktop-post-install/install_android.sh #' >> ~/.bashrc
	echo '#' >> ~/.bashrc
	echo 'export PATH="$HOME/tools/android/android-ndk:$PATH"' >> ~/.bashrc
	echo 'export PATH="$HOME/Android/Sdk/platform-tools:$PATH"' >> ~/.bashrc
	echo '' >> ~/.bashrc

	echo "  !!! Please logout/relogin to be able to use Android SDK tools"

fi
