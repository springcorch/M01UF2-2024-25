#!/bin/bash
PORT="2022"

echo "Servidor de Dragón Magia Abuelita Miedo 2022"
echo "0. ESCUCHANDO"
DATA=`nc -l $PORT`

if [ "$DATA" != "DMAM" ]
then
	echo "ERROR 1: Cabecera incorrecta"
	echo "KO_HEADER" | nc localhost 2022
	exit 1
fi

echo "2. CHECK OK - Enviando OK_HEADER"
echo "OK_HEADER" | nc localhost 2022
DATA=`nc -l $PORT`
