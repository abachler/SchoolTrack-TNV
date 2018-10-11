//%attributes = {}
  //st_Mac2Win

  //Èste metodo transforma ascii de mac a win si estamos en ambiente windows
C_TEXT:C284($0;$1)
If (SYS_IsWindows )
	$0:=_O_Mac to Win:C463($1)
Else 
	$0:=$1
End if 