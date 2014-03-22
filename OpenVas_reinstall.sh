# This script will help you to reinstall and set OpenVas. Run as root !!!
# Tested only with BackBox Linux
# This script was made by ZEROF <zerof@backbox.org>

#!/bin/bash

selection=
until [ "$selection" = "0" ]; do
    echo ""
    echo -e "\e[40;38;5;82m OpenVas \e[30;48;5;82m REINSTALL \e[0m"
    echo ""
    echo "01 - stop OpenVas"
    echo "02 - purge OpenVas"
    echo "03 - clean all config and logs"
    echo "04 - system update and upgrade"
    echo "05 - install OpenVas"
    echo ""
    echo -e "\e[40;38;5;82m OpenVas \e[30;48;5;82m SETTINGS \e[0m"
    echo ""
    echo "1 - stop OpenVas"
    echo "2 - make cert"
    echo "3 - performing a synchronization with an OpenVAS NVT Feed"
    echo "4 - make client cert"
    echo "5 - load plugins"
    echo "6 - openvasmd --migrate"
    echo "7 - openvasmd --rebuild"
    echo "8 - performing a synchronization with an SCAP data feed"
    echo "9 - performing a synchronization with an CERT data feed"
    echo "10 - add admin user (you will set pass for user admin)"
    echo "11 - stop scanner"
    echo "12 - start OpenVas"
    echo ""
    echo "0 - exit program"
    echo ""
    echo -n "Enter selection: "
    read selection
    echo ""
    case $selection in
    
    01 ) openvas-service stop ;;
    02 ) apt-get purge greenbone-security-assistant openvas-cli openvas-manager openvas-scanner openvas-administrator ;;
    03 ) apt-get autoremove --purge; rm -rf /var/lib/openvas/; rm -rf /usr/share/openvas/; rm -rf /var/cache/openvas/; rm -rf /var/log/openvas/ ;;
    04 ) apt-get update;apt-get dist-upgrade ;;
    05 ) apt-get install greenbone-security-assistant openvas-cli openvas-manager openvas-scanner openvas-administrator sqlite3 xsltproc rsync htmldoc alien rpm nsis fakeroot ;;
    
	1 ) service openvas-scanner stop && service openvas-manager stop && service openvas-administrator stop && service greenbone-security-assistant stop  ;;
    2 ) test -e /var/lib/openvas/CA/cacert.pem  || openvas-mkcert -q ;;
    3 ) openvas-nvt-sync --wget  ;;
    4 ) test -e /var/lib/openvas/users/om || openvas-mkcert-client -n om -i ;;
    5 ) openvassd ;;
    6 ) openvasmd --migrate ;;
    7 ) openvasmd --rebuild ;;
    8 ) openvas-scapdata-sync ;;
    9 ) openvas-certdata-sync ;;
    10 ) test -e /var/lib/openvas/users/admin || openvasad -c add_user -n admin -r Admin ;;
    11 ) killall openvassd ;;
    12 ) service openvas-scanner start; service openvas-manager start; service openvas-administrator restart; service greenbone-security-assistant restart ;;
	0 ) exit ;;
        * ) echo "Please enter 01, 02, 03, 04, 05, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 or 0"
    esac
done


