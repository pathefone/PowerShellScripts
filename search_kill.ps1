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


Function GetProcess($option) {

    $errorValue = 1;

    try {
        if($option -eq 1) {
            $processName = Read-Host "Please enter process name"
            Get-Process $processName -ErrorAction Stop
        }
    }
    catch {
        Write-Host "The process you entered doesn't exist" -foregroundcolor "Red" "`r`n"
        Write-Host "Available process name list (running):" -foregroundcolor "Green"
        Get-Process | Select-Object Name | Format-Wide -Column 5 
        $errorValue = 0;
    }

    #if process found kill by name
    if(($errorValue -ne 0) -and ($option -eq 1)) {
        Write-Host "*If you want to kill the process press 1*"
        Write-Host "*To exit press 0*"
        $optionKill = Read-Host "Your option"

        if($optionKill -eq 1){
            Stop-Process -Name "$processName"
            Write-Host "Process $processName successfully killed" -ForegroundColor "Green"
        }

    }

#------------------------------------------------------------------------------------------#
    try {
        if($option -eq 2) {
            $processId = Read-Host "Please enter process Id"
            Get-Process -Id $processId -ErrorAction Stop
        }
        elseif(($option -ne 1) -and ($option -ne 2)) {
            Write-Host "Invalid number"
          }
    }
    catch {
        Write-Host "The process Id you entered doesn't exist" -ForegroundColor "Red" "`r`n"
        Write-Host "Available process Id list (running):" -foregroundcolor "Green"
        Get-Process | Select-Object Id | Format-Wide -Column 5 
        $errorValue = 0;
      }

    #if process found kill by id
    if(($errorValue -ne 0) -and ($option -eq 2)) {
        Write-Host "*If you want to kill the process press 1*"
        Write-Host "*To exit press 0*"
        $optionKill = Read-Host "Your option"

        if($optionKill -eq 1) {
            Stop-Process -Id $processId
            $processNameFromId = Get-Process -Id $processId | Select-Object Name
            Write-Host "Process $processNameFromId successfully killed" -ForegroundColor "Green"
        }
    }

 }
#----------------------------------------------
#-------------------Execution code-------------
#----------------------------------------------



