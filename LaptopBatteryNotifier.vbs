' Lithium Ion Battery Life Tips:
' https://www.howtogeek.com/169669/debunking-battery-life-myths-for-mobile-phones-tablets-and-laptops/
' https://batteryuniversity.com/index.php/learn/article/how_to_prolong_lithium_based_batteries

' complete VBS script source: https://thegeekpage.com/battery-full-charged-notification-in-windows-10/

set locator = CreateObject("WbemScripting.SWbemLocator")
set wmiServices = locator.ConnectServer(".","root\wmi")
set capacityResults = wmiServices.ExecQuery("select * from batteryfullchargedcapacity")

fullCapacity = 0
for each capacityResult in capacityResults
  fullCapacity = fullCapacity + capacityResult.FullChargedCapacity
next

' Source of "vbExclamation" :
' https://devblogs.microsoft.com/scripting/how-can-i-play-a-sound-each-time-a-message-box-is-displayed/
' Source of else if statement's syntax:
' https://www.promotic.eu/en/pmdoc/ScriptLangs/VBScript/Statmn/IfThenElse.htm

while (1)
  set capacityResults = wmiServices.ExecQuery("select * from batterystatus")

  ' accessing 1st battery.
  ' source: https://stackoverflow.com/a/2378839
  ' remaining = capacityResults.ItemIndex(0).RemainingCapacity
  ' isCharging = capacityResults.ItemIndex(0).Charging

  isCharging = 0
  remaining = 0

  for each capacityResult in capacityResults
    remaining = remaining + capacityResult.RemainingCapacity
    If (capacityResult.Charging) Then
      isCharging = capacityResult.Charging
    End If
  next

  batteryPercentage = ((remaining / fullCapacity) * 100) mod 100

  If (isCharging) and (batteryPercentage > 95) Then
    msgbox batteryPercentage& "% charged. REMOVE CHARGER !", vbExclamation, "Warning!"
  ElseIf (not isCharging) and (batteryPercentage < 20) Then
    msgbox batteryPercentage& "% battery remaining. CHARGE LAPTOP !", vbExclamation, "Warning!"
  End If

  wscript.sleep 1000*60*5 ' 5 minutes (in miliseconds)
wend
