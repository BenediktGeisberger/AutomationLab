#### Disable Internet Explorer ESC
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force
Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force
Stop-Process -Name Explorer -Force

### Install NuGet Provider
Install-PackageProvider -Name "NuGet" -Confirm:$false -Force -Verbose


### Install Azure Powershell Module
Install-Module -Name Az -AllowClobber -Confirm:$false -Force -Verbose

### Create TMP Folder
New-Item -ItemType directory -Name "tmp" -Path "C:\"

### Download and Install Chrome
$url = "https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7BF92B05EC-4A3F-247E-FC17-3F53487B0893%7D%26lang%3Dde%26browser%3D3%26usagestats%3D1%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-stable-statsdef_1%26installdataindex%3Dempty/update2/installers/ChromeSetup.exe"
$output = "C:\tmp\ChromeSetup.exe"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
Start-Process -FilePath 'C:\tmp\ChromeSetup.exe' -ArgumentList "/silent /install"

### Download and Install Azure Storage Explorer
$url = "https://download.microsoft.com/download/A/E/3/AE32C485-B62B-4437-92F7-8B6B2C48CB40/StorageExplorer.exe"
$output = "C:\tmp\StorageExplorer.exe"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
Start-Process -FilePath 'C:\tmp\StorageExplorer.exe' -ArgumentList "/silent /install"

### Download and Install Git
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = "https://github.com/git-for-windows/git/releases/download/v2.22.0.windows.1/Git-2.22.0-64-bit.exe"
$output = "C:\tmp\Git-2.22.0-64-bit.exe"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
Start-Process -FilePath 'C:\tmp\Git-2.22.0-64-bit.exe' -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /NOCANCEL /SP- /LOG"

### Download and Install Visual Studio Code
$url = "https://az764295.vo.msecnd.net/stable/2213894ea0415ee8c85c5eea0d0ff81ecc191529/VSCodeSetup-x64-1.36.1.exe"
$output = "C:\tmp\VSCodeSetup-x64-1.36.1.exe"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
Start-Process -FilePath 'C:\tmp\VSCodeSetup-x64-1.36.1.exe' -ArgumentList "/VERYSILENT /MERGETASKS=!runcode"

### Download, Extract and Install (Environment Variable) Terraform
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = "https://releases.hashicorp.com/terraform/0.12.3/terraform_0.12.3_windows_amd64.zip"
$output = "C:\tmp\terraform_0.12.3_windows_amd64.zip"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
New-Item -ItemType directory -Name "terraform" -Path "C:\"
Expand-Archive -LiteralPath C:\tmp\terraform_0.12.3_windows_amd64.zip -DestinationPath C:\terraform
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\terraform", [System.EnvironmentVariableTarget]::Machine)