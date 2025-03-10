#!/bin/bash

# Función para validar números enteros positivos
validar_numero() {
    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "Error: '$1' no es un número válido."
        exit 1
    fi
}

# Función para validar el tipo de sistema operativo
validar_tipo_so() {
    if ! VBoxManage list ostypes | grep -q "$1"; then
        echo "Error: El tipo de sistema operativo '$1' no es válido."
        echo "Usa 'VBoxManage list ostypes' para ver los tipos soportados."
        exit 1
    fi
}

# Interfaz interactiva para ingresar los datos
echo "Creación de una nueva máquina virtual en VirtualBox"
read -p "Nombre de la VM: " nombreVM
read -p "Tipo de sistema operativo (ej. Ubuntu_64, Windows10_64, etc.): " tipoSO
read -p "Número de CPUs: " numCPU
read -p "Memoria en GB: " memoriaGB
read -p "VRAM en MB: " vramMB
read -p "Tamaño del disco en GB: " tamanoDIS_GB
read -p "Nombre del controlador (ej. SATA Controller): " SATA

# Validaciones
validar_tipo_so "$tipoSO"
validar_numero "$numCPU"
validar_numero "$memoriaGB"
validar_numero "$vramMB"
validar_numero "$tamanoDIS_GB"

# Convertir memoria de GB a MB (VirtualBox usa MB para --memory)
memoriaMB=$((memoriaGB * 1024))

# Creación de la máquina virtual
echo "Creando la máquina virtual '$nombreVM'..."
VBoxManage createvm --name "$nombreVM" --ostype "$tipoSO" --register

# Configuración de la máquina virtual
echo "Configurando la máquina virtual..."
VBoxManage modifyvm "$nombreVM" --cpus "$numCPU" --memory "$memoriaMB" --vram "$vramMB"

# Creación del disco duro virtual
echo "Creando el disco duro virtual..."
VBoxManage createmedium disk --filename "$nombreVM.vdi" --size "$((tamanoDIS_GB * 1024))"

# Asignación del disco duro a la máquina virtual
echo "Asignando el disco duro a la máquina virtual..."
VBoxManage storagectl "$nombreVM" --name "$SATA" --add sata --controller IntelAHCI
VBoxManage storageattach "$nombreVM" --storagectl "$SATA" --port 0 --device 0 --type hdd --medium "$nombreVM.vdi"

# Creación y asociación del controlador IDE (para DVD, por ejemplo)
echo "Configurando el controlador IDE..."
VBoxManage storagectl "$nombreVM" --name "IDE Controller" --add ide
VBoxManage storageattach "$nombreVM" --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium emptydrive

# Mostrar la configuración de la máquina virtual
echo "Configuración final de la máquina virtual '$nombreVM':"
VBoxManage showvminfo "$nombreVM" | grep -E "Name:|Memory size|Number of CPUs|VRAM size|SATA Controller|IDE Controller"

# Mensaje final
echo "¡Máquina virtual creada exitosamente!"
