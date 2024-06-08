#!/bin/bash
REPO2="https://github.com/rifqi/vvip/raw/main/"

function spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\|'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf " Done \b\b\b\b"
}

function downloadingsc() {
cd
rm -fr /usr/sbin/xdxl
mkdir -p /usr/sbin/xdxl
mkdir -p /usr/sbin/xdxl/style

wget -q -O project.zip "${REPO2}folder/menu.zip"
7z x -pCieBisaDecryptx1231 project.zip && rm -f project.zip
chmod +x menu/*
mv menu/*.sh /usr/sbin/xdxl/style/
mv menu/* /usr/local/sbin

}

function removesc() {
rm -fr menu
rm -fr up-x
rm -fr update.sh
}

clear
echo -e ""
echo -e ""
printf " Updating files script"
downloadingsc & sleep 3 & spinner
echo -e ""
printf " Removing files script"
removesc & sleep 3 & spinner

rm -fr xd
sleep 3 & menu
