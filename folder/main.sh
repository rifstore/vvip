#!/bin/bash
clear
rm -fr ${0}
Green="\e[92;1m"
RED="\033[31m"
YELLOW="\033[33m"
BLUE="\033[36m"
FONT="\033[0m"
GREENBG="\033[42;37m"
REDBG="\033[41;37m"
OK="${Green}--->${FONT}"
ERROR="${RED}[ERROR]${FONT}"
GRAY="\e[1;30m"
NC='\e[0m'
r='\e[1;31m'
g="\033[1;92m"
tyblue='\e[1;36m'
pth="\033[1;37m"
green='\e[0;32m'
curl -sS ipv4.icanhazip.com > /root/.myip
export IP=$(cat /root/.myip)

exitsc="\033[0m"
y="\033[1;93m"
j="\033[0;33m"
function lane() {
echo -e "${y}────────────────────────────────────────────${exitsc}"
}
url_izin="https://raw.githubusercontent.com/rifstore/izinsc/main/ip"
ipsaya=$(cat /root/.myip)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
checking_sc() {
useexp=$(wget -qO- $url_izin | grep $ipsaya | awk '{print $3}')
if [[ $date_list < $useexp ]]; then
echo -ne
else
lane
echo -e "\033[42m          404 NOT FOUND AUTOSCRIPT          ${exitsc}"
lane
echo -e ""
echo -e "            \033[0;35mPERMISSION DENIED !${exitsc}"
echo -e "   ${j}Your VPS${exitsc} $ipsaya ${j}Has been Banned${exitsc}"
echo -e "     ${j}Buy access permissions for scripts${exitsc}"
echo -e "             ${j}Contact Admin :${exitsc}"
echo -e "      \033[0;36mWhatsapp${exitsc} wa.me/6285797169413"
lane
exit
fi
}
checking_sc

function lane_atas() {
echo -e "${tyblue}┌─────────────────────────────────────────────┐${NC}"
}
function lane_bawah() {
echo -e "${tyblue}└─────────────────────────────────────────────┘${NC}"
}

# // Checking Os Architecture
if [[ $( uname -m | awk '{print $1}' ) == "x86_64" ]]; then
echo -e "${OK} Your Architecture Is Supported ( ${green}$( uname -m )${NC} )"
else
echo -e "${EROR} Your Architecture Is Not Supported ( ${YELLOW}$( uname -m )${NC} )"
exit 1
fi

# // Checking System
if [[ $( cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g' ) == "ubuntu" ]]; then
echo -e "${OK} Your OS Is Supported ( ${green}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
elif [[ $( cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g' ) == "debian" ]]; then
echo -e "${OK} Your OS Is Supported ( ${green}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
else
echo -e "${EROR} Your OS Is Not Supported ( ${YELLOW}$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g' )${NC} )"
exit 1
fi

if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
clear

# REPO
REPO="https://raw.githubusercontent.com/rifstore/vvip/main/"

# Information vps
curl -sS "ipinfo.io/org?token=7a814b6263b02c" > /root/.isp
curl -sS "ipinfo.io/city?token=7a814b6263b02c" > /root/.city
curl -sS "ipinfo.io/timezone?token=7a814b6263b02c" > /root/.timezone

####
start=$(date +%s)
secs_to_human() {
echo "Installation time : $((${1} / 3600)) hours $(((${1} / 60) % 60)) minute's $((${1} % 60)) seconds"
}
function print_ok() {
echo -e "${OK} ${BLUE} $1 ${FONT}"
}
function print_install() {
lane_atas
echo -e "${tyblue}│${pth} $1 ${NC}"
lane_bawah
sleep 2
}

function print_error() {
echo -e "${ERROR} ${REDBG} $1 ${FONT}"
}

function print_success() {
if [[ 0 -eq $? ]]; then
lane_atas
echo -e "${tyblue}│${pth} $1 berhasil dipasang ${NC}"
lane_bawah
sleep 2
fi

}
function is_root() {
if [[ 0 == "$UID" ]]; then
print_ok "Root user Start installation process"
else
print_error "The current user is not the root user, please switch to the root user and run the script again"
fi

}

# Buat direktori xray
print_install "Membuat direktori xray"
mkdir -p /etc/xray

curl -s ipinfo.io/city >> /etc/xray/city
curl -s ifconfig.me > /etc/xray/ipvps
curl -s ipinfo.io/org | cut -d " " -f 2-10 >> /etc/xray/isp
touch /etc/xray/domain
mkdir -p /var/log/xray
chown www-data.www-data /var/log/xray
chmod +x /var/log/xray
touch /var/log/xray/access.log
touch /var/log/xray/error.log
mkdir -p /var/lib/fvstore >/dev/null 2>&1
# // Ram Information
while IFS=":" read -r a b; do
case $a in
"MemTotal") ((mem_used+=${b/kB})); mem_total="${b/kB}" ;;
"Shmem") ((mem_used+=${b/kB}))  ;;
"MemFree" | "Buffers" | "Cached" | "SReclaimable")
mem_used="$((mem_used-=${b/kB}))"
;;
esac
done < /proc/meminfo
Ram_Usage="$((mem_used / 1024))"
Ram_Total="$((mem_total / 1024))"
export tanggal=`date -d "0 days" +"%d-%m-%Y - %X" `
export OS_Name=$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' )
export Kernel=$( uname -r )
export Arch=$( uname -m )

# Change Environment System
function first_setup(){
timedatectl set-timezone Asia/Jakarta
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
print_success "Directory Xray"
if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
echo "Setup Dependencies $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
sudo apt update -y
apt-get install --no-install-recommends software-properties-common
add-apt-repository ppa:vbernat/haproxy-2.0 -y
apt-get -y install haproxy=2.0.\*
elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
echo "Setup Dependencies For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
curl https://haproxy.debian.net/bernat.debian.org.gpg |
gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" \
http://haproxy.debian.net buster-backports-1.8 main \
>/etc/apt/sources.list.d/haproxy.list
sudo apt-get update
apt-get -y install haproxy=1.8.\*
else
echo -e " Your OS Is Not Supported ($(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g') )"
exit 1
fi
}

# Install Nginx
function nginx_install() {
# // Checking System
if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
print_install "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
# // sudo add-apt-repository ppa:nginx/stable -y 
sudo apt-get install nginx -y 
elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
print_success "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
apt -y install nginx 
else
echo -e " Your OS Is Not Supported ( ${YELLOW}$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${FONT} )"
fi
}

# Update and remove packages
function base_package() {
clear
print_install "Menginstall Packet Yang Dibutuhkan"
apt install pwgen netcat -y
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt install ruby -y
gem install lolcat
systemctl enable chronyd
systemctl restart chronyd
systemctl enable chrony
systemctl restart chrony
chronyc sourcestats -v
chronyc tracking -v
apt install ntpdate -y
ntpdate pool.ntp.org
apt install sudo -y
sudo apt-get clean all
sudo apt-get autoremove -y
sudo apt-get install -y debconf-utils
sudo apt-get remove --purge exim4 -y
sudo apt-get remove --purge ufw firewalld -y
sudo apt-get install -y --no-install-recommends software-properties-common
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
sudo apt-get install -y speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl build-essential lsof tar wget curl zip unzip p7zip-full python3 neofetch python3-pip libc6 util-linux build-essential msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg1 gnupg2 ca-certificates lsb-release gcc shc make cmake git screen socat xz-utils apt-transport-https dnsutils cron bash-completion ntpdate chrony jq openvpn easy-rsa
print_success "Packet Yang Dibutuhkan"

}
function pasang_domain() {
clear
echo ""
echo -e "${r}──────────────────────────────────────────${NC}"
echo "           XDXL VPN STORE "
echo -e "${r}──────────────────────────────────────────${NC}"
echo -e "${r}    ♦️${NC} ${green} CUSTOM SETUP DOMAIN VPS     ${NC}"
echo -e "${r}──────────────────────────────────────────${NC}"
echo "  1. Gunakan Domain Sendiri"
echo "  2. Gunakan Domain Dari Script"
echo -e "${r}──────────────────────────────────────────${NC}"
read -p "   Piih Angka dari [ 1 - 2 ] : " host
echo ""
if [[ $host == "1" ]]; then
echo -e "   ${g}Masukan domain mu ! $NC"
read -p "   Subdomain: " host1
echo "IP=" >> /var/lib/fvstore/ipvps.conf
echo $host1 > /etc/xray/domain
echo $host1 > /root/domain
echo ""
elif [[ $host == "2" ]]; then
#install cf
wget -q ${REPO}ssh/cf.sh && chmod +x cf.sh && ./cf.sh
rm -f /root/cf.sh
clear
else
echo -e " Input dengan benar ! "
sleep 2
pasang_domain
fi
}

function notification() {
username=$(curl $url_izin | grep $IP | awk '{print $2}')
valid=$(curl $url_izin | grep $IP | awk '{print $3}')
exp="${valid}"
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(((d1 - d2) / 86400))
DATE=$(date +'%Y-%m-%d')
datediff() {
d1=$(date -d "$1" +%s)
d2=$(date -d "$2" +%s)
echo -e "$COLOR1 $NC Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}
mai="datediff "$Exp" "$DATE""
Info="(${green}Active${NC})"
Error="(${RED}Expired${NC})"
today=`date -d "0 days" +"%Y-%m-%d"`
Exp1=$(curl $url_izin | grep $IP | awk '{print $4}')
if [[ $today < $Exp1 ]]; then
sts="${Info}"
else
sts="${Error}"
fi
domain=$(cat /root/domain)
mkdir -p /home/script/
DATEVPS=$(date +'%d-%m-%Y')
CHATID=""
KEY=""
URL="https://api.telegram.org/bot$KEY/sendMessage"
TIMEZONE=$(printf '%(%H:%M:%S)T')
TEXT="
<code>────────────────────</code>
<b>⛈️ NOTIFICATION INSTALL ⛈️</b>
<code>────────────────────</code>
<code>User    :</code><code>$username</code>
<code>Domain  :</code><code>$domain</code>
<code>ISP     :</code><code>$(cat /root/.isp)</code>
<code>CITY    :</code><code>$(cat /root/.city)</code>
<code>DATE    :</code><code>$DATEVPS</code>
<code>Time    :</code><code>$TIMEZONE</code>
<code>Expired :</code><code>$exp</code>
<code>────────────────────</code>
<i>Automatic Notifications From</i>
<i>RIFQY VPN </i>
<code>────────────────────</code>
"'&reply_markup={"inline_keyboard":[[{"text":" ⛈️ ʙᴜʏ ꜱᴄʀɪᴘᴛ ⛈️ ","url":"https://t.me/"}]]}' 

curl -s --max-time 10 -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}
function pasang_ssl() {
clear
print_install "Memasang SSL Certificate"
rm -rf /etc/xray/xray.key
rm -rf /etc/xray/xray.crt
domain=$(cat /root/domain)
STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
rm -rf /root/.acme.sh
mkdir /root/.acme.sh
systemctl stop $STOPWEBSERVER
systemctl stop nginx
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
chmod 777 /etc/xray/xray.key
print_success "SSL Certificate"
}
function make_folder_xray() {
rm -rf /etc/vmess/.vmess.db
rm -rf /etc/vless/.vless.db
rm -rf /etc/trojan/.trojan.db
rm -rf /etc/shadowsocks/.shadowsocks.db
rm -rf /etc/ssh/.ssh.db
rm -rf /etc/bot/.bot.db
mkdir -p /etc/{bot,xray,vmess,vless,trojan,shadowsocks,ssh,limit,user,noobzvpns}
mkdir -p /usr/bin/xray/
mkdir -p /var/log/xray/
mkdir -p /var/www/html
mkdir -p /etc/xray/{limit,user}
mkdir -p /etc/xray/limit/{vmess,vless,trojan,ssh}
mkdir -p /etc/xray/limit/vmess/ip
mkdir -p /etc/xray/limit/vless/ip
mkdir -p /etc/xray/limit/trojan/ip
mkdir -p /etc/xray/limit/ssh/ip
mkdir -p /etc/xray/limit/vmess/quota
mkdir -p /etc/xray/limit/vless/quota
mkdir -p /etc/xray/limit/trojan/quota
mkdir -p /etc/limit/{vmess,vless,trojan}
mkdir -p /etc/user/{ssh,vmess,vless,trojan}
touch /etc/noobzvpns/users.json
chmod +x /var/log/xray
touch /etc/xray/domain
touch /var/log/xray/{access.log,error.log}
touch /etc/vmess/.vmess.db
touch /etc/vless/.vless.db
touch /etc/trojan/.trojan.db
touch /etc/shadowsocks/.shadowsocks.db
touch /etc/ssh/.ssh.db
touch /etc/bot/.bot.db
echo "& plughin Account" >>/etc/vmess/.vmess.db
echo "& plughin Account" >>/etc/vless/.vless.db
echo "& plughin Account" >>/etc/trojan/.trojan.db
echo "& plughin Account" >>/etc/shadowsocks/.shadowsocks.db
echo "& plughin Account" >>/etc/ssh/.ssh.db
echo "& plughin Account" >>/etc/noonzvpns/.noobzvpns.db
}
#Instal Xray
function install_xray() {
clear
print_install "Core Xray 1.8.1 Latest Version"
domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
chown www-data.www-data $domainSock_dir

# / / Ambil Xray Core Version Terbaru
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version $latest_version
 
# // Ambil Config Server
wget -q -O /etc/xray/config.json "${REPO}xray/config.json" >/dev/null 2>&1
domain=$(cat /etc/xray/domain)
print_success "Core Xray 1.8.1 Latest Version"

# Settings UP Nginix Server
clear
curl -s ipinfo.io/city >>/etc/xray/city
curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp
print_install "Memasang Konfigurasi Packet"
wget -q -O /etc/haproxy/haproxy.cfg "${REPO}xray/haproxy.cfg" >/dev/null 2>&1
wget -q -O /etc/nginx/conf.d/xray.conf "${REPO}xray/xray.conf" >/dev/null 2>&1
sed -i "s/xxx/${domain}/g" /etc/haproxy/haproxy.cfg
sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
curl ${REPO}ssh/nginx.conf > /etc/nginx/nginx.conf

cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/xdxl.pem

# > Create Service
rm -rf /etc/systemd/system/xray.service.d
cat >/etc/systemd/system/xray.service <<EOF
Description=Xray Service
Documentation=https://github.com
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target

EOF
print_success "Konfigurasi Packet"
}
function udp_custom(){
clear
print_install "Memasang Service Udp Custom"
sleep 2
wget -q ${REPO}ssh/udp-custom.sh
chmod +x udp-custom.sh && ./udp-custom.sh
rm -fr udp-custom.sh
print_success "Service Udp Custom"
}
function noobzvpn() {
print_install "Memasang Service Noobzvpns"
wget -O /usr/sbin/noobzvpns "https://github.com/noobz-id/noobzvpns/raw/master/noobzvpns.x86_64"
chmod 777 /usr/sbin/noobzvpns

cat> /etc/noobzvpns/config.json <<-END
{
	"tcp_std": [
		8880
	],
	"tcp_ssl": [
		9443
	],
	"ssl_cert": "/etc/xray/xray.crt",
	"ssl_key": "/etc/xray/xray.key",
	"ssl_version": "AUTO",
	"conn_timeout": 60,
	"dns_resolver": "/etc/resolv.conf",
	"http_ok": "HTTP/1.1 101 Switching Protocols[crlf]Upgrade: websocket[crlf]Connection: Upgrade[crlf][crlf]"
}
END

cat> /etc/systemd/system/noobzvpns.service<<-END
[Unit]
Description=NoobzVpn-Server
Wants=network-online.target
After=network.target network-online.target

[Service]
CapabilityBoundingSet=CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_BIND_SERVICE
User=root
Type=simple
TimeoutStopSec=1
LimitNOFILE=infinity
ExecStart=/usr/sbin/noobzvpns --start-service

[Install]
WantedBy=multi-user.target
END

systemctl enable noobzvpns
systemctl start noobzvpns

print_success "Service Noobzvpn"
}

function ssh(){
clear
print_install "Memasang Password SSH"
wget -q -O /etc/pam.d/common-password "${REPO}ssh/password"
chmod +x /etc/pam.d/common-password

DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/altgr select The default for the keyboard layout"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/compose select No compose key"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/ctrl_alt_bksp boolean false"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layoutcode string de"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layout select English"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/modelcode string pc105"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/model select Generic 105-key (Intl) PC"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/optionscode string "
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/store_defaults_in_debconf_db boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/switch select No temporary switch"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/toggle select No toggling"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_layout boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_options boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_layout boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_options boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variantcode string "
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variant select English"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/xkb-keymap select "
cd
# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END
# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

#update
# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
print_success "Password SSH"
}

function udp_mini(){
clear
print_install "Memasang Service BadVPN"

# // Instaling Service Limit & Quota
wget -q -O fv-tunnel-user-limit.sh "${REPO}limit/fv-tunnel-user-limit.sh"
chmod +x fv-tunnel-user-limit.sh && ./fv-tunnel-user-limit.sh

# // Installing BadVPN
wget -q -O badvpn.sh "${REPO}badvpn/badvpn.sh"
chmod +x badvpn.sh && ./badvpn.sh
rm -rf badvpn.sh
print_success "Service BadVPN"
}
function ssh_slow(){
clear
print_install "Memasang modul SlowDNS Server"
wget -q -O /tmp/nameserver "${REPO}slowdns/nameserver" >/dev/null 2>&1
chmod +x /tmp/nameserver
bash /tmp/nameserver
rm -fr nameserver
print_success "SlowDNS"
}
function ins_SSHD(){
clear
print_install "Memasang SSHD"
wget -q -O /etc/ssh/sshd_config "${REPO}ws/sshd" >/dev/null 2>&1
chmod 700 /etc/ssh/sshd_config
/etc/init.d/ssh restart
systemctl restart ssh
/etc/init.d/ssh status
print_success "SSHD"
}
function ins_dropbear(){
clear
print_install "Menginstall Dropbear"
# // Installing Dropbear
apt-get install dropbear -y
wget -q -O /etc/default/dropbear "${REPO}ssh/dropbear.conf"
chmod +x /etc/default/dropbear
/etc/init.d/dropbear restart
print_success "Dropbear"
}
function ins_vnstat(){
clear
print_install "Menginstall Vnstat"
# setting vnstat
apt -y install vnstat > /dev/null 2>&1
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev > /dev/null 2>&1
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
/etc/init.d/vnstat status
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6
print_success "Vnstat"
}

function ins_openvpn(){
clear
print_install "Menginstall OpenVPN"
#OpenVPN
wget -q -O openvpn "${REPO}ssh/openvpn" &&  chmod +x openvpn && ./openvpn
/etc/init.d/openvpn restart
print_success "OpenVPN"
}

function ins_backup(){
clear
print_install "Memasang Backup Server"
#BackupOption
apt install rclone -y
printf "q\n" | rclone config
wget -q -O /root/.config/rclone/rclone.conf "${REPO}backup/rclone.conf"
#Install Wondershaper
cd /bin
git clone  https://github.com/magnific0/wondershaper.git
cd wondershaper
sudo make install
cd
rm -rf wondershaper
echo > /home/limit
apt install msmtp-mta ca-certificates bsd-mailx -y
cat<<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt

account default
host smtp.gmail.com
port 587
auth on
user oceantestdigital@gmail.com
from oceantestdigital@gmail.com
password jokerman77 
logfile ~/.msmtp.log
EOF
chown -R www-data:www-data /etc/msmtprc
wget -q -O /etc/ipserver "${REPO}ssh/ipserver" && bash /etc/ipserver
print_success "Backup Server"
}
function ins_swab(){
clear
print_install "Memasang Swap 2 G"
gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
curl -sL "$gotop_link" -o /tmp/gotop.deb
dpkg -i /tmp/gotop.deb >/dev/null 2>&1
    
# > Buat swap sebesar 2GB
    dd if=/dev/zero of=/swapfile bs=2048 count=2097148
    mkswap /swapfile
    chown root:root /swapfile
    chmod 0600 /swapfile >/dev/null 2>&1
    swapon /swapfile >/dev/null 2>&1
    sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab

    # > Singkronisasi jam
    chronyd -q 'server 0.id.pool.ntp.org iburst'
    chronyc sourcestats -v
    chronyc tracking -v
    
    wget -q -O bbr.sh "${REPO}bbr.sh" &&  chmod +x bbr.sh && ./bbr.sh
print_success "Swap 2 G"
}

function ins_Fail2ban(){
clear
print_install "Menginstall Fail2ban"
apt install fail2ban -y
/etc/init.d/fail2ban restart
/etc/init.d/fail2ban status

mkdir /usr/local/ddos

clear
# banner
echo "Banner /etc/fvstore.txt" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/fvstore.txt"@g' /etc/default/dropbear

# Ganti Banner
wget -q -O /etc/fvstore.txt "${REPO}ssh/issue.net"
print_success "Fail2ban"
}

function ins_epro(){
clear
print_install "Menginstall ePro WebSocket Proxy"
wget -q -O /usr/bin/ws "${REPO}ws/ws" >/dev/null 2>&1
wget -q -O /usr/bin/tun.conf "${REPO}ws/tun.conf" >/dev/null 2>&1
wget -q -O /etc/systemd/system/ws.service "${REPO}ws/ws.service"
chmod +x /etc/systemd/system/ws.service
chmod +x /usr/bin/ws
chmod 644 /usr/bin/tun.conf
systemctl disable ws
systemctl stop ws
systemctl enable ws
systemctl start ws
systemctl restart ws
wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" >/dev/null 2>&1
wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" >/dev/null 2>&1

iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# remove unnecessary files
cd
apt autoclean -y >/dev/null 2>&1
apt autoremove -y >/dev/null 2>&1
print_success "ePro WebSocket Proxy"
}

function menu(){
clear
rm -fr /usr/sbin/xdxl
mkdir -p /usr/sbin/xdxl
mkdir -p /usr/sbin/xdxl/style
wget -q -O menu.zip "${REPO}folder/menu.zip"
7z x -pCieBisaDecryptx1231 menu.zip >/dev/null 2>&1
rm -f menu.zip
chmod +x menu/*
mv menu/*.sh /usr/sbin/xdxl/style/
mv menu/* /usr/local/sbin
rm -fr menu
cd

mkdir -p /usr/sbin/.xd
cd /usr/sbin/.xd
wget -q -O xdxl.zip "${REPO}folder/xdxl.zip"
7z x -pCieBisaDecrypt0982 xdxl.zip >/dev/null 2>&1
unzip xdxl.zip >/dev/null 2>&1
rm -f xdxl.zip >/dev/null 2>&1
cd

}

function profile(){
clear
cat >/root/.profile <<EOF
# ~/.profile: executed by Bourne-compatible login shells.
if [ "$BASH" ]; then
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
fi
mesg n || true
welcome
EOF

# Auto delete user exp
cat >/etc/cron.d/xp_all <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 0 * * * root /usr/local/sbin/xp
END
chmod 644 /root/.profile

# Limit Ssh IP
cat >/etc/cron.d/lim-ssh-ip <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/1 * * * * root /usr/local/sbin/limit-ip-ssh
END

# Clear log
cat >/etc/cron.d/clear_log <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/15 * * * * root /usr/local/sbin/clog
END

# Clear Cache Ram
cat >/etc/cron.d/clear_cache <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/15 * * * * root /usr/local/sbin/ccache
END

# Auto reboot jam 3 pagi
cat >/etc/cron.d/daily_reboot <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 3 * * * root /sbin/reboot
END
echo "*/1 * * * * root echo -n > /var/log/nginx/access.log" >/etc/cron.d/log.nginx
echo "*/1 * * * * root echo -n > /var/log/xray/access.log" >>/etc/cron.d/log.xray
service cron restart
cat >/home/daily_reboot <<-END
3
END
cat >/etc/systemd/system/rc-local.service <<EOF
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
EOF

echo "/bin/false" >>/etc/shells
echo "/usr/sbin/nologin" >>/etc/shells
cat >/etc/rc.local <<EOF
#!/bin/sh -e
# rc.local
# By default this script does nothing.
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
systemctl restart netfilter-persistent
exit 0
EOF

chmod +x /etc/rc.local

AUTOREB=$(cat /home/daily_reboot)
SETT=11
if [ $AUTOREB -gt $SETT ]; then
TIME_DATE="PM"
else
TIME_DATE="AM"
fi
print_success "Menu Packet"
}
function enable_services(){
clear
print_install "Enable & Restart Service"
systemctl daemon-reload
systemctl start netfilter-persistent
systemctl enable --now nginx
systemctl enable --now xray
systemctl enable --now rc-local
systemctl enable --now dropbear
systemctl enable --now openvpn
systemctl enable --now cron
systemctl enable --now haproxy
systemctl enable --now netfilter-persistent
systemctl enable --now ws xdxl
systemctl enable --now fail2ban
history -c
echo "unset HISTFILE" >> /etc/profile
cd
rm -f /root/openvpn
rm -f /root/key.pem
rm -f /root/cert.pem
systemctl start netfilter-persistent
systemctl restart nginx
systemctl restart xray
systemctl restart cron
systemctl restart haproxy noobzvpns ws udp-custom
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/vnstat restart
systemctl restart haproxy
/etc/init.d/cron restart
print_install "Enable & Restart Successfully"
}
function instal(){
clear
first_setup
nginx_install
base_package
make_folder_xray
pasang_domain
notification
pasang_ssl
install_xray
udp_custom
noobzvpn
ssh
udp_mini
ssh_slow
ins_SSHD
ins_dropbear
ins_vnstat
ins_openvpn
ins_backup
ins_swab
ins_Fail2ban
ins_epro
menu
profile
enable_services
}
instal
history -c
rm -rf /root/menu
rm -rf /root/*.zip
rm -rf /root/*.sh
rm -rf /root/LICENSE
rm -rf /root/README.md
rm -rf /root/domain
secs_to_human "$(($(date +%s) - ${start}))"
rm -rf log-install.txt
#sudo hostnamectl set-hostname $username
wget -q ${REPO}fix/fix.sh
bash fix.sh
clear
echo -e "${tyblue} ┌──────────────────────────────────────────┐\033[0m"
echo -e "${tyblue} │${pth}            \033[0;36mPORT SERVICE INFO\033[0m             ${tyblue}|\033[0m"
echo -e "${tyblue} └──────────────────────────────────────────┘\033[0m"
lane_atas
echo -e "${tyblue}│${pth}       >>> Service & Port                    ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - Open SSH                : 22            ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - Dropbear                : 109, 143      ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - Noobzvpn TCP_STD        : 8880          ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - Noobzvpn TCP_SSL        : 9443          ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - SSH Websocket SSL       : 443           ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - SSH Websocket           : 80            ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - OpenVPN SSL             : 443           ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - OpenVPN Websocket SSL   : 443           ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - OpenVPN TCP             : 443, 1194     ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - OpenVPN UDP             : 2200          ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - Nginx Webserver         : 81            ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - Haproxy Loadbalancer    : 443, 80       ${tyblue}│${NC}"
#echo -e "${tyblue}│${pth}   - DNS Server              : 443, 53,      ${tyblue}│${NC}"
#echo -e "${tyblue}│${pth}   - DNS Client              : 443, 88       ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - OpenVPN Websocket SSL   : 443           ${tyblue}│${NC}"
#echo -e "${tyblue}│${pth}   - XRAY DNS (SLOWDNS)      : 443, 53       ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - XRAY Vmess TLS          : 443           ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - XRAY Vmess gRPC         : 443           ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - XRAY Vmess None TLS     : 80            ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - XRAY Vless TLS          : 443           ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - XRAY Vless gRPC         : 443           ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - XRAY Vless None TLS     : 80            ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - Trojan gRPC             : 443           ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - Trojan WS               : 443           ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - Shadowsocks WS          : 443           ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - BadVPN 1                : 7100          ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - BadVPN 2                : 7200          ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - BadVPN 3                : 7300          ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - BadVPN 4                : 7400          ${tyblue}│${NC}"
echo -e "${tyblue}│${pth}   - BadVPN 5                : 7500          ${tyblue}│${NC}"
#echo -e "${tyblue}│${pth}   - Proxy Squid             : 3128          ${tyblue}│${NC}"
lane_bawah
echo ""
#sudo hostnamectl set-hostname $username
echo -e  "${tyblue}┌──────────────────────────────────────────┐${NC}"
echo -e  "${tyblue}│              \033[1;37mTERIMA KASIH                ${tyblue}│${NC}"
echo -e  "${tyblue}│         \033[1;37mSUDAH MENGGUNAKAN SCRIPT         ${tyblue}│${NC}"
echo -e  "${tyblue}│                \033[1;37mDARI SAYA                 ${tyblue}│${NC}"
echo -e  "${tyblue}└──────────────────────────────────────────┘${NC}"
echo " "
echo -e "${green} Script Successfull Installed"
echo ""
read -p "$( echo -e "Press ${YELLOW}[ ${NC}${YELLOW}Enter${NC} ${YELLOW}]${NC} For Reboot") " Reboot
shutdown -r now