//%attributes = {}
  //DTS_MakeFromDateTime

C_DATE:C307($1;$date)
C_TIME:C306($2;$time)
_O_C_STRING:C293(8;$dateStr)
_O_C_STRING:C293(6;$timeStr)
_O_C_STRING:C293(14;$0;$dts)

Case of 
	: (Count parameters:C259=2)
		$date:=$1
		$time:=$2
	: (Count parameters:C259=1)
		$date:=$1
		$time:=Current time:C178(*)
	Else 
		$date:=Current date:C33(*)
		$time:=Current time:C178(*)
End case 

$dateStr:=String:C10(Year of:C25($date);"0000")+String:C10(Month of:C24($date);"00")+String:C10(Day of:C23($date);"00")
$timeStr:=Replace string:C233(String:C10($time;HH MM SS:K7:1);":";"")
$dts:=$dateStr+$timeStr
$0:=$dts