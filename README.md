# .bat
Some Windows and Linux script files of regular use.

Will need to execute some files with Administrator.

<br />

- `LaptopBatteryNotifier.sh` is for Linux OS.
- `LaptopBatteryNotifier.vbs` is for Windows OS.

<br />

## To run `LaptopBatteryNotifier.sh` at system-startup in background:

- Search for `Startup Applications Preferences`
- Click `Add` to create a new `Additional startup program`
- Browse for the the Linux script file and select `LaptopBatteryNotifier.sh`
- Now modify the command:
    - <pre>/home/username/LaptopBatteryNotifier.sh</pre>
    - to this:
    - <pre><b>bash</b> /home/username/LaptopBatteryNotifier.sh</pre>
    - coz this script needs to be executed with bash.
- Can name it like: Battery Notifier
- Now the script will be automatically started in background upon next restart.

### Optional:
- If you want to modify the reminding-interval, minimum-battery and maximum-battery, you can modify these variables `sleep_time_in_seconds`, `low_battery__percent` and `full_battery_percent` respectively.
- You can also disable the notifications by commenting out the `notify-send ...` commands.
