//%attributes = {}
C_TIME:C306($1;$t1;$t2)
C_LONGINT:C283($0)
C_REAL:C285($conversionFactor)

$t2:=Current time:C178(*)
$t1:=$1
$conversionFactor:=1000

If (Count parameters:C259=2)
	$conversionFactor:=$2
End if 

$td:=$t2-$t1

If ($td<0)
	$td:=$td+?24:00:00?
End if 

$0:=$td*$conversionFactor