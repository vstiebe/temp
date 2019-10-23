# Self-elevate the script if required
# Source: http://www.expta.com/2017/03/how-to-self-elevate-powershell-script.html
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
     $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
     Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
     Exit
    }
   }

# Rename all entries for my order
Get-ChildItem HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellIconOverlayIdentifiers | Where-Object { $_.Name -like '*Dropbox*' -or $_.Name -like '*Tortoise*' }  | ForEach-Object {
    $Name = (Split-Path $_.PSPath -Leaf).ToString().Trim()
    if ($Name -like 'Dropbox*') { 
        $Name = " $Name" 
    } elseif ($Name -like 'Tortoise*') { 
        $Name = "  $Name" 
    } else { 
        $Name = '' 
    }
    if ($Name -ne '') { 
        Rename-Item -Path $_.PSPath -NewName $Name -ErrorAction SilentlyContinue
    }
}

# Restart explorer
Stop-Process -ProcessName Explorer
