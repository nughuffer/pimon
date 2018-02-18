## This is still a work in progress. 
## I'm still playing with resolutions to make it readable
## Check https://learn.adafruit.com/worlds-smallest-mame-arcade-cabinet/hardware for wiring diagram
## For nanoscreen: https://github.com/adafruit/Adafruit_Userspace_PiTFT
## All credit goes to Adafruit and MilhouseVH...I just turned it all into a system service really

#!/bin/bash

wget https://github.com/adafruit/Adafruit_Userspace_PiTFT/raw/master/nanoscreen
sudo mv nanoscreen /boot
sudo chmod +x /boot/nanoscreen

curl -Ls https://raw.githubusercontent.com/MilhouseVH/bcmstat/master/bcmstat.sh -o ~/bcmstat.sh
sudo chmod +x ~/bcmstat.sh

sudo echo "disable_overscan=1" >> /boot/config.txt
sudo echo "hdmi_force_hotplug=1" >> /boot/config.txt
sudo echo "hdmi_group=2" >> /boot/config.txt
sudo echo "hdmi_mode=87" >> /boot/config.txt

## Doubled the resolution so you can actually see letters. Change first two numbers to set resolution.
sudo echo "hdmi_cvt=192 128 60 1 0 0 0" >> /boot/config.txt

sudo echo "# Optional, for portrait video:" >> /boot/config.txt
sudo echo "#display_rotate=3" >> /boot/config.txt

sudo cp pimon.service /etc/systemd/system/
cp pimon.sh /home/pi
sudo chmod +x /home/pi/pimon.sh

echo 'Add "/boot/nanoscreen &" before "exit 0" in /etc/rc.local'
echo 'Then enable pimon.service in systemd then reboot to activate'
