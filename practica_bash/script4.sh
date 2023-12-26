#! /bin/bash

#variables
VALOR1=$1
VALOR2=$2

if [ -f test ] ; 
then
    echo "esto es un directorio"
else
    echo "no es un directorio"
fi  # Añade esta línea para cerrar el bloque 'if'

echo "este es mi primer script de variable $VALOR1"
# mkdir hola
# touch hola/prueba.txt
echo "fin de script variable $VALOR2"
