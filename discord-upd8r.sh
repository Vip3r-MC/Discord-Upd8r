#!/bin/bash


# Color variables
yellow='\033[0;33m'       # Yellow

# Bold
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BBlue='\033[1;34m'        # Blue
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Bold High Intensity
BIWhite='\033[1;97m'      # White

# Background
Bg_Red='\033[41m'         # Red

#clear
clear='\033[0m'

clear

echo -e "${BCyan}=============${clear}"
echo -e "${BWhite}╭━━╮╱╱╱╱╱╱╭╮${clear}"
echo -e "${BWhite}╰╮╮┣━━┳┳┳━┫┃${clear}"
echo -e "${BWhite}╭┻╯┣━━┫┃┃╋┃┃${clear}"
echo -e "${BWhite}╰━━╯╱╱╰━┫╭╋┫${clear}"
echo -e "${BWhite}╱╱╱╱╱╱╱╱╰╯╰╯${clear}"
echo -e "${BCyan}=============${clear}"
echo -e "${yellow}Credits: Vip3r${clear}"
echo ""
echo ""




echo -e "${BCyan}[!]Generating temporary directory...${clear}"
echo -e "${BCyan}---------------------------------${clear}"
DIR=$(mktemp -d /tmp/discord-XXXXXXXX)
echo -e "${BGreen}[-] Temporary directory created: ${DIR}${clear}"
echo ""


function clean_up {
	echo ""
    echo -e "${BCyan}[!]Cleaning up temporary files...${clear}"
    echo -e "${BCyan}---------------------------------${clear}"
    rm -rf /tmp/${DIR}
    echo -e "${BGreen}[-]Temporary files removed!${clear}"
    exit 1
}

# Define trap to execute clean_up function on keyboard interrupt
trap clean_up SIGINT


echo -e "${BCyan}[!]Checking for previous versions...${clear}"
echo -e "${BCyan}---------------------------------${clear}"
FILE=${DIR}/discord.deb
if [ -f "$FILE" ]; then
	echo -e "${BRed}[-] $FILE exists, removing...${clear}"
	rm -v $FILE
	echo -e "${BGreen}[-] $FILE removed!${clear}"
fi


echo""
echo -e "${BCyan}[!]Retrieving latest update...${clear}"
echo -e "${BCyan}---------------------------------${clear}"
wget https://discordapp.com/api/download?platform=linux -O ${DIR}/discord.deb

echo -e "${BCyan}[!]Attempting install...${clear}"
echo -e "${BCyan}---------------------------------${clear}"
if sudo dpkg -i ${DIR}/discord.deb; then
	echo -e "${BGreen}[-] Update complete!${clear}"

	clean_up
else
	echo -e "${Bg_Red}${BIWhite}[!] Update failed!${clear}"
	echo -e "${BBlue}[!] You can attempt to run the following command manually: ${clear} ${yellow}\`sudo dpkg -i ${DIR}/discord.deb\`${clear}"
fi


