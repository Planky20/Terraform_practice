Import-Module servermanager
Add-WindowsFeature web-server -IncludeAllSubFeature
Set-Content -PassThru "C:\inetpub\wwwroot\Default.html" -Value "This is the server $($env:COMPUTERNAME)"