#!/bin/bash
#
set -e

LOG_FILE="/var/log/top_head.log"
CURR_DIR=$(dirname "$0")

if [ $(id -u) != 0 ]; then
    echo "This script must be run as root" 
    exit 1
fi

echo "Installing a service top-head.service"

cp "$CURR_DIR"/top-head.sh /usr/local/bin
chown root:root /usr/local/bin/top-head.sh
chmod 755 /usr/local/bin/top-head.sh
echo -e '\033[32mCopied top-head.sh\033[31m'

cp "$CURR_DIR"/top-head.service  /etc/systemd/system/
chown root:root  /etc/systemd/system/top-head.service
chmod 644 /etc/systemd/system/top-head.service
echo -e '\033[32mCopied top-head.service\033[31m'

touch "$LOG_FILE"
chown nobody "$LOG_FILE"
chmod u+rw "$LOG_FILE"
echo -e '\033[32mCreated logfile\033[31m'

sudo systemctl daemon-reload
sudo systemctl stop top-head.service
sudo systemctl start top-head.service
echo -e '\033[32mThe service installed and started\033[31m'

#return colour to default
echo -ne '\033[0m'

read -p "Activate autostart after rebooting? [y/n] " ANSWER

#activate error colour
echo -ne '\033[31m'

if [[ $ANSWER =~ ^[yY]$ ]]; then
    sudo systemctl enable top-head.service
    echo -e '\033[32mThe service is autostarted after reboot\033[31m'
else
    rm /etc/systemd/system/multi-user.target.wants/top-head.service
    echo -e '\033[32mAutostart of the service deactivated\033[31m'
fi

#return colour to default
echo -ne '\033[0m'
echo "Installation complete"
