::cmd /k wmic nic get name, index
::to check index no. first

:: then, to disable:
wmic path win32_networkadapter where index=7 call disable

:: to enable:
wmic path win32_networkadapter where index=7 call enable