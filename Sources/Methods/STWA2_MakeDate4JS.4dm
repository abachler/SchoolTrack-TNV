//%attributes = {}
C_DATE:C307($1;$date)

$date:=$1
$separator:="/"
If (Count parameters:C259=2)
	$separator:=$2
End if 

$day:=Day of:C23($date)
$month:=Month of:C24($date)
$year:=Year of:C25($date)

$dateStr:=String:C10($month)+$separator+String:C10($day)+$separator+String:C10($year;"#####0000")

$0:=$dateStr