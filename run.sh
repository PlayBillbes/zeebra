#!/bin/bash
#relay login -k ce10e352-5cf9-4c4d-b0b7-a9834f7b74b1 -s k74jiYF1Kzo2
echo "ttyd serving at port 80 with username:pass as kali:kali"
./vss.sh bash
#nohup relay connect --name modsbots & ls
chmod +x /usr/local/bin/ttyd_linux
/usr/local/bin/ttyd_linux -p 7681 -c kali:kali bash 
