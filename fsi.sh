#!/bin/bash

function banner {
    echo " ______   _ _             _____           "
    echo "|  ____| | (_)           / ____|          "
    echo "| |__ ___| |_ _ __   ___| (___   ___  ___ "
    echo "|  __/ _ \ | | '_ \ / _ \\___ \ / _ \/ __|"
    echo "| | |  __/ | | | | |  __/____) |  __/ (__ "
    echo "|_|  \___|_|_|_| |_|\___|_____/ \___|\___|"
    echo " _____           _        _ _           "
    echo "|_   _|         | |      | | |          "
    echo "  | |  _ __  ___| |_ __ _| | | ___ _ __ "
    echo "  | | | '_ \/ __| __/ _\` | | |/ _ \ '__|"
    echo " _| |_| | | \__ \ || (_| | | |  __/ |   "
    echo "|_____|_| |_|___/\__\__,_|_|_|\___|_|   "
    echo ""
}

function usage {
    echo "Usage: "
    echo -e " ./fsi.sh --install\t Download and install tools"
    echo -e " ./fsi.sh --update\t Update existing tools"
}

banner

if ! type git &> /dev/null; then
    echo "Install git to allow downloading stuff. "
elif [ -z $1 ]; then
    echo "Missing argument";
    usage
elif [ $1 == "--install" ]; then

    echo "[+] Creating directory $HOME/tools/"
    mkdir $HOME/tools/
    cd $HOME/tools/

    echo "# Feline Sec Installer's aliases" >> $HOME/.bashrc

    echo " [+] Installing SQLMap"
    git clone https://github.com/sqlmapproject/sqlmap.git
    echo 'alias sqlmap="python2 $HOME/tools/sqlmap/sqlmap.py"' >> $HOME/.bashrc

    echo " [+] Installing ExploitDB"
    git clone https://github.com/offensive-security/exploitdb.git
    echo 'alias searcsploit="$HOME/tools/exploitdb/searchsploit"' >> $HOME/.bashrc

    echo " [+] Installing Dirsearch"
    git clone https://github.com/maurosoria/dirsearch.git
    echo 'alias dirsearch="python3 $HOME/tools/dirsearch/dirsearch.py"' >> $HOME/.bashrc

    echo " [+] Installing LinEnum"
    git clone https://github.com/rebootuser/LinEnum.git
    # No need to add to ~/.bashrc

    echo " [+] Installing SecList"
    git clone https://github.com/danielmiessler/SecLists.git
    # No need to add to ~/.bashrc

    echo " [+] Installing RemoteShellGenerator"
    git clone https://github.com/mthbernardes/rsg.git
    echo 'alias rsg="python3 $HOME/tools/rsg/rsg"' >> $HOME/.bashrc

    echo " [+] Installing Wafw00f"
    git clone https://github.com/EnableSecurity/wafw00f
    cd wafw00f && python3 setup.py install
    cd ..
    # No need to add to ~/.bashrc

    cd -

elif [ $1 == "--update" ]; then
    echo " [+] Updating packages"
    cd $HOME/tests/
    find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \; 2>/dev/null
    cd -
else
    usage
fi
