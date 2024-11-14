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
echo "FILE_NAME dragon.txt" | nc localhost $PORT
DATA=`nc -l $PORT`

if [ "$DATA" != "OK_FILE_NAME" ]
then
	echo "ERROR 2: Prefijo incorrecto"
	exit 2
fi

echo "El protocolo ha sido un exito!"
