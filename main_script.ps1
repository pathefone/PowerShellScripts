#----------------------------------------------
#Main script was created by Lukas Razukevicius
#This is the main script
#----------------------------------------------

Import-Module -Name ".\search_kill.ps1" -Verbose

Import-Module -Name ".\filter_process.ps1" -Verbose

#----------------------------------------------
#--------------------Functions-----------------
#----------------------------------------------

Function UpdateRegistry {

Write-Host "Updating registry..." -ForegroundColor Yellow

$formattedDate = Get-Date -Format "yyyy-MM-dd HH:mm"

New-Item -Path HKCU:SOFTWARE\PowershellScriptRunTime -Force

New-ItemProperty -Path "HKCU:SOFTWARE\PowershellScriptRunTime" `
 -Name "RunTime" -Value "$formattedDate" -PropertyType "String"

 Write-Host "Successfully updated" -ForegroundColor Green

}


#----------------------------------------------
#-------------------Execution code-------------
#----------------------------------------------


UpdateRegistry

    while(1) {

        Write-Host "Welcome to the script."
        Write-Host "To kill/search for a process press 1"
        Write-Host "To filter processes and write logs press 2"
        Write-Host "To exit the program press 0"
        $cliOption = Read-Host "Your option"

        if($cliOption -eq 1) {
             Write-Host "* | Press 1 to perform search by process name* |  *Press 2 to perform search by ID* | " `
             -foregroundcolor "Red"

              $option = Read-Host "Your option"
              GetProcess($option)

        }
        elseif($cliOption -eq 2) {
            FilterProcess
        }
        elseif($cliOption -eq 0) {
            Write-Host "Exiting..." -ForegroundColor Red
            break
        }
        $cliOption = 0
}





