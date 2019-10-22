Register-WmiEvent -Class win32_VolumeChangeEvent -SourceIdentifier volumeChange
do {
	$newEvent = Wait-Event -SourceIdentifier volumeChange
	$eventType = $newEvent.SourceEventArgs.NewEvent.EventType
	$eventTypeName = switch($eventType)
	{
		1 {"Configuration changed"}
		2 {"Device arrival"}
		3 {"Device removal"}
		4 {"docking"}
	}
	if($eventType -eq 2)
	{
		taskkill /IM any-application.exe /f
	}
	Remove-Event -SourceIdentifier volumeChange
} while (1-eq1)
Unregister-Event -SourceIdentifier volumeChange
