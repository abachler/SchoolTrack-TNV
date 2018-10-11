//%attributes = {}
  //DT_GetDayNumber_ISO8601

$date:=$1
If (Day number:C114($date)=1)
	$dayNumber:=7
Else 
	$dayNumber:=Day number:C114($date)-1
End if 
$0:=$dayNumber