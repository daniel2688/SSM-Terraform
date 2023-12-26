#! /bin/bash

#variable

if dpkg -l | grep -q kubernetes ; 
then
    echo " kubernetes ya está instalado en el sistema."
else
    echo "Instalando paquete kubernetes..."
    apt-get update  # Asegura que la información del repositorio esté actualizada
    apt install kubernetes -y

    # Verifica si la instalación fue exitosa

    if [ $? -eq 0 ]; 
then
        echo "¡kubernetes se instaló con éxito!"
    else
        echo "Hubo un problema durante la instalación de kubernetes."
    fi
fi


