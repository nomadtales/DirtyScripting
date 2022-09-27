$ProgressPreference = 'Continue'
$twimg = 'https://video.twimg.com/ext_tw_video/1574546540466692096/pu/pl/FXTCCfshpwMH7p1A.m3u8?variant_version=1&tag=12&container=fmp4'

#$m3u8wrapper = Read-Host 'Enter .m3u8 url'

$m3u8Content = (Invoke-WebRequest -Uri $twimg).rawcontent
$m3u8Content | Where-Object {$_ -match '\/ext_tw_video.*'}

$Matches