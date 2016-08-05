#!/bin/bash

#help
case $@ in
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

### DIRINST
clear
echo -e " Digite o local onde quer instalar o Grand Chase History:"
echo -e " Se omitido, o jogo será instalado em /home/USER/.gch"
echo -e " Exemplo: /home/USER/jogo"
read DIRGCINS

if [ -z $DIRGCINS ];then
	DIRGCINS="$HOME/.gch"
fi

	mkdir -p "$DIRGCINS"

if [ -d "$DIRGCINS" ];then

	cd "$DIRGCINS"
###  DIRNAME
INSTDIR=`dirname $0`

cd $INSTDIR 
PWDIR=`pwd`

WINDIR="$PWDIR/bin"
WINLIB="$PWDIR/lib"
GCPATH="$PWDIR/gchmod"

### Install
if [ -e "$PWDIR/gcHistory" ];then
	git pull https://github.com/elppans/wine-staging-1.9.15_IndexVertexBlending-1.9.11.i686
	cd $PWDIR/gcmd
	git pull https://github.com/elppans/gcHistory
	cd -
	cp -rf $PWDIR/gcmd/gcHistory $PWDIR
	cp -rf $PWDIR/gcmd/ico $PWDIR
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
	mkdir -p $PWDIR/gcmd
	git clone https://github.com/elppans/gcHistory $PWDIR/gcmd
	cp -rf $PWDIR/gcmd/gcHistory $PWDIR
	cp -rf $PWDIR/gcmd/ico $PWDIR
	git fetch origin
	git reset --hard origin/master
	echo "PATH=\$PATH:$PWDIR" >> $HOME/.bashrc
fi

if [ -d "$GCPATH" ];then
	echo "gchmod OK!"
   else
  if [ -e "$PWDIR/gcHistory" ];then
	chmod +x $PWDIR/gcHistory
	bash "$PWDIR/gcHistory" --create-virtual-machine
if [ -z "$@" ];then
	exit 0
   else
	clear
	bash "$PWDIR/gcHistory" --install "$@"
fi
     else
	echo "Erro, o comando \"gcHistory\" não existe"
	exit 0
  fi 
fi




	exit 0
### Install FIM
###  DIRNAME

   else
	echo "Diretório inválido!"
	exit 0
fi

