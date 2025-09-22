function Register-PSGallery {
    [CmdletBinding()]
    param ()
    $psRepository = Get-PSRepository -Name PSGallery -ErrorAction Ignore
    if (!$psRepository -or !$psRepository.Trusted) {
        Unregister-PSRepository PSGallery -ErrorAction Ignore
        Register-PSRepository -Default -InstallationPolicy Trusted
    }
}

function Format-PSModuleInput {
    [CmdletBinding()]
    param (
        [string]$Modules
    )

    $modulesString = $Modules -split "`n"
    | ForEach-Object { $_ -replace " ", "" -replace ":latest$", "::" }
    | Where-Object { $_ }
    | ForEach-Object { if ($_ -notmatch ":") { "$_::" } else { $_ } }
    | Join-String -Separator ','
    
    return $modulesString
}