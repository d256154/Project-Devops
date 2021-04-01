#Set-ExecutionPolicy Unrestricted -Force
del c:\Users\ym\Project\1\test.txt -Force -ErrorAction Ignore
$a="I love the bootcamp!"
New-Item -Name test.txt -Path c:\Users\ym\Project\1 -ItemType File -Force
$a | Out-File -FilePath c:\Users\ym\Project\1\test.txt
Start-Process 'C:\windows\system32\notepad.exe' c:\Users\ym\Project\1\test.txt
sleep -Seconds 10
stop-process -name 'notepad' -Force -ErrorAction Ignore
