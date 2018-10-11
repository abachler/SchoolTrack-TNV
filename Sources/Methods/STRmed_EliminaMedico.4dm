//%attributes = {}
  //STRmed_EliminaMedico

$id:=$1

READ WRITE:C146([STR_Medicos:89])
$rn:=Find in field:C653([STR_Medicos:89]ID:3;$id)
If ($rn#-1)
	GOTO RECORD:C242([STR_Medicos:89];$rn)
	If (Locked:C147([STR_Medicos:89]))
		$0:=False:C215
	Else 
		DELETE RECORD:C58([STR_Medicos:89])
		$0:=True:C214
	End if 
Else 
	$0:=True:C214
End if 
KRL_UnloadReadOnly (->[STR_Medicos:89])