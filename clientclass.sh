#!/bin/bash
PORT="2022"

echo "Drágon Magia Abuelita Miedo 2022"

echo " 1. ENVIO DE CABECERA"

echo "DMAM" | nc 127.0.0.1 $PORT

DATA=`nc -l $PORT`

if [ "$DATA" != "OK_HEADER" ]
then
	echo "ERROR 1: Header incorrecto"
	exit 1
fi
