//%attributes = {}
  //ACTut_fFechaValida

C_DATE:C307($0;$1;$date)
C_LONGINT:C283($day;$month;$year)
$date:=$1
$day:=Day of:C23($Date)
$month:=Month of:C24($Date)
$year:=Year of:C25($Date)

$lastDay:=DT_GetLastDay2 ($date)
If ($Day>$lastDay)
	$day:=$lastDay
End if 
$date:=DT_GetDateFromDayMonthYear ($day;$month;$year)

$dayNumber:=Day number:C114($date)
If ($dayNumber=1)
	$date:=$date+1
End if 

While ((Month of:C24($Date)>$month) | (Year of:C25($Date)>$year) | (Day number:C114($date)=1))
	$Date:=$date-1
End while 

$0:=$date