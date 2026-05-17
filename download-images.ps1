# download-images.ps1
# One-shot downloader for all wp-content images referenced by the site.
# Run from the project root:    powershell -ExecutionPolicy Bypass -File .\download-images.ps1
# Files land under public/images/<year>/<month>/<filename> matching the original WP paths.
# Already-downloaded files are skipped, so it's safe to re-run.

$ErrorActionPreference = 'Stop'

$root    = $PSScriptRoot
$outBase = Join-Path $root 'public\images'
$filesOut = Join-Path $root 'public\files'
$base    = 'https://adventure-access.com/wp-content/uploads/'

# One PDF lives alongside the images and ships under public/files/
$extraFiles = @(
    @{ Url = $base + '2025/08/Adventure-Access-Payment-Terms-and-Cancellation-Policy-2024.pdf';
       Dest = (Join-Path $filesOut 'Adventure-Access-Payment-Terms-and-Cancellation-Policy-2024.pdf') }
)

$paths = @(
    '2018/08/DSC_51702.jpg',
    '2018/08/P42417711.jpg',
    '2020/02/Adventure-Access-7-480x350.jpg',
    '2020/05/Hero-image-480x350.jpg',
    '2020/09/Hero-Image-480x350.jpg',
    '2020/09/Hiking-in-Lijiang-480x350.jpg',
    '2020/09/IMG_4363-480x350.jpg',
    '2020/10/IMG_0129-1920x900.jpg',
    '2020/10/IMG_4380-1920x900.jpg',
    '2020/10/IMG_4381-1920x900.jpg',
    '2020/10/IMG_4383-1920x900.jpg',
    '2020/10/IMG_5072-1920x900.jpg',
    '2020/10/IMG_5084-1920x900.jpg',
    '2020/10/IMG_8242-1920x900.jpg',
    '2020/10/IMG_8717-1920x900.jpg',
    '2021/04/thangkha-adventure-access-480x350.jpg',
    '2021/04/trekkers-adventure-access-480x350.jpg',
    '2021/08/jiuzhaigou-hero-image-480x350.jpg',
    '2023/06/About-Us-General-2-scaled.jpg',
    '2023/06/Brian-1024x720.jpg',
    '2023/06/Lenduk-Lhomi-1024x720.jpg',
    '2023/06/Trevor-1024x720.jpg',
    '2023/12/napal-slider01.jpg',
    '2023/12/napal-slider02.jpg',
    '2023/12/napal-slider03.jpg',
    '2023/12/napal-slider04.jpg',
    '2023/12/napal-slider05.jpg',
    '2023/12/napal-slider06.jpg',
    '2023/12/napal-slider07.jpg',
    '2024/03/bhutan01.jpg',
    '2024/03/bhutan02.jpg',
    '2024/03/bhutan03.jpg',
    '2024/03/bhutan04.jpg',
    '2024/03/bhutan05.jpg',
    '2024/03/bhutan06.jpg',
    '2024/03/bhutan07.jpg',
    '2024/03/bhutan08.jpg',
    '2024/03/hot-stone-bath-large-480x350.jpg',
    '2024/03/ladakh01.jpg',
    '2024/03/ladakh03.jpg',
    '2024/03/ladakh04.jpg',
    '2024/03/ladakh05.jpg',
    '2024/03/ladakh06.jpg',
    '2024/03/ladakh07.jpg',
    '2024/04/Boudhanath-Hero-Image-1920-480x350.jpg',
    '2024/05/Bhutan-Hero-Image.jpg',
    '2024/05/Hero-Image-Lijiang.jpg',
    '2024/05/IMG_2802-1920x900.jpg',
    '2024/05/IMG_4944-1-1920x900.jpg',
    '2024/05/IMG_5619-1920x900.jpg',
    '2024/05/Ladakh-hero-image.jpg',
    '2024/05/Nepal-Page-Hero-image-scaled-1.jpeg',
    '2024/12/tomorrows-blog-header-1600px-480x350.jpg',
    '2025/06/stanzin-bio-1024x720.jpg',
    '2025/11/MTB-Exploration-Photo-3-480x350.jpeg',
    '2025/11/PXL_20250707_105830934-1920x900.jpeg'
)

$total   = $paths.Count
$skipped = 0
$ok      = 0
$failed  = @()
$i       = 0

Write-Host "Downloading $total images to $outBase" -ForegroundColor Cyan

foreach ($p in $paths) {
    $i++
    $dest    = Join-Path $outBase ($p -replace '/', '\')
    $destDir = Split-Path $dest -Parent

    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }

    if (Test-Path $dest) {
        Write-Host ("[{0,3}/{1}] skip (exists) {2}" -f $i, $total, $p)
        $skipped++
        continue
    }

    $url = $base + $p
    try {
        Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing -ErrorAction Stop
        Write-Host ("[{0,3}/{1}] ok   {2}" -f $i, $total, $p) -ForegroundColor Green
        $ok++
    }
    catch {
        Write-Host ("[{0,3}/{1}] FAIL {2}  ({3})" -f $i, $total, $p, $_.Exception.Message) -ForegroundColor Red
        $failed += $p
    }
}

foreach ($f in $extraFiles) {
    $destDir = Split-Path $f.Dest -Parent
    if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }

    if (Test-Path $f.Dest) {
        Write-Host ("[extra] skip (exists) {0}" -f (Split-Path $f.Dest -Leaf))
        $skipped++
        continue
    }
    try {
        Invoke-WebRequest -Uri $f.Url -OutFile $f.Dest -UseBasicParsing -ErrorAction Stop
        Write-Host ("[extra] ok   {0}" -f (Split-Path $f.Dest -Leaf)) -ForegroundColor Green
        $ok++
    }
    catch {
        Write-Host ("[extra] FAIL {0}  ({1})" -f (Split-Path $f.Dest -Leaf), $_.Exception.Message) -ForegroundColor Red
        $failed += $f.Url
    }
}

Write-Host ""
Write-Host "Done. Downloaded: $ok   Skipped: $skipped   Failed: $($failed.Count)" -ForegroundColor Cyan
if ($failed.Count -gt 0) {
    Write-Host "Failures:" -ForegroundColor Yellow
    $failed | ForEach-Object { Write-Host "  $_" }
    exit 1
}
