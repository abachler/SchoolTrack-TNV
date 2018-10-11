//%attributes = {}
  //IT_WaitForTime

C_TIME:C306($1;$time)
$time:=$1
While ((Current time:C178<$time) & (vStop=False:C215))
	$secs:=($time-Current time:C178)*1
	If (Not:C34(vStop))
		DELAY PROCESS:C323(Current process:C322;($secs*60))
	End if 
End while 