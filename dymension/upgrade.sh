#!/bin/bash
cat << 'EOF'
 
    )     )                                           
 ( /(  ( /(        (            *   )              )  
 )\()) )\())       )\ )   (   ` )  /(   (       ( /(  
((_)\ ((_)\   (   (()/(  ))\   ( )(_)) ))\  (   )\()) 
__((_) _((_)  )\   ((_))/((_) (_(_()) /((_) )\ ((_)\  
\ \/ /| \| | ((_)  _| |(_))   |_   _|(_))  ((_)| |(_) 
 >  < | .` |/ _ \/ _` |/ -_)    | |  / -_)/ _| | ' \  
/_/\_\|_|\_|\___/\__,_|\___|    |_|  \___|\__| |_||_| 
                                                                           
• Web: https://xnode.tech
• Github: https://github.com/techxnode
• Twitter: https://twitter.com/xnodeteam
EOF
sleep 1
echo "\e[1m\e[32mUpgrading dymension latest version... \e[0m"

# stop services
sudo systemctl stop da-light-client
sudo systemctl stop sequencer
sudo systemctl stop relayer

sudo systemctl disable da-light-client
sudo systemctl disable sequencer
sudo systemctl disable relayer

#Download roller lastest version
curl -L https://dymensionxyz.github.io/roller/install.sh | bash

# Create services
tee $HOME/da-light-client.service > /dev/null <<EOF
[Unit]
Description=da-light-client
After=network-online.target
[Service]
User=$USER
ExecStart=/usr/local/bin/roller da-light-client start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

tee $HOME/sequencer.service > /dev/null <<EOF
[Unit]
Description=sequencer
After=network-online.target
[Service]
User=$USER
ExecStart=/usr/local/bin/roller sequencer start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

tee $HOME/relayer.service > /dev/null <<EOF
[Unit]
Description=relayer
After=network-online.target
[Service]
User=$USER
ExecStart=/usr/local/bin/roller relayer start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable da-light-client
sudo systemctl enable sequencer
sudo systemctl enable relayer

sudo systemctl daemon-reload

# migrate roller lastest version
roller migrate


# start services
sudo systemctl start da-light-client 
sudo systemctl start sequencer
sudo systemctl start relayer

echo '========================= UPGRADE VERSION SUCCESSFUL ========================'
