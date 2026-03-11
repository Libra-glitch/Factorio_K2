📦 Factorio Modpack Tools
Strumenti per automatizzare la gestione del modpack di Krastorio 2.
Il progetto include:
- uno script PowerShell per scaricare automaticamente gli asset di una release GitHub (velocissimo grazie a curl.exe)
- uno script Python per generare un file Excel con l’elenco dei mod presenti nella cartella, con parsing intelligente dei nomi
Questi strumenti permettono di mantenere aggiornato un modpack e documentarlo in modo ordinato.

⚙️ Funzionalità principali
- Download automatico degli asset di una release GitHub
- Salvataggio diretto nella cartella corrente
- Generazione di un file mods.xlsx con:
- nome della mod
- data di ultima modifica
- link alle mod su mods.factorio.com
- Parsing avanzato dei nomi dei file .zip per generare link corretti
- Ordinamento automatico per data (dal più recente al più vecchio)

🚀 Script PowerShell — Download degli asset GitHub
Questo script scarica tutti gli asset associati a una release specifica di un repository GitHub.
Utilizza curl.exe per ottenere la massima velocità di download.
📄 download_release_assets.ps1
# Scarica gli asset della release V1.0.0 del repository Factorio_K2
    .\download_release_assets.ps1

📝 Note
- Nessuna cartella aggiuntiva viene creata.
- Tutti i file vengono salvati nella directory da cui esegui lo script.
- curl.exe è incluso in Windows 10/11.

🐍 Script Python — Generazione Excel delle mod
Questo script analizza tutti i file .zip nella cartella corrente e crea un file mods.xlsx con informazioni utili per documentare il modpack.
📄 .\generate_mods_excel.py

🔍 Logica di parsing dei nomi delle mod
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

