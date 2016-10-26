#!/bin/bash


 case $LANG in
   pt*) xterm -T "Grand Chase History" -e 'bash gchInstall.sh ; read -p "Aperte ENTER para fechar esta janela!"' ;;
   *) xterm -T "Grand Chase History" -e 'bash gchInstall.sh ; read -p "Press ENTER to close this window!"' ;;
 esac

