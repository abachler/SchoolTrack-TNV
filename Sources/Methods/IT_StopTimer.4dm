//%attributes = {}
  //IT_StopTimer

C_REAL:C285($InitilaTime;$Inmilliseconds;$1)
C_TEXT:C284($Msg)
$InitilaTime:=$1
$EndTime:=Milliseconds:C459

$Inmilliseconds:=$EndTime-$InitilaTime
$Hours:=Trunc:C95($Inmilliseconds/3600000;0)
$Remainder:=$Inmilliseconds-($Hours*3600000)
$Minutes:=Trunc:C95($Remainder/60000;0)
$Remainder:=$Remainder-($Minutes*60000)
$Seconds:=Trunc:C95($Remainder/1000;0)
$Remainder:=$Remainder-($Seconds*1000)
$Milliseconds:=Trunc:C95($Remainder;0)

Case of 
	: ($Hours>0)
		$Msg:="El proceso tomó "+String:C10($Hours)+" horas, "+String:C10($Minutes)+" minutos, "+String:C10($Seconds)+" segundos y "+String:C10($Milliseconds)+" milisegundos."
	: ($Minutes>0)
		$Msg:="El proceso tomó "+String:C10($Minutes)+" minutos, "+String:C10($Seconds)+" segundos y "+String:C10($Milliseconds)+" milisegundos."
	: ($Seconds>0)
		$Msg:="El proceso tomó "+String:C10($Seconds)+" segundos y "+String:C10($Milliseconds)+" milisegundos."
		  //: ($Milliseconds>0)
	Else 
		$Msg:="El proceso tomó "+String:C10($Milliseconds)+" milisegundos."
End case 

ALERT:C41($Msg)