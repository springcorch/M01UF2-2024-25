#!/bin/bash
PORT="2022"

echo "Drágon Magia Abuelita Miedo 2022"
echo "1. ENVIO DE CABECERA"

echo "DMAM" | nc 127.0.0.1 $PORT

DATA=`nc -l $PORT`

if [ "$DATA" != "OK_HEADER" ]
then
	echo "ERROR 1: Header incorrecto"
	exit 1
fi
echo "HEADER enviado con éxito!"



echo "3. ENVIO DE PREFIJOS"

FILE_NAME="dragon.txt"

echo "FILE_NAME $FILE_NAME" | nc localhost $PORT

DATA=`nc -l $PORT`

if [ "$DATA" != "OK_FILE_NAME" ]
then
	echo "ERROR 2: Prefijo incorrecto"
	exit 2
fi
echo "PREFIJO enviado con éxito!"


echo "5. ENVIO DE CONTENIDO"
CONTENIDO=`cat client/$FILE_NAME`
echo "$CONTENIDO" | nc localhost $PORT

DATA=`nc -l $PORT`

if [ "$DATA" != "OK_CONTENIDO" ]
then
	echo "ERROR 3: Contenido vacío"
	exit 3
fi
echo "CONTENIDO enviado con éxito!"



