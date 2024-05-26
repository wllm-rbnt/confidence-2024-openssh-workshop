#!/bin/bash

if [[ -t 1 ]]; then
    violet="\033[35m"
    red="\033[31m"
    green="\033[32m"
    blue="\033[36m"
    nocolor="\033[0m"
else
    violet=""
    red=""
    green=""
    blue=""
    nocolor=""
fi

sudo docker-compose build
sudo docker-compose up -d

echo
echo "################################"
echo "################################"
./isolate_private_bridge.sh
echo
echo "################################"
echo "################################"
lab_server_pub=$(sudo docker network inspect docker_public_net | grep -A 3 docker-lab-server- | grep IPv4Address | cut -d \" -f 4 | cut -d / -f 1)
lab_server_priv=$(sudo docker network inspect docker_private_net | grep -A 3 docker-lab-server- | grep IPv4Address | cut -d \" -f 4 | cut -d / -f 1)
internal_machine_priv=$(sudo docker network inspect docker_private_net | grep -A 3 docker-internal-machine- | grep IPv4Address | cut -d \" -f 4 | cut -d / -f 1)
echo -e "${violet}lab-server${nocolor} public IP address: ${blue}${lab_server_pub}${nocolor}"
echo -e "${violet}lab-server${nocolor} private IP address: ${green}${lab_server_priv}${nocolor}"
echo -e "${violet}internal-machine${nocolor} private IP address: ${red}${internal_machine_priv}${nocolor}"

echo -e "    ┌─────────────────────┐          ┌──────────────────────────────────────────────┐"
echo -e "    │ CONFidence 2024     │          │ Lab network                                  │"
echo -e "    │                     │          │                                              │"
echo -e "    │ ┌───────────────┐   │          │ ┌────────────┐          ┌──────────────────┐ │"
echo -e "    │ │ local machine │   │<-------->│ │ ${violet}lab-server${nocolor} │          │ ${violet}internal-machine${nocolor} │ │"
echo -e "    │ └───────────────┘   │'Internet'│ └────────────┘          └──────────────────┘ │"
echo -e "    │                     │          │  Pub ${blue}${lab_server_pub}${nocolor}                              │"
echo -e "    │                     │          │  Priv ${green}${lab_server_priv}${nocolor} <-LAN-> Priv ${red}${internal_machine_priv}${nocolor}     │"
echo -e "    └─────────────────────┘          └──────────────────────────────────────────────┘"

