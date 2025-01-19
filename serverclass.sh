#!/bin/bash
PORT="2022"

echo "Servidor de Dragón Magia Abuelita Miedo 2022"

echo "0. ESCUCHANDO"
DATA=`nc -l $PORT`

HEADER=`echo "$DATA" | cut -d ' ' -f 1`
IP=`echo "$DATA" | cut -d ' ' -f 2`

echo "IP del CLIENTE - $IP"

if [ "$HEADER" != "DMAM" ]
then
	echo "ERROR 1: Cabecera incorrecta"
	echo "KO_HEADER" | nc $IP $PORT
	exit 1
fi

echo "2. CHECK OK - Enviando OK_HEADER"
echo "OK_HEADER" | nc $IP $PORT


echo "4. COMPROBANDO FILE_NAME"
DATA=`nc -l $PORT`
PREFIJO=`echo "$DATA" | cut -d ' ' -f 1`
FILE_NAME=`echo "$DATA" | cut -d ' ' -f 2`
MD5SUM_CLIENT=`echo $DATA | cut -d ' ' -f 3`

if [ "$PREFIJO" != "FILE_NAME" ]
then
	echo "ERROR 2: Prefijo incorrecto"
	echo "KO_FILE_NAME" | nc $IP $PORT
	exit 2
fi

echo "5. COMPROBANDO MD5SUM_FILE_NAME"
MD5SUM_FNAME=$(echo -n "$FILE_NAME" | md5sum | cut -d ' ' -f 1)

if [ "$MD5SUM_CLIENT" != "$MD5SUM_FNAME" ]
then
	echo "ERROR 3: MD5 incorrecto"
	echo "KO_MD5_FILE_NAME"
	exit 3
fi

echo "6. CHECK OK - Enviando OK_FILE_NAME"
echo "OK_FILE_NAME" | nc $IP $PORT


echo "9. RECIBIR CONTENIDO"
DATA=`nc -l $PORT`

if [ "$DATA" == "" ]
then
	echo "ERROR 4: No hay contenido/contenido vacío"
	echo "KO_CONTENIDO" | nc $IP $PORT
	exit 4
fi

echo "$DATA" > server/$FILE_NAME
echo "$FILE_NAME guardado en server/$FILE_NAME"

echo "10. CHECK OK - Enviando OK_CONTENIDO, guardando CONTENIDO"
echo "OK_CONTENIDO" | nc $IP $PORT

echo "12. RECIBIR CONTENIDO CIFRADO MD5"
DATA=`nc -l $PORT`

MD5SUM_CLIENT=`echo $DATA | cut -d ' ' -f 2`

MD5SUM_SERVER=$(md5sum server/$FILE_NAME | cut -d ' ' -f 1)

if [ "$MD5SUM_CLIENT" != "$MD5SUM_SERVER" ]
then
	echo "ERROR 5: El MD5 no coincide"
	echo "KO_MD5SUM" | nc $IP $PORT
	exit 5
fi
echo "13. CHECK OK - Enviando OK_MD5SUM"
echo "OK_MD5SUM" | nc $IP $PORT
echo "Finalizacion"
