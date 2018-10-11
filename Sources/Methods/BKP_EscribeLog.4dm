//%attributes = {}
  //BKP_EscribeLog

C_TEXT:C284($t_evento;$1)
C_LONGINT:C283($l_lineasLog)
$t_evento:=$1

$l_lineasLog:=500
If (Undefined:C82(<>atBKP_LOG))
	ARRAY TEXT:C222(<>atBKP_LOG;0)
End if 

If (Application type:C494#4D Remote mode:K5:5)
	If (Size of array:C274(<>atBKP_LOG)=$l_lineasLog)
		AT_Delete ($l_lineasLog;1;-><>atBKP_LOG)
	End if 
	AT_Insert (1;1;-><>atBKP_LOG)
	<>atBKP_LOG{1}:=DTS_MakeFromDateTime +": "+$t_evento
End if 
