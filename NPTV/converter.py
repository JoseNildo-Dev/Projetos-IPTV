import json

# Carregue o JSON de entrada a partir do arquivo apps.json na mesma pasta do script
with open('apps.json', 'r') as json_file:
    data = json.load(json_file)

# Inicialize uma lista para armazenar os aplicativos convertidos em formato AppFix
app_fixes = []

# Itere sobre os aplicativos no JSON e converta-os para o formato AppFix
for idx, app in enumerate(data['apps'], start=1):
    app_fix = (
        f"AppFix(\n"
        f"\tid = \"{idx}\",\n"
        f"\tdisplayName = \"{app['app_name']}\",\n"
        f"\tpackageName = \"{app['package_name']}\",\n"
        f"\tlaunchIntentUriDefault = \"{app['launch_intent_uri_default']}\",\n"
        f"\tlaunchIntentUriLeanback = \"{app['launch_intent_uri_leanback']}\"\n"
        f"),\n\n"
    )
    app_fixes.append(app_fix)

# Salve os aplicativos convertidos em apps.txt
with open('apps.txt', 'w') as txt_file:
    txt_file.write('\n'.join(app_fixes))

print("Conversão concluída. Os dados foram salvos em apps.txt.")
