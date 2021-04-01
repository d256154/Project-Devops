# Stop-ScheduledTask -Taskname "notepad"
# Disable-ScheduledTask -Taskname "notepad"
# Unregister-ScheduledTask -Taskname "notepad" -Confirm:$false

#$action = New-ScheduledTaskAction -Execute "node" -Argument "C:/scripts/task.js"
#$now = Get-Date
#$interval = New-TimeSpan -Seconds 60
#$forever = [System.TimeSpan]::MaxValue
#$trigger = New-ScheduledTaskTrigger -Once -At ($now) -RepetitionInterval $interval 
#$settings = New-ScheduledTaskSettingsSet
#$task = New-ScheduledTask -Action $action -Trigger $trigger -Settings $settings
#Register-ScheduledTask -Taskname 'TEST' -InputObject $task

# “Create-Task” which creates a new task on the task-scheduler.
# “Change-TaskStatus” which disables or enables a task in task scheduler by name.
# “Get-AllTasks” which get a list of all your tasks running on task scheduler.

# Implement the following logic into your script:
# Create a task with the “CreateTask” function with the following details:
# Task name: {receive it as parameter}
# Executable: “c:\mytask.ps1”
# Run the script every: “1 minute”.

# Implement the following logic into your script:
# Wait X seconds, {received as parameter} (after the task is created as explained in part 3)
# Disable the task with the “Change-TaskStatus” function.

# Implement the following logic into your script:
# Get all task’s full names with the “Get-AllTasks” function
# Clean the result if needed before print it to the console
# The output should be as shown in the expected result:

# Create a new task action
# -WindowStyle Hidden -NonInteractive -Executionpolicy unrestricted
#Set-ExecutionPolicy Unrestricted -Force
#"-executionpolicy bypass -noprofile -file $scriptPath"

#param ([Parameter(Mandatory=$true)][String]$Taskname,[Parameter(Mandatory=$true)][int]$WaitSeconds);


function Create-Task(){
    
    # Create a new Action
    $taskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-executionpolicy bypass -noprofile -file c:\Users\ym\Project\1\mytask.ps1"

    # Create a new trigger (Daily every minute)
    $taskTrigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1)
    
    # Register the scheduled task
    Register-ScheduledTask -Taskname $Taskname -Action $taskAction -Trigger $taskTrigger
    Start-ScheduledTask $Taskname  
}



function Change-TaskStatus($Status){
    
    # disables or enables a task
    if ($Status -eq "Stop") {Get-ScheduledTask -Taskname "$Taskname" | Disable-ScheduledTask}
    if ($Status -eq "Start") {Get-ScheduledTask -Taskname "$Taskname" | Enable-ScheduledTask}
}


function Get-AllTasks (){
    
    # Get all Running Tasks
    #clear
    (Get-ScheduledTask).Taskname # | sort | Out-GridView

}

#$Taskname = "notepad"
#$WaitSeconds = 10

# Call Func start new Task
Create-Task
sleep -Seconds $WaitSeconds

# Show Task status and stop it
(Get-ScheduledTask -Taskname "$Taskname").State 
Change-TaskStatus -Status "Stop"
(Get-ScheduledTask -Taskname "$Taskname").State
sleep -Seconds 10
# Show all Task
Get-AllTasks
sleep -Seconds 10

# Stop and Delete Task
Stop-ScheduledTask -TaskName $Taskname -ErrorAction Ignore
Unregister-ScheduledTask -Taskname $Taskname -Confirm:$false -ErrorAction Ignore
