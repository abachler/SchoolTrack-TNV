//%attributes = {}
  //TM_Get_Seconds

C_TIME:C306($1;$time)

$time:=$1
$0:=0
If ($time#?00:00:00?)
	$0:=$time%60
End if 