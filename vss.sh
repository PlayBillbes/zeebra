#!/bin/bash

RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
PLAIN='\033[0m'

red() {
    echo -e "\033[31m\033[01m$1\033[0m"
}

green() {
    echo -e "\033[32m\033[01m$1\033[0m"
}

yellow() {
    echo -e "\033[33m\033[01m$1\033[0m"
}

clear


yellow "使用前请注意："
red "1. 我已知悉本项目有可能触发 Deepnote 封号机制"
red "2. 我不保证脚本其搭建节点的稳定性"
#read -rp "是否安装脚本？ [Y/N]：" yesno
yesno = "Y"
if [[ yesno =~ "Y"|"y" ]]; then
    rm -f web config.json
    yellow "开始安装..."
    wget -O temp.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
    unzip temp.zip
    rm -f temp.zip
    mv v2ray web
    read -rp "请设置UUID（如无设置则使用脚本默认的）：" uuid
    if [[ -z $uuid ]]; then
        uuid="8d4a8f5e-c2f7-4c1b-b8c0-f8f5a9b6c384"
    fi
    rm -f config.json
    cat << EOF > config.json
{
    "log": {
        "loglevel": "warning"
    },
    "routing": {
        "domainStrategy": "AsIs",
        "rules": [
            {
                "type": "field",
                "ip": [
                    "geoip:private"
                ],
                "outboundTag": "block"
            }
        ]
    },
    "inbounds": [
        {
            "listen": "127.0.0.1",
            "port": 7681,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$uuid"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws",
                "security": "none"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        },
        {
            "protocol": "blackhole",
            "tag": "block"
        }
    ]
}
EOF
    nohup ./web run &>/dev/null &
    green "Deepnote v2ray 已安装完成！"
    yellow "请认真阅读项目博客说明文档，配置出站链接！"
    yellow "别忘记给项目点一个免费的Star！"
    echo ""
    yellow "更多项目，请关注：小御坂的破站"
else
    red "已取消安装，脚本退出！"
    exit 1
fi
