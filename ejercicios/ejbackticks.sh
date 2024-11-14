#!/bin/bash
#EJ 1:

echo "Con backticks: "
script=`ls`
echo "Estoy haciendo esto en la script: $script"

echo "Sin backticks: "
script=ls
echo "Estoy haciendo esto en la script: $script"

#EJ 2:

echo "con backticks: "
echo `date` | cowsay

echo "sin backticks: "
echo date | cowsay

