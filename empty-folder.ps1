function emptyFolderFind
{
    param
    (
        $folder,
        [Switch]$Recurse,
        [Switch]$NewEmptyFile,
        [Switch]$Delete
    )

    if($Recurse)
    {
        $a = Get-ChildItem $folder -Recurse | Where-Object {$_.PSIsContainer -eq $True}   
        Write-Host "true " $a
    }
    else
    {
        $a = Get-ChildItem $folder | Where-Object {$_.PSIsContainer -eq $True}
        Write-Host "false " $a
    }

    $b = $a | Where-Object {($_.GetFiles().Count -eq 0) -and ($_.GetDirectories().Count -eq 0)}
    $b | Select-Object FullName    

    Write-Host "Curr DIR " $b

    if ($NewEmptyFile -and $b)
    {
        New-Item -Path $b -Name .gitkeep -ItemType file
        Write-Host "Created Empty File!!"
    }   

    if ($Delete -and $b)
    {
        $b | Remove-Item -Force
        Write-Host "Deleted Empty folder!!"
    }    
}