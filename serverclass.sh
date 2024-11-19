#!/bin/bash
PORT="2022"

echo "Servidor de Dragón Magia Abuelita Miedo 2022"
echo "0. ESCUCHANDO"

DATA=`nc -l $PORT`

if [ "$DATA" != "DMAM" ]
then
	echo "ERROR 1: Cabecera incorrecta"
	echo "KO_HEADER" | nc localhost $PORT
	exit 1
fi
echo "2. CHECK OK - Enviando OK_HEADER"
echo "OK_HEADER" | nc localhost $PORT



DATA=`nc -l $PORT`
PREFIJO=`echo "$DATA" | cut -d ' ' -f 1`
FILE_NAME=`echo "$DATA" | cut -d ' ' -f 2`

if [ "$PREFIJO" != "FILE_NAME" ]
then
	echo "ERROR 2: Prefijo incorrecto"
	echo "KO_FILE_NAME" | nc localhost $PORT
	exit 2
fi
echo "4. CHECK OK - Enviando OK_FILE_NAME"
echo "OK_FILE_NAME" | nc localhost $PORT




echo "6. RECIBIR CONTENIDO"
DATA=`nc -l $PORT`

if [ "$DATA" == "" ]
then
	echo "ERROR 3: No hay contenido/contenido vacío"
	echo "KO_CONTENIDO" | nc localhost $PORT
	exit 3
fi

echo "7. CHECK OK - Enviando OK_CONTENIDO, guardando CONTENIDO"
echo "OK_CONTENIDO" | nc localhost $PORT
echo "$FILE_NAME guardado en server/$FILE_NAME"
echo $DATA > server/"$FILE_NAME"

