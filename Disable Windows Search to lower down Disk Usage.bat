REM First open CMD with Administrator
REM Check Cortana Folder's name properly in your PC then paste here, in last command:

taskkill /F /IM Cortana.exe
taskkill /F /IM SearchUI.exe
taskkill /F /IM RuntimeBroker.exe
taskkill /F /IM backgroundTaskHost.exe
ren "C:\Windows\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy" "Microsoft.Windows.Cortana_cw5n1h2txyewy.bak"