📦 Factorio Modpack Tools
Strumenti per automatizzare la gestione di un modpack di Factorio.
Il progetto include:
- uno script PowerShell per scaricare automaticamente gli asset di una release GitHub (velocissimo grazie a curl.exe)
- uno script Python per generare un file Excel con l’elenco dei mod presenti nella cartella, con parsing intelligente dei nomi
Questi strumenti permettono di mantenere aggiornato un modpack e documentarlo in modo ordinato.

⚙️ Funzionalità principali
- Download automatico degli asset di una release GitHub
- Salvataggio diretto nella cartella corrente
- Generazione di un file mods.xlsx con:
- nome del mod
- data di ultima modifica
- link al mod su mods.factorio.com
- Parsing avanzato dei nomi dei file .zip per generare link corretti
- Ordinamento automatico per data (dal più recente al più vecchio)

🚀 Script PowerShell — Download degli asset GitHub
Questo script scarica tutti gli asset associati a una release specifica di un repository GitHub.
Utilizza curl.exe per ottenere la massima velocità di download.
📄 download_release.ps1
# Scarica gli asset della release V1.0.0 del repository Factorio_K2

$repoOwner = "Libra-glitch"
$repoName = "Factorio_K2"
$tag = "V1.0.0"

# URL API GitHub per la release specifica
$releaseUrl = "https://api.github.com/repos/$repoOwner/$repoName/releases/tags/$tag"

Write-Host "Recupero informazioni sulla release $tag..."
$release = Invoke-RestMethod -Uri $releaseUrl

# Scarica ogni asset usando curl.exe (massima velocità)
foreach ($asset in $release.assets) {
    $fileName = $asset.name
    $downloadUrl = $asset.browser_download_url

    Write-Host "Scarico: $fileName"
    curl.exe -L $downloadUrl -o $fileName
}

Write-Host "Download completato. File salvati nella cartella corrente."


📝 Note
- Nessuna cartella aggiuntiva viene creata.
- Tutti i file vengono salvati nella directory da cui esegui lo script.
- curl.exe è incluso in Windows 10/11.

🐍 Script Python — Generazione Excel dei mod
Questo script analizza tutti i file .zip nella cartella corrente e crea un file mods.xlsx con informazioni utili per documentare il modpack.
📄 generate_mods_excel.py
import os
from datetime import datetime
from openpyxl import Workbook
from openpyxl.styles import Font

# Cartella corrente (quella dove si trova lo script)
folder = os.getcwd()

# Crea il file Excel
wb = Workbook()
ws = wb.active
ws.title = "Mods"

# Intestazioni
ws.append(["Nome Mod", "Ultima Modifica", "Link"])

entries = []

for filename in os.listdir(folder):
    if filename.lower().endswith(".zip"):
        mod_name = filename[:-4]

        # Logica per troncare al primo underscore seguito da numero
        mod_prefix = mod_name  # default: nessun taglio
        for i, ch in enumerate(mod_name):
            if ch == "_" and i + 1 < len(mod_name) and mod_name[i + 1].isdigit():
                mod_prefix = mod_name[:i]  # tronca qui
                break

        full_path = os.path.join(folder, filename)
        timestamp = os.path.getmtime(full_path)
        last_modified = datetime.fromtimestamp(timestamp)

        date_str = last_modified.strftime("%Y-%m-%d")
        link = f"https://mods.factorio.com/mod/{mod_prefix}"

        entries.append((mod_name, date_str, link, last_modified))

# Ordina per data (decrescente)
entries.sort(key=lambda x: x[3], reverse=True)

# Scrittura nel foglio
for mod_name, date_str, link, _ in entries:
    ws.append([mod_name, date_str, link])

    cell = ws.cell(row=ws.max_row, column=3)
    cell.hyperlink = link
    cell.font = Font(color="0000FF", underline="single")

wb.save("mods.xlsx")
print("File Excel 'mods.xlsx' generato con successo.")



🔍 Logica di parsing dei nomi dei mod
Lo script Python applica una regola intelligente per generare link corretti:
- Se un underscore _ è seguito da un numero → tronca il nome prima dell’underscore
- Mod_5.0.zip → Mod
- Se l’underscore è seguito da una lettera → non tronca
- Mod_alpha.zip → Mod_alpha
- Se ci sono più underscore → tronca al primo che precede un numero
- Mod_x_2_beta.zip → Mod_x

📁 Output generati
PowerShell
- Scarica gli asset della release GitHub nella cartella corrente.
Python
Genera un file:
mods.xlsx

🧩 Requisiti
PowerShell
- Windows 10/11
- PowerShell 5+ o PowerShell Core
- curl.exe (già incluso)
Python
- Python 3.8+
- Libreria openpyxl
Installazione:
pip install openpyxl

