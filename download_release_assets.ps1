# Scarica gli asset della release V1.0.0 del repository Factorio_K2

$repoOwner = "Libra-glitch"
$repoName = "Factorio_K2"
$tag = "V1.0.0"

# URL API GitHub per la release specifica
$releaseUrl = "https://api.github.com/repos/$repoOwner/$repoName/releases/tags/$tag"

Write-Host "Recupero informazioni sulla release $tag..."
$release = Invoke-RestMethod -Uri $releaseUrl

# Crea cartella per gli asset
$assetsFolder = "release_assets"
New-Item -ItemType Directory -Force -Path $assetsFolder | Out-Null

# Scarica ogni asset
foreach ($asset in $release.assets) {
    $fileName = $asset.name
    $downloadUrl = $asset.browser_download_url

    Write-Host "Scarico: $fileName"
    Invoke-WebRequest -Uri $downloadUrl -OutFile "$assetsFolder\$fileName"
}

Write-Host "Download completato. File salvati in: $assetsFolder"