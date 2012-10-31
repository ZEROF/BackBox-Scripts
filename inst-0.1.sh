#!/bin/bash
#This script was made by ZEROF <zerof@backbox.org>
#Easy-Creds 3.7 faster install script.
VERT="\\033[1;32m"
NORMAL="\\033[0;39m"
echo -e "\n"
echo -e "$VERT" "This will take some time, check some bash colors before you start Easy-Creds installation. \n" "$NORMAL"
sleep 3
echo "---Bg---40---41---42---43---44---45---46---47"
sleep 1
 for i in {30..37} # foreground
 do
sleep 1 
 echo -n -e fg$i- 
 for j in {40..47} # background
 do
sleep 1 
 echo -n -e '\E['$i';'$j'm SS64'
 tput sgr0 # Reset text attributes to normal without clear
 done
 echo # newline
 done
 echo -- Clear BG --
 for n in {30..37} # foreground
 do
 sleep 1
 echo -e fg$n '\E['$n';'01'm SS64'
 tput sgr0 # Reset text attributes to normal without clear
done
sleep 5
wget https://github.com/downloads/brav0hax/easy-creds/easy-creds-v3.7.tar.gz
sleep 2
echo -e "$VERT" "Here we go ....\n" "$NORMAL"
tar -zxvf easy-creds-v3.7.tar.gz
sleep 2
cd easy-creds/
sleep 2
sudo chmod 755 installer.sh
sleep 2
if [ $UID -ne 0 ]
      then      
         gksudo 
fi 
sudo ./installer.sh 
if [ $? -ne 0 ]
      then
         echo "error " && exit
      else
         echo "OK!"
fi
#Install Easy-Creds to BackBox menu and build symbolic link. O ye, we need to do that too.
sleep 2
echo -e "$VERT" "Geting Easy-Creds menu files \n" "$NORMAL"
cd /usr/share/applications
wget http://linux.re.rs/backbox/files/easy-creds3.7-inst-script/backbox-easy.desktop
cd ..
cd pixmaps
wget http://linux.re.rs/backbox/files/easy-creds3.7-inst-script/easy-creds.png
echo -e "$VERT" "Making symbolic links ...... \n" "$NORMAL"
cd
sudo cp /opt/easy-creds/easy-creds.sh /opt/easy-creds/easy-creds
ln -s /opt/easy-creds/easy-creds /usr/bin/easy
cd /opt/easy-creds/
sudo rm -rf installer.sh
echo -e 'Game over. \nEasy-Creds 3.7 is up and ready !'
sleep 5
exit 0
