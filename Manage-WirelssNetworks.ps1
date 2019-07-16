Function Get-AvailableWirelessNetworks {
    Param (
        $SSID
    )
    $response = netsh wlan show networks mode=bssid
    $wLANs = $response | Where-Object {$_ -match "^SSID"} | Foreach-Object {
        $report = "" | Select SSID,NetworkType,Authentication,Encryption
        $i = $response.IndexOf($_)
        $report.SSID = $_ -replace "^SSID\s\d+\s:\s",""
        $report.NetworkType = $response[$i+1].Split(":")[1].Trim()
        $report.Authentication = $response[$i+2].Split(":")[1].Trim()
        $report.Encryption = $response[$i+3].Split(":")[1].Trim()
        $report
    }
    IF ($SSID) {
        $wLANs | Where-Object {$_.SSID -eq $SSID}
    }
    ELSE {
        $wLANs
    }
}



netsh wlan connect ssid=aveil-engin name=aveil-engin # Connect to a saved Wifi Network

netsh wlan connect ssid="YOURSSID" key="YOURPW" # Conenct to a new Wifi Network



netsh wlan set profileparameter /?

Usage: set profileparameter [name=]<string> [[interface=]<string>]
       [SSIDname=<string>] [ConnectionType=ESS|IBSS] [autoSwitch=yes|no]
       [ConnectionMode=auto|manual] [nonBroadcast=yes|no]
       [Randomization=[yes|no|daily]]
       [authentication=open|shared|WPA|WPA2|WPAPSK|WPA2PSK]
       [encryption=none|WEP|TKIP|AES] [keyType=networkKey|passphrase]
       [keyIndex=1-4] [keyMaterial=<string>] [PMKCacheMode=yes|no]
       [PMKCacheSize=1-255] [PMKCacheTTL=300-86400] [preAuthMode=yes|no]
       [preAuthThrottle=1-16 [FIPS=yes|no]
       [useOneX=yes|no] [authMode=machineOrUser|machineOnly|userOnly|guest]
       [ssoMode=preLogon|postLogon|none] [maxDelay=1-120]
       [allowDialog=yes|no] [userVLAN=yes|no]
       [heldPeriod=1-3600] [AuthPeriod=1-3600] [StartPeriod=1-3600]
       [maxStart=1-100] [maxAuthFailures=1-100] [cacheUserData = yes|no]
       [cost=default|unrestricted|fixed|variable]