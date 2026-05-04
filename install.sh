#!/bin/bash

# Script para corregir toques fantasma en Synaptics 06CB:CEE7 en Fedora
echo "🚀 Iniciando la reparación del touchpad..."

# Verificar si se ejecuta como root
if [ "$EUID" -ne 0 ]; then 
  echo "❌ Por favor, ejecuta el script con sudo: sudo ./install.sh"
  exit 1
fi

# Crear el directorio si no existe
mkdir -p /etc/libinput

# Crear el archivo de quirks
echo "📝 Aplicando configuración de filtros de presión..."
cat <<EOF > /etc/libinput/local-overrides.quirks
[Synaptics Ghost Touch Fix]
MatchName=SYNA32E2:00 06CB:CEE7 Touchpad
MatchUdevType=touchpad
AttrPressureRange=50:40
AttrPalmPressureThreshold=120
EOF

echo "✅ Parche aplicado correctamente en /etc/libinput/local-overrides.quirks"
echo "🔄 Por favor, REINICIA tu computadora para que los cambios surtan efecto."
