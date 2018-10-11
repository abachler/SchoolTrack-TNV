//%attributes = {}
  // MÉTODO: BMK_TimeStringWithMilliseconds
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 15:31:07
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // BMK_TimeStringWithMilliseconds()
  // ----------------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_LONGINT:C283($l_hours;$l_milliseconds;$l_minutes;$l_seconds)
C_TIME:C306($h_time)
C_TEXT:C284($t_timeString)

If (False:C215)
	C_TEXT:C284(BMK_TimeStringWithMilliseconds ;$0)
	C_LONGINT:C283(BMK_TimeStringWithMilliseconds ;$1)
End if 



  // CODIGO PRINCIPAL
$l_milliseconds:=$1

If ($l_milliseconds>=999)
	$l_seconds:=Int:C8($l_milliseconds/1000)
	$h_time:=Int:C8($l_seconds)
	$l_hours:=Int:C8($l_seconds/60/60)
	$l_minutes:=Int:C8($h_time-($l_hours*60*60)/60)
	
	Case of 
		: ($l_hours>0)
			$t_timeString:=Time string:C180($l_seconds)
			
		: ($l_minutes>0)
			$t_timeString:=Time string:C180($l_seconds)+" ("+String:C10($l_milliseconds;"### ### ms)")
			
		: ($l_seconds>0)
			$t_timeString:=String:C10($l_milliseconds/1000;"##0,000")+" ("+String:C10($l_milliseconds;"### ### ms)")
			
	End case 
	
Else 
	$t_timeString:=String:C10($l_milliseconds;"##0 ms")
End if 
$0:=$t_timeString

