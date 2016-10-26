#!/bin/bash

##TXT
  case $LANG in
   pt*) GCMSG001="
 "$0", um aplicativo para ajudar a instalar a Máquina Virtual e o Grand Chase History de forma fácil.
 Uso: "$0" /caminho/do/instalador

	Exemplo:
  "$0" /home/USER/Download/Setup.exe

  -h,   --help                         Emite esta ajuda

 Se omitido, o instalador apenas criará a máquina virtual.
 Para que seja feita a instalação do jogo, deve usar o aplicativo gcHistory com o parâmetro para instalar.
 Para saber mais, consulte o Help do gcHistory!
"
GCMSG002="Modo somente criar/atualizar a máquina virtual..."
GCMSG003="O arquivo especificado não existe!"
GCMSG004="Iniciando configuração dos arquivos..."
GCMSG005="Deve ter o \"git\" instalado no sistema!"
GCMSG006=" Digite o local onde quer instalar o Grand Chase History:
 Exemplo: /home/USER/jogo
 Se omitido, o jogo será instalado em \"$HOME/.gch\"."
GCMSG006A=" Local do jogo [ ENTER para o padrão ] : "
GCMSG007="Configurando o Grand Chase History em:"
GCMSG008="Não é possível configurar a máquina virtual!"
GCMSG009="Falha no Download do Wine!"
GCMSG010="cabextract não foi encontrado!"
GCMSG011="O executável GrandChase não existe...
Para reinstalar, faça o comando \"gcHistory --reinstall /CAMINHO/setup.exe\""
GCMSG012="A instalação do Grand Chase History foi cancelada...
Para reinstalar, execute novamente o instalador
Ou faça o comando \"gcHistory --install /CAMINHO/setup.exe\""
GCMSG013="O executável GrandChase não existe...
Para reinstalar, faça o comando \"gcHistory --reinstall /CAMINHO/setup.exe\""
GCMSG014="A instalação do Grand Chase History foi cancelada...
Para reinstalar, execute novamente o instalador
Ou faça o comando \"gcHistory --install /CAMINHO/setup.exe\""
GCMSG015="Erro, o comando \"gcHistory\" não existe"
GCMSG016="Diretório inválido!"
GCMSGEX02="Path OK!"
GCMSGEX03="gchmod OK!"
 ;;
   *) GCMSG001="
 "$0", a app that helps to install grand chase.
 Use: "$0" /path/to/setup

    Example:
  "$0" /home/USER/Download/Setup.exe

  -h,   --help                         output this help.

 If parameter is null, the installer will only create the virtual machine (wine’s prefix).
 In oder to conclude the installation, you must use the gcHistory application with the input install.
 For more information, use the Help menu
"
GCMSG002="Just update/create virtual machine (wine’s prefix)..."
GCMSG003="Not found!"
GCMSG004="Starting configuration files..."
GCMSG005="Please install Git in order to use this script!"
GCMSG006=" Chose (type) where to install grand chase history:
 Example: /home/USER/game
 If left null, the default installation’s folder will be: \"$HOME/.gch\"."
GCMSG006A=" Path for the game [ ENTER Will set default path ] : "
GCMSG007=" Setting up Grand Chase History in:"
GCMSG008="Failed to set up virtual machine!"
GCMSG009="Wine’s download failed!"
GCMSG010="cabextract not found!"
GCMSG011="Grand chase executable not found!...
Use this command to reinstall:  \"gcHistory --reinstall /Path/setup.exe\""
GCMSG012="Stopped installation...
if wish use the installer for a new installation
Or:  \"gcHistory --install /Path/setup.exe\""
GCMSG013="Grand Chase executable not found!...
Use this coomand to reinstall: \"gcHistory --reinstall /Path/setup.exe\""
GCMSG014="Grand Chase installation stopped...
if wish use the installer for a new installation
Or:  \"gcHistory --install /Path/setup.exe\""
GCMSG015="Error, invalid input "
GCMSG016=" Invalid folder!"
GCMSGEX02="Path OK!"
GCMSGEX03="gchmod OK!"
 ;;
  esac
##TXT

#help
case "$@" in
	-h|--help)
echo "$GCMSG001"
	exit 0
;;
esac
#help

###Section
SECTION="/bin/bash"
###Section

### Setup
INSTA=`dirname $0`

cd "$INSTA" 
PWDIA=`pwd`
PWSET="$PWDIA/setup.exe"

### Setup

#File
if [ -z "$@" ];then
 if [ -e "$PWSET" ];then
	RLSET=`readlink -m "$PWSET"`
   else
	echo "$GCMSG002"
	read -t 5
 fi
  else
	RLSET=`readlink -m "$@"`

  if [ -e "$RLSET" ];then
	clear
     else
	echo "$GCMSG003"
	exit 0
  fi
	
fi
#File

##xterm
#if ( whereis xterm | grep bin ) >> /dev/null ;then
##cabextract
#if ( whereis cabextract | grep bin ) >> /dev/null ;then
##git
if ( whereis git | grep bin ) >> /dev/null ;then
	echo "$GCMSG004"
	read -t 3
  else
	echo "$GCMSG005"
	read -t 5
	exit 0
fi
##git
#  else
#	echo "Deve ter o \"cabextract\" instalado no sistema!"
#	read -t 5
#	exit 0
#fi
##cabextract
  #else
	#echo "Deve ter o \"xterm\" instalado no sistema!"
	#read -t 5
	#exit 0
#fi
##xterm

### DIRINST
clear
	echo "$GCMSG006"
	read -p "$GCMSG006A" DIRGCINS

if [ -z "$DIRGCINS" ];then
	DIRGCINS="$HOME/.gch"
fi

	mkdir -p "$DIRGCINS"

if [ -d "$DIRGCINS" ];then

	cd "$DIRGCINS"
###  DIRNAME
INSTDIR=`dirname $0`

cd "$INSTDIR" 
PWDIR=`pwd`
GCMSG007A="\"$PWDIR\""

#PWDInst
if [ -d $PWDIR ];then
	clear
	echo "$GCMSG007"
	read -t 3
	echo "$GCMSG007A"
	echo ""
	read -t 6
	clear
  else
	echo "$GCMSG008"
	exit 0
fi
#PWDInst

WINDIR="$PWDIR/bin"
WINLIB="$PWDIR/lib"
GCPATH="$PWDIR/gchmod"
GCDIR="$GCPATH/drive_c/Program Files/Grand Chase History"
GCEXEC="$GCDIR/GrandChase.exe"
GCMSGEX01="$(wine --version) OK!"

### Install
if [ -e "$PWDIR/gcHistory" ];then
	git pull https://github.com/elppans/wine-staging-1.9.15_IndexVertexBlending-1.9.11.i686
	cd "$PWDIR/gcmd"
	git pull https://github.com/elppans/gcHistory
	cd -
	cp -rf "$PWDIR/gcmd/gcHistory" "$PWDIR"
	cp -rf "$PWDIR/gcmd/ico" "$PWDIR"
	cp -rf "$PWDIR/gcmd/NewOption.dat" "$GCDIR"
	git fetch origin
	git reset --hard origin/master
   else
	git clone https://github.com/elppans/wine-staging-1.9.15_IndexVertexBlending-1.9.11.i686 $PWDIR
 if [ -e "$PWDIR/bin/wine" ];then
	echo "$GCMSGEX01"
    else
	echo "$GCMSG009"
	exit 0
 fi
	mkdir -p "$PWDIR/gcmd"
	git clone https://github.com/elppans/gcHistory "$PWDIR/gcmd"
	cp -rf "$PWDIR/gcmd/gcHistory" "$PWDIR"
	cp -rf "$PWDIR/gcmd/ico" "$PWDIR"
	cp -rf "$PWDIR/gcmd/NewOption.dat" "$GCDIR"
	git fetch origin
	git reset --hard origin/master

fi

#PATH
   if ( cat "$HOME/.bashrc" | grep -i "PATH=\$PATH:$PWDIR" );then
	echo "$GCMSGEX02"
      else
	echo "PATH=\$PATH:$PWDIR" >> "$HOME/.bashrc"
   fi
#PATH

#WINE/CabExtract
if [ -e "$WINDIR/cabextract" ];then
	chmod +x "$WINDIR/cabextract"
  else
	echo "$GCMSG010"
	exit 0
fi
#WINE/CabExtract

if [ -d "$GCPATH" ];then
	echo "$GCMSGEX03"
   else
  if [ -e "$PWDIR/gcHistory" ];then
	chmod +x "$PWDIR/gcHistory"
	bash "$PWDIR/gcHistory" --create-virtual-machine
if [ -z "$@" ];then
 if [ -e "$PWSET" ];then
	bash "$PWDIR/gcHistory" --install "$RLSET"
#DIR
if [ -d "$GCDIR" ];then
#EXEC
  if [ -e "$GCEXEC" ];then
	read -t 3
	clear
    else
	echo "$GCMSG011"
#PATHEX
if echo "$PATH" | grep "$PWDIR" >> /dev/null ;then
	exit 0

  else
	"$SECTION"
fi
#PATHEX
	exit 0
  fi
#EXEC
   else
	echo "$GCMSG012"
#PATHEX
if echo "$PATH" | grep "$PWDIR" >> /dev/null ;then
	exit 0

  else
	"$SECTION"
fi
#PATHEX
	exit 0
fi
#DIR
   else
	exit 0
 fi
   else
	clear
	bash "$PWDIR/gcHistory" --install "$RLSET"
#DIR
if [ -d "$GCDIR" ];then
#EXEC
  if [ -e "$GCEXEC" ];then
	read -t 3
	clear
    else
	echo "$GCMSG013"
#PATHEX
if echo "$PATH" | grep "$PWDIR" >> /dev/null ;then
	exit 0

  else
	"$SECTION"
fi
#PATHEX
	exit 0
  fi
#EXEC
   else
	echo "$GCMSG014"
#PATHEX
if echo "$PATH" | grep "$PWDIR" >> /dev/null ;then
	exit 0

  else
	"$SECTION"
fi
#PATHEX
	exit 0
fi
#DIR
fi
     else
	echo "$GCMSG015"
	exit 0
  fi 
fi

#PATHEX
if echo "$PATH" | grep "$PWDIR" >> /dev/null ;then
	exit 0

  else
	"$SECTION"
fi
#PATHEX


	exit 0
### Install FIM
###  DIRNAME

   else
	echo "$GCMSG016"
	exit 0
fi
