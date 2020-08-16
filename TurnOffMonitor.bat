REM source: https://www.codeproject.com/Articles/12794/Complete-Guide-on-How-To-Turn-A-Monitor-On-Off-Sta
powershell (Add-Type '[DllImport(\"user32.dll\")]^public static extern int SendMessage(int hWnd, int hMsg, int wParam, int lParam);' -Name a -Pas)::SendMessage(-1,0x0112,0xF170,2)
