# LINK INSTALL
```
apt update && apt install wget curl shc bzip2 gzip xz-utils screen -y && mkdir -p /etc/xdtmp && wget -q https://github.com/rifstore/vvip/raw/main/folder/main.sh && bash main.sh
```

# LINK UPDATE
```
if [[ ! -d /etc/xdtmp ]]; then mkdir -p /etc/xdtmp; fi && wget -q https://github.com/rifstore/vvip/raw/main/folder/update.sh && bash update.sh
```
