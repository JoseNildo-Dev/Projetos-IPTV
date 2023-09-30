#!/bin/bash

# Diretório onde está o script (e também os APKs)
SCRIPT_DIR=$(dirname "$0")
APK_DIR="$SCRIPT_DIR"

# Arquivo JSON de saída
JSON_FILE="apps.json"

# Inicializa o JSON
echo '{ "apps": [' > "$JSON_FILE"

# Loop pelos APKs no diretório
for apk in "$APK_DIR"/*.apk
do
  # Extrai informações do APK usando aapt
  app_name=$(aapt d badging "$apk" | awk -F"'" '/application-label/{print $2}' | head -n 1)
  package_name=$(aapt d badging "$apk" | awk -F"'" '/package: name=/{print $2}')
  version_name=$(aapt dump badging "$apk" | sed -n "s/.*versionName='\([^']*\).*/\1/p")
  sha256=$(shasum -a 256 "$apk" | awk '{print $1}')

  # Gera a URL de download
  apk_filename=$(basename "$apk")
  download_url="https://github.com/JoseNildo-Dev/Projetos-IPTV/raw/main/NPTV/$apk_filename"

  # Gera as linhas JSON para cada APK
  cat >> "$JSON_FILE" <<EOF
  {
    "app_name": "$app_name",
    "package_name": "$package_name",
    "version_name": "$version_name",
    "download_url": "$download_url",
    "sha256": "$sha256",
    "launch_intent_uri_default": "#Intent;action=android.intent.action.MAIN;category=android.intent.category.LAUNCHER;launchFlags=0x10000000;package=$package_name;component=$package_name/.ui.Splah;end",
    "launch_intent_uri_leanback": "#Intent;action=android.intent.action.MAIN;category=android.intent.category.LEANBACK_LAUNCHER;launchFlags=0x10000000;package=$package_name;component=$package_name/.ui.Splah;end"
  },
EOF
done

# Remove a vírgula extra na última linha do JSON
sed -i.bak '$ s/,$//' "$JSON_FILE"

# Fecha o JSON
echo '  ]' >> "$JSON_FILE"
echo '}' >> "$JSON_FILE"

echo "Arquivo JSON gerado em $JSON_FILE"
