//%attributes = {}
  //st_Mac2Iso

  //Èste metodo transforma ascii de mac a iso si estamos en ambiente mac
C_TEXT:C284($0;$1)
If (SYS_IsMacintosh )
	$0:=_O_Mac to ISO:C519($1)
Else 
	$0:=$1
End if 