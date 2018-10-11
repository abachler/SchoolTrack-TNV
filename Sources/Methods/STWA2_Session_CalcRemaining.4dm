//%attributes = {}
C_LONGINT:C283($1;$2;$currTime;$lastSeen)

$currTime:=$1
$lastSeen:=$2

$dif:=$currTime-$lastSeen
If ($dif<0)
	$dif:=$dif+86400
End if 
$0:=$dif