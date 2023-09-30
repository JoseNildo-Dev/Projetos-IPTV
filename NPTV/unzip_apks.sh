#!/bin/bash

# Diretório atual
current_directory="$(pwd)"

# Verifique se o diretório existe
if [ ! -d "$current_directory" ]; then
  echo "O diretório atual não existe: $current_directory"
  exit 1
fi

# Loop através de todos os arquivos APK no diretório atual
for apk_file in "$current_directory"/*.apk; do
  # Verifique se o arquivo é realmente um arquivo APK
  if [ -f "$apk_file" ]; then
    # Nome do APK sem a extensão
    apk_name="${apk_file%.apk}"

    # Diretório de saída para este APK
    output_directory="$current_directory/$apk_name"

    # Verifique se o diretório de saída já existe
    if [ -d "$output_directory" ]; then
      echo "O diretório de saída já existe: $output_directory"
    else
      # Crie o diretório de saída
      mkdir "$output_directory"

      # Use o apktool para descompilar o APK
      apktool d "$apk_file" -o "$output_directory"

      echo "APK descompilado: $apk_name"
    fi
  fi
done

echo "Descompilação de APKs concluída."

