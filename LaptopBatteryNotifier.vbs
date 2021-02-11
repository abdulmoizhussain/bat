' Lithium Ion Battery Life Tips:
' https://www.howtogeek.com/169669/debunking-battery-life-myths-for-mobile-phones-tablets-and-laptops/
' https://batteryuniversity.com/index.php/learn/article/how_to_prolong_lithium_based_batteries

' complete VBS script source: https://thegeekpage.com/battery-full-charged-notification-in-windows-10/

set locator = CreateObject("WbemScripting.SWbemLocator")
set wmiServices = locator.ConnectServer(".","root\wmi")
set capacityResults = wmiServices.ExecQuery("select * from batteryfullchargedcapacity")
for each capacityResult in capacityResults
   fullCapacity = capacityResult.FullChargedCapacity
next

' Source of "vbExclamation" :
' https://devblogs.microsoft.com/scripting/how-can-i-play-a-sound-each-time-a-message-box-is-displayed/
' Source of else if statement's syntax:
' https://www.promotic.eu/en/pmdoc/ScriptLangs/VBScript/Statmn/IfThenElse.htm

while (1)
  set capacityResults = wmiServices.ExecQuery("select * from batterystatus")

  ' accessing 1st battery.
  ' source: https://stackoverflow.com/a/2378839
  remaining = capacityResults.ItemIndex(0).RemainingCapacity
  isCharging = capacityResults.ItemIndex(0).Charging

  'for each capacityResult in capacityResults
  '  remaining = capacityResult.RemainingCapacity
  '  isCharging = capacityResult.Charging
  'next

  batteryPercentage = ((remaining / fullCapacity) * 100) mod 100
  If (isCharging) and (batteryPercentage > 90) Then
    msgbox batteryPercentage& "% charged. REMOVE CHARGER !", vbExclamation, "Warning!"
  ElseIf (not isCharging) and (batteryPercentage < 25) Then
    msgbox batteryPercentage& "% battery remaining. CHARGE LAPTOP !", vbExclamation, "Warning!"
  End If

  wscript.sleep 300000 ' 5 minutes (in miliseconds)
wend