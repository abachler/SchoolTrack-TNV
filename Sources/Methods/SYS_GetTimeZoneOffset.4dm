//%attributes = {}
  //SYS_GetTimeZoneOffset

C_TIME:C306($GMT_time;$LOCAL_Time)
C_LONGINT:C283($offset)
$date:=Current date:C33(*)
$time:=Current time:C178(*)
$dts:=DTS_Get_GMT_TimeStamp ($date;$time)

$GMT_Date:=DTS_GetDate ($dts)
$GMT_time:=DTS_GetTime ($dts)

$LOCAL_Date:=$date
$LOCAL_Time:=$time

  //$LOCAL_Time:=$LOCAL_Time+(5*60*60)

Case of 
	: ($LOCAL_date<$GMT_Date)
		
	: ($LOCAL_date>$GMT_Date)
		
	: ($GMT_time=$LOCAL_Time)
		$offset:=0
	: ($GMT_time#$LOCAL_Time)
		$offset:=$LOCAL_Time-$GMT_time/60/60
End case 