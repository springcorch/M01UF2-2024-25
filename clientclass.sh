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

echo "3. ENVIO DE PREFIJOS"
FILE_NAME="dragon.txt"
echo "FILE_NAME $FILE_NAME" | nc localhost $PORT
DATA=`nc -l $PORT`

if [ "$DATA" != "OK_FILE_NAME" ]
then
	echo "ERROR 2: Prefijo incorrecto"
	exit 2
fi

echo "5. Enviando contenido"
CONTENIDO=`cat client/$FILE_NAME`
echo "$CONTENIDO" | nc localhost $PORT

