#!/bin/bash

while true;
do
    echo "MENU PRINCIPAL"
    echo "1.- Listar una carpeta"
    echo "2.- Crear archivo"
    echo "3.- Comparar dos archivos"
    echo "4.- awk."
    echo "5.- grep."

    echo "6. Salir."

    read -p "Seleccione una opcion: " opcion
    case $opcion in

        1)
            # Listar contenido
            read -p "Ingresa la ruta absoluta de la carpeta: " ruta
            if [ -e "$ruta" ]; then
            	echo "Listar $ruta:"
            	ls -l "$ruta"
            else
            	echo "La ruta $ruta no existe"
            fi
            ;;
        2)
            # Crear un archivo de texto
            read -p "Ingresa la cadena de texto para el archivo: " texto
            echo "$texto" > archivo.txt
            echo "Archivo creado en: $(pwd)/archivo.txt"
            ;;
        3)
            # Comparar dos archivos de texto
            read -p "Ingrese el nombre del primer archivo: " archivo1
            read -p "Ingrese el nombre del segundo archivo: " archivo2

            cmp --silent "$archivo1" "$archivo2" && echo "Los archivos son iguales..." || echo "Los archivos son diferentes..."
            diff "$archivo1" "$archivo2"
            ;;
        4)
            # comando awk
            echo "Este comando es usado para procesar y analizar texto en columnas:"

            echo "1  Pablo azul - mostramos columna 2 y 1"
            echo "Resultado: 1  Pablo azul" | awk '{print $2, $1}'
            echo "No quiero hacer tarea - mostramos todo menos el primero"
            echo "Resultado: No quiero hacer tarea" | awk '{print $2, $3, $4}'
            ;;
        5)
            # comando grep

            echo "Este comando es usado para encontrar patrones en archivos:"
            echo "Buscar /bin/bash en /etc/passwd"
            grep '/bin/bash' /etc/passwd
            ;;
        6)
            # Salir del script
            echo "Saliendo del script..."
            exit 0
            ;;
        *)
            # error
            echo "Opcion invalida. Intentelo de nuevo..."
            ;;
    esac

done
