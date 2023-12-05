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
read -p "Enter node moniker: " UNIOND_NODE_NAME 
sudo mkdir ~/.union
sleep 1
echo "\e[1m\e[32mUpdating packages and dependencies... \e[0m"
sleep 1
#update apt
sudo apt update && sudo apt upgrade -y
sudo apt install wget jq -y
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg &&
sudo chmod a+r /etc/apt/keyrings/docker.gpg &&
# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get -y update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# setup envs
export UNIOND_VERSION='v0.14.0'
export UNIOND_CHAIN_ID='union-testnet-4'

# set alias
alias uniond='docker run -v ~/.union:/.union --network host -it ghcr.io/unionlabs/uniond:$UNIOND_VERSION --home /.union'

# init config
uniond init ${UNIOND_NODE_NAME} "bn254" --chain-id ${UNIOND_CHAIN_ID}

# download files and grant access
curl https://rpc.cryptware.io/genesis | jq '.result.genesis' > ~/.union/config/genesis.json
wget -O docker-compose-union.yml "https://raw.githubusercontent.com/techxnode/guide-nodes/main/union/docker-compose.yml"
chmod 744 ./docker-compose-union.yml

# config options
config_file=~/.union/config/config.toml
# custom seed
old_seeds='seeds = ""'
new_seeds='seeds = "a069a341154484298156a56ace42b6e6a71e7b9d@blazingbit.io:27656,8a07752a234bb16471dbb577180de7805ba6b5d9@union.testnet.4.seed.poisonphang.com:26656"'

sed -i "s|$old_seeds|$new_seeds|g" $config_file

# run node service
docker compose -f ./docker-compose-union.yml up -d

echo '========================= NODE INSTALLATION SUCCESSFUL ========================'
echo '• Check logs:        \e[1m\e[33msudo docker logs -f --tail 100 union-node'
echo '==============================================================================='
