//%attributes = {}
  //FTP_GetSystem

C_TEXT:C284($0;$systemInfo)
C_LONGINT:C283($1;$error)

$error:=FTP_System ($1;$systemInfo)
If ($error=0)
	$0:=$systemInfo
Else 
	$0:="No fue posible obtener informaciones del sistema."
End if 
