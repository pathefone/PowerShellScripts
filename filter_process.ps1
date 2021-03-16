#----------------------------------------------
#<Script name> was created by <Name> <Surname>
#<Script definition>
#----------------------------------------------

#----------------------------------------------
#--------------------Fields--------------------
#----------------------------------------------


#----------------------------------------------
#--------------------Functions-----------------
#----------------------------------------------

Function FilterProcess {
       Write-Host "*Filtering by the number of handles the process has opened*" -ForegroundColor Yellow
       $parameter = Read-Host "Enter maximum handles for a process "

    try {
        New-Item -Path . -Name "logs" -ItemType "directory" -ErrorAction Stop
    }
    catch {
        Write-Host "Logs dir already exists, no action" -ForegroundColor Gray
    }

    while(1) {
        Get-Process | Where-Object { $_.HANDLES -lt $parameter }
        $fileNameDate = Get-Date -Format "yyyyMMDD_HHmmss"

        $fileCount = ( Get-ChildItem .\logs | Measure-Object ).Count;

        #deleting oldest log file
        if($fileCount -eq 5) {
            Get-ChildItem .\logs | Sort CreationTime | Select -First 1 | Remove-Item
        }

        Get-Process | Where-Object { $_.HANDLES -gt $parameter } | Format-Table Handles, Name, Id -AutoSize | `
        Out-File -FilePath .\logs\FilteredProcessList_$fileNameDate.csv

        Start-Sleep -Seconds 30
        Write-Host "*Updating..*" -ForegroundColor Yellow
    }


}


#----------------------------------------------
#-------------------Execution code-------------
#----------------------------------------------








