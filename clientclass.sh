#!/bin/bash

if [ "$1" == "" ]
then
	echo "Debes indicar la dirección IP del servidor."
	echo "Ejemplo: "
	echo -e "\t$0 127.0.0.1"
	exit 1
fi

IP_SERVER=$1

PORT="2022"
IP=`ip a | grep "scope global" | xargs | cut -d " " -f 2 | cut -d "/" -f 1`

echo "Cliente Drágon Magia Abuelita Miedo 2022"
echo "1. ENVIO DE CABECERA"

echo "DMAM $IP" | nc $IP_SERVER $PORT

DATA=`nc -l $PORT`

if [ "$DATA" != "OK_HEADER" ]
then
	echo "ERROR 1: Header incorrecto"
	exit 1
fi
echo "HEADER enviado con éxito!"



echo "3. ENVIO DE PREFIJOS"

FILE_NAME="dragon.txt"

echo "FILE_NAME $FILE_NAME" | nc $IP_SERVER $PORT

DATA=`nc -l $PORT`

if [ "$DATA" != "OK_FILE_NAME" ]
then
	echo "ERROR 2: Prefijo incorrecto"
	exit 2
fi
echo "PREFIJO enviado con éxito!"


echo "5. ENVIO DE CONTENIDO"
CONTENIDO=`cat client/$FILE_NAME`
echo "$CONTENIDO" | nc $IP_SERVER $PORT

DATA=`nc -l $PORT`

if [ "$DATA" != "OK_CONTENIDO" ]
then
	echo "ERROR 3: Contenido vacío"
	exit 3
fi
echo "CONTENIDO enviado con éxito!"

