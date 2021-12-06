$ProgressPreference = 'Continue'
$twimg = 'https://video.twimg.com/ext_tw_video/1451607491620573197/pu/pl/GBv9M31rgbSSXMlb.m3u8?tag=12&container=fmp4'

#$m3u8wrapper = Read-Host 'Enter .m3u8 url'

$m3u8Content = (Invoke-WebRequest -Uri $twimg).rawcontent
$m3u8Content | Where-Object {$_ -match '\/ext_tw_video.*'}

$Matches