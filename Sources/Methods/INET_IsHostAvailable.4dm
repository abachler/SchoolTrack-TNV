//%attributes = {}
  // INET_IsHostAvailable()
  //
  //
  // creado por: Alberto Bachler Klein: 31-01-16, 19:08:03
  // -----------------------------------------------------------
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($l_conexionAvailable;$l_error;$l_Idconexion;$l_ms;$l_puerto;$l_timeOutActual)
C_TEXT:C284($t_host)


If (False:C215)
	C_BOOLEAN:C305(INET_IsHostAvailable ;$0)
	C_TEXT:C284(INET_IsHostAvailable ;$1)
	C_LONGINT:C283(INET_IsHostAvailable ;$2)
End if 

$t_host:=$1
$l_puerto:=80
$l_timeout:=3
Case of 
	: (Count parameters:C259=3)
		$l_timeOut:=$3
		$l_puerto:=$2
	: (Count parameters:C259=2)
		$l_puerto:=$2
End case 

$l_puerto:=Choose:C955($l_puerto=0;80;$l_puerto)

$l_error:=IT_GetTimeOut ($l_timeOutActual)
$l_error:=IT_SetTimeOut (3)
$l_error:=TCP_Open ($t_host;$l_puerto;$l_Idconexion)
If ($l_Idconexion#0)
	TCP_Close ($l_Idconexion)
	$0:=True:C214
End if 
$l_timeOutActual:=IT_SetTimeOut ($l_timeOutActual)



