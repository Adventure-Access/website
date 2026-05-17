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
    '2017/11/006aP9X3gy1fert7mjw40j31hc140n41-300x225.jpg',
    '2017/11/006aP9X3gy1ferte8m4x2j31kw16ohdt-300x225.jpg',
    '2017/11/A-Day-Hike-to-Shangniba-Monastery.jpg',
    '2017/11/A-Hike-Up-Mt.-Xiao-Xue-Bao-Ding-7.jpg',
    '2017/11/A-Traditional-Chinese-New-Year-in-Songpan-Old-Town-1-300x300.jpg',
    '2017/11/A-Traditional-Chinese-New-Year-in-Songpan-Old-Town.jpg',
    '2017/11/Adventure-Access-101.jpg',
    '2017/11/Adventure-Access-102.jpg',
    '2017/11/Adventure-Access-103.jpg',
    '2017/11/Adventure-Access-104.jpg',
    '2017/11/Adventure-Access-108.jpg',
    '2017/11/Adventure-Access-109.jpg',
    '2017/11/Adventure-Access-111.jpg',
    '2017/11/Adventure-Access-5.jpg',
    '2017/11/Amdo-women-and-children-arrive-at-the-Sogtsang-Monastery-300x200.jpg',
    '2017/11/CDIS-103.jpg',
    '2017/11/Cals-pics-51-1.jpg',
    '2017/11/DSC_0285.jpg',
    '2017/11/DSC_0472.jpg',
    '2017/11/Family-Wilderness-Weekends-11-1.jpg',
    '2017/11/Family-Wilderness-Weekends-11.jpg',
    '2017/11/Family-Wilderness-Weekends-24.jpg',
    '2017/11/Family-Wilderness-Weekends-32-1024x576.jpg',
    '2017/11/Family-Wilderness-Weekends-38.jpg',
    '2017/11/IMG_0721.jpg',
    '2017/11/IMG_0725.jpg',
    '2017/11/IMG_0747.jpg',
    '2017/11/IMG_0763.jpg',
    '2017/11/IMG_0779.jpg',
    '2017/11/IMG_0824.jpg',
    '2017/11/P4070109.jpg',
    '2017/11/P6163666.jpg',
    '2017/11/P6163707.jpg',
    '2017/11/Seasonal-Temperature-Chart.pdf',
    '2017/11/Songpan-Branch-Map-North-1024x725-300x212.jpg',
    '2017/11/Songpan-Hotpot-2-945x385.jpg',
    '2017/11/Tibetan-New-Year-1.jpg',
    '2017/11/Tibetan-New-Year-2.jpg',
    '2017/11/Tibetan-New-Year-3-300x200.jpg',
    '2017/11/Tibetan-New-Year.jpg',
    '2017/11/Trekking-in-Jiuzhaigou-Experiencing-Jiuzhaigou-outside-the-Park-1-300x200.jpg',
    '2017/11/Trekking-in-Jiuzhaigou-Experiencing-Jiuzhaigou-outside-the-Park-4-300x199.jpg',
    '2017/11/Trekking-in-Jiuzhaigou-Experiencing-Jiuzhaigou-outside-the-Park-5-300x199.jpg',
    '2017/11/Trekking-in-Jiuzhaigou-Experiencing-Jiuzhaigou-outside-the-Park-6-300x199.jpg',
    '2017/11/Trekking-in-Jiuzhaigou-Experiencing-Jiuzhaigou-outside-the-Park-7-300x199.jpg',
    '2017/11/Trekking-in-Jiuzhaigou-Experiencing-Jiuzhaigou-outside-the-Park-8-300x199.jpg',
    '2017/11/Trekking-in-Jiuzhaigou-Experiencing-Jiuzhaigou-outside-the-Park-9-300x199.jpg',
    '2017/11/Trekking-in-Jiuzhaigou-Experiencing-Jiuzhaigou-outside-the-Park.jpg',
    '2017/11/Where-to-Eat-in-Songpan.jpg',
    '2017/11/XueBaoDing-Trek-134-300x169.jpg',
    '2017/11/XueBaoDing-Trek-154-1-300x169.jpg',
    '2018/02/IMG_0035.jpg',
    '2018/05/Photo-1.jpeg',
    '2018/05/Photo-2.jpeg',
    '2018/05/Photo-3.jpg',
    '2018/06/New-blog-post-Adventure-Access-01.jpg',
    '2018/06/New-blog-post-Adventure-Access-02.jpg',
    '2018/06/New-blog-post-Adventure-Access-03.jpg',
    '2018/06/New-blog-post-Adventure-Access-04.jpg',
    '2018/06/New-blog-post-Adventure-Access-05.jpg',
    '2018/08/DSC_51702.jpg',
    '2018/08/Optimized-Adventure-Access-Summer-Auction-Twitter-LinkedIn_1.jpg',
    '2018/08/P42417711.jpg',
    '2018/10/Adventure-Access-Beyond-Tibet-1.jpg',
    '2018/10/Adventure-Access-Beyond-Tibet-3.jpg',
    '2018/10/Adventure-Access-Beyond-Tibet-4.jpg',
    '2018/10/Adventure-Access-Beyond-Tibet-Tower-Photo.jpg',
    '2018/10/Adventure-Access-Beyond-Tibet.jpg',
    '2018/11/Adventure-Access-Songpan_resize.jpg',
    '2019/07/1.jpg',
    '2019/07/2.jpg',
    '2019/07/Hero_Packing-Tips-for-Mountain-Biking-in-Eastern-Tibet-.jpg',
    '2019/07/Packing-Tips-for-Mountain-Biking-in-Eastern-Tibet-1.jpg',
    '2019/07/Packing-Tips-for-Mountain-Biking-in-Eastern-Tibet-2.jpg',
    '2019/07/Packing-Tips-for-Mountain-Biking-in-Eastern-Tibet-3.jpg',
    '2019/11/AA-3823.jpg',
    '2019/11/IMG_6235.jpg',
    '2019/11/IMG_6410.jpg',
    '2019/12/Feature-image.jpg',
    '2019/12/GEOPRESS-Graphic-1.jpg',
    '2019/12/GEOPRESS-Graphic-2.jpg',
    '2019/12/GEOPRESS_PR_GRID-2.jpg',
    '2019/12/Grant_Colorado_Kyle-Murphy_',
    '2019/12/Side-by-Side-Comparison-Photo.jpg',
    '2020/01/Cham-Dance-Photo.jpg',
    '2020/01/Eastern-Himalaya-Hiking.jpg',
    '2020/01/Eastern-Himalaya-Hiking_featured-image.jpg',
    '2020/01/Feature.jpg',
    '2020/01/Featured-images.jpg',
    '2020/01/Fully-Equipped-Yeti-Photo.jpg',
    '2020/01/Jiuzhai-Winter-Photo.jpg',
    '2020/01/Labrang-Monlam-Photo.jpg',
    '2020/01/Lost-in-thought-in-the-Himalayas.jpg',
    '2020/01/Monastery-Festival.jpg',
    '2020/01/Packing-Photo.jpg',
    '2020/01/Packing-Photo1.jpg',
    '2020/01/Tea-Time.jpg',
    '2020/01/Winter-Pass-Prayer-Flags.jpg',
    '2020/01/Xuebaoding-with-Flag.jpg',
    '2020/01/Yaks-over-blue-water.jpg',
    '2020/01/Yeti-Photo-Shoot-2.jpg',
    '2020/01/Yeti-in-Hat-Photo.jpg',
    '2020/01/Yeti-in-Pants-and-Fleece-Photo.jpg',
    '2020/01/Yeti-in-Thermals-Photo.jpg',
    '2020/02/Adventure-Access-7-480x350.jpg',
    '2020/02/Adventure-Access-7.jpg',
    '2020/02/Screen-Shot-2020-01-20-at-3.03.46-PM.png',
    '2020/02/TIBETAN-PLATEAU-it-is-not-as-brown-and-dry-as-you-think.jpg',
    '2020/05/Hero-image-480x350.jpg',
    '2020/05/Hero-image.jpg',
    '2020/05/Image-1.jpg',
    '2020/05/Image-2.jpg',
    '2020/09/Copy-of-IMG_4366.jpg',
    '2020/09/Copy-of-IMG_4369.jpg',
    '2020/09/Copy-of-IMG_4373.jpg',
    '2020/09/Copy-of-IMG_4374.jpg',
    '2020/09/Copy-of-IMG_4381.jpg',
    '2020/09/Croatia-Climbing.jpg',
    '2020/09/Doris-Staff-Photo.jpg',
    '2020/09/Get-Out-More-Lower-Banner.jpg',
    '2020/09/Hero-Image-480x350.jpg',
    '2020/09/Hero-Image.jpg',
    '2020/09/Hiking-in-Lijiang-480x350.jpg',
    '2020/09/Hiking-in-Lijiang.jpg',
    '2020/09/Huanglong-5-colored-pool.jpg',
    '2020/09/Huanglong-Winter-Photo.jpg',
    '2020/09/IMG_4363-480x350.jpg',
    '2020/09/IMG_4363.jpg',
    '2020/09/Infographic.jpg',
    '2020/09/Jade-Dragon-Mountain.jpg',
    '2020/09/Krabi-Climbing.jpg',
    '2020/09/Mammoth-Springs-Yellowstone.jpg',
    '2020/09/Mount-Xuebaoding.jpg',
    '2020/09/Old-Town-photo.jpg',
    '2020/09/Picnic-photo.jpg',
    '2020/09/Pincu-Photo.jpg',
    '2020/09/Songpan-Climbing.jpg',
    '2020/09/Tiger-Leaping-Gorge.jpg',
    '2020/09/Waterfall.jpg',
    '2020/09/Zhaga-Waterfall-1.jpg',
    '2020/09/Zhaga-Waterfall-Winter.jpg',
    '2020/10/IMG_0129-1920x900.jpg',
    '2020/10/IMG_4380-1920x900.jpg',
    '2020/10/IMG_4381-1920x900.jpg',
    '2020/10/IMG_4383-1920x900.jpg',
    '2020/10/IMG_5072-1920x900.jpg',
    '2020/10/IMG_5084-1920x900.jpg',
    '2020/10/IMG_8242-1920x900.jpg',
    '2020/10/IMG_8717-1920x900.jpg',
    '2021/04/adventure-access-flags-300x169.jpg',
    '2021/04/amnye-machen-mountain-god-300x225.jpg',
    '2021/04/girl-lamb-adventure-access-300x200.jpg',
    '2021/04/grassland-adventure-access-300x200.jpg',
    '2021/04/himalayan-mountains-sherpa-300x225.jpg',
    '2021/04/leng-nga-zhaga-300x200.jpg',
    '2021/04/machen-mountain-god-300x225.jpg',
    '2021/04/mount-kailash-adventure-access-300x169.jpg',
    '2021/04/nyanbo-yurtze-adventure-access-300x200.jpg',
    '2021/04/pilgrim-tibetan-people-300x225.jpg',
    '2021/04/shar-dongri-mountain-gods-300x200.jpg',
    '2021/04/thangkha-adventure-access-480x350.jpg',
    '2021/04/thangkha-adventure-access.jpg',
    '2021/04/trekkers-adventure-access-480x350.jpg',
    '2021/04/trekkers-adventure-access.jpg',
    '2021/08/dujiangyan-adventure-access-unesco-1024x751.jpg',
    '2021/08/emei-shan-adventure-access-unesco-1024x681.jpg',
    '2021/08/huangLong-world-heritage-natural-site-1024x730.png',
    '2021/08/huanglong-1024x768.jpg',
    '2021/08/jiuzhaigou-1024x683.jpg',
    '2021/08/jiuzhaigou-hero-image-480x350.jpg',
    '2021/08/jiuzhaigou-hero-image.jpg',
    '2021/08/mount-zhaga-adventure-access-tours-1024x680.jpg',
    '2021/08/muni-walley-adventure-access-tours-1024x694.jpg',
    '2021/08/panda-adventure-access-1024x683.jpg',
    '2021/08/unesco-world-heritage-410x1024.png',
    '2021/08/xuebaoding-adventure-access-tours-1024x683.jpg',
    '2021/08/zhaga-waterfall-adventure-access-tours-768x1024.jpg',
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
    '2024/03/artemisia.jpg',
    '2024/03/bhutan01.jpg',
    '2024/03/bhutan02.jpg',
    '2024/03/bhutan03.jpg',
    '2024/03/bhutan04.jpg',
    '2024/03/bhutan05.jpg',
    '2024/03/bhutan06.jpg',
    '2024/03/bhutan07.jpg',
    '2024/03/bhutan08.jpg',
    '2024/03/farmhouses.jpg',
    '2024/03/fired-river-stones.jpg',
    '2024/03/host.jpg',
    '2024/03/hot-stone-bath-large-480x350.jpg',
    '2024/03/hot-stone-bath-large.jpg',
    '2024/03/ladakh01.jpg',
    '2024/03/ladakh03.jpg',
    '2024/03/ladakh04.jpg',
    '2024/03/ladakh05.jpg',
    '2024/03/ladakh06.jpg',
    '2024/03/ladakh07.jpg',
    '2024/04/Boudha-crowds-resized.jpg',
    '2024/04/Boudha-shops-resized.jpg',
    '2024/04/Boudhanath-2-resized.jpg',
    '2024/04/Boudhanath-Hero-Image-1920-480x350.jpg',
    '2024/04/Boudhanath-Hero-Image-1920.jpg',
    '2024/04/Boudhanath-night-resized.jpg',
    '2024/04/Boudhanath-sunset.jpg',
    '2024/05/Bhutan-Hero-Image.jpg',
    '2024/05/Hero-Image-Lijiang.jpg',
    '2024/05/IMG_2802-1920x900.jpg',
    '2024/05/IMG_4944-1-1920x900.jpg',
    '2024/05/IMG_4944-1-300x228.jpg',
    '2024/05/IMG_5619-1920x900.jpg',
    '2024/05/Ladakh-hero-image.jpg',
    '2024/05/Nepal-Page-Hero-image-scaled-1.jpeg',
    '2024/12/adventure-access-client-action.jpg',
    '2024/12/minerals-soil.jpg',
    '2024/12/soil01.jpg',
    '2024/12/tomorrows-blog-header-1600px-480x350.jpg',
    '2024/12/tomorrows-blog-header-1600px.jpg',
    '2025/06/stanzin-bio-1024x720.jpg',
    '2025/11/20230616193020__MG_49712-300x215.jpeg',
    '2025/11/MTB-Exploration-Photo-3-480x350.jpeg',
    '2025/11/MTB-Exploration-Photo-3-scaled.jpeg',
    '2025/11/MTB-Exploration-Photo-4-300x169.jpeg',
    '2025/11/MTB-Exploration-Photo-5-300x169.jpeg',
    '2025/11/MTB-Exploration-Photo-6-300x258.jpeg',
    '2025/11/PXL_20230816_1244283083-300x230.jpeg',
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
