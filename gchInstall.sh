#!/bin/bash

#help
case "$@" in
	-h|--help)
	echo "
 "$0", um aplicativo para ajudar a instalar a Máquina Virtual e o Grand Chase History de forma fácil.
 Uso: "$0" /caminho/do/instalador

	Exemplo:
  "$0" /home/USER/Download/Setup.exe

  -h,   --help                         Emite esta ajuda

 Se omitido, o instalador apenas criará a máquina virtual.
 Para que seja feita a instalação do jogo, deve usar o aplicativo gcHistory com o parâmetro para instalar.
 Para saber mais, consulte o Help do gcHistory!
"
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
	echo "Modo somente criar/atualizar a máquina virtual..."
	read -t 5
 fi
  else
	RLSET=`readlink -m "$@"`

  if [ -e "$RLSET" ];then
	clear
     else
	echo "O arquivo especificado não existe!"
	exit 0
  fi
	
fi
#File

##xterm
if ( whereis xterm | grep bin ) >> /dev/null ;then
##cabextract
if ( whereis cabextract | grep bin ) >> /dev/null ;then
##git
if ( whereis git | grep bin ) >> /dev/null ;then
	echo "Iniciando configuração dos arquivos..."
	read -t 3
  else
	echo "Deve ter o \"git\" instalado no sistema!"
	read -t 5
	exit 0
fi
##git
  else
	echo "Deve ter o \"cabextract\" instalado no sistema!"
	read -t 5
	exit 0
fi
##cabextract
  else
	echo "Deve ter o \"xterm\" instalado no sistema!"
	read -t 5
	exit 0
fi
##xterm

### DIRINST
clear
echo -e " Digite o local onde quer instalar o Grand Chase History:"
echo -e " Exemplo: /home/USER/jogo"
echo -e "\n Se omitido, o jogo será instalado em \"$HOME/.gch\".\n"

read -p " Local do jogo [ ENTER para o padrão ] : " DIRGCINS

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

WINDIR="$PWDIR/bin"
WINLIB="$PWDIR/lib"
GCPATH="$PWDIR/gchmod"
GCDIR="$GCPATH/drive_c/Program Files/Grand Chase History"
GCEXEC="$GCDIR/GrandChase.exe"

### Install
if [ -e "$PWDIR/gcHistory" ];then
	git pull https://github.com/elppans/wine-staging-1.9.15_IndexVertexBlending-1.9.11.i686
	cd "$PWDIR/gcmd"
	git pull https://github.com/elppans/gcHistory
	cd -
	cp -rf "$PWDIR/gcmd/gcHistory" "$PWDIR"
	cp -rf "$PWDIR/gcmd/ico" "$PWDIR"
	#cp -rf "$PWDIR/gcmd/NewOption.dat" "$GCDIR"
	git fetch origin
	git reset --hard origin/master
   else
	git clone https://github.com/elppans/wine-staging-1.9.15_IndexVertexBlending-1.9.11.i686 $PWDIR
 if [ -e "$PWDIR/bin/wine" ];then
	echo "$(wine --version) OK!"
    else
	echo "Falha no Download do Wine!"
	exit 0
 fi
	mkdir -p "$PWDIR/gcmd"
	git clone https://github.com/elppans/gcHistory "$PWDIR/gcmd"
	cp -rf "$PWDIR/gcmd/gcHistory" "$PWDIR"
	cp -rf "$PWDIR/gcmd/ico" "$PWDIR"
	#cp -rf "$PWDIR/gcmd/NewOption.dat" "$GCDIR"
	git fetch origin
	git reset --hard origin/master

fi

if [ -d "$GCPATH" ];then
	echo "gchmod OK!"
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
	echo "O executável GrandChase não existe..."
	echo "Para reinstalar, faça o comando \"gcHistory --reinstall /CAMINHO/setup.exe\""
	exit 0
  fi
#EXEC
   else
	echo "A instalação do Grand Chase History foi cancelada..."

	echo "Para reinstalar, execute novamente o instalador"
	echo "Ou faça o comando \"gcHistory --install /CAMINHO/setup.exe\""
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
	echo "O executável GrandChase não existe..."
	echo "Para reinstalar, faça o comando \"gcHistory --reinstall /CAMINHO/setup.exe\""
	exit 0
  fi
#EXEC
   else
	echo "A instalação do Grand Chase History foi cancelada..."

	echo "Para reinstalar, execute novamente o instalador"
	echo "Ou faça o comando \"gcHistory --install /CAMINHO/setup.exe\""
	exit 0
fi
#DIR
fi
     else
	echo "Erro, o comando \"gcHistory\" não existe"
	exit 0
  fi 
fi

#PATH
   if ( cat "$HOME/.bashrc" | grep -i "PATH=\$PATH:$PWDIR" );then
	echo "Path OK!"
      else
	echo "PATH=\$PATH:$PWDIR" >> "$HOME/.bashrc"
   fi
#PATH

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
	echo "Diretório inválido!"
	exit 0
fi
