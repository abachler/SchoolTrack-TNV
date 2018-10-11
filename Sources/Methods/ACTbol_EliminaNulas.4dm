//%attributes = {}
  //ACTbol_EliminaNulas

$idBol:=$1
$0:=True:C214

$found:=Find in field:C653([ACT_Boletas:181]ID:1;$idBol)
If ($found#-1)
	READ WRITE:C146([ACT_Boletas:181])
	GOTO RECORD:C242([ACT_Boletas:181];$found)
	If (Not:C34(Locked:C147([ACT_Boletas:181])))
		If ([ACT_Boletas:181]Nula:15)  //20130902 RCH Se agrega condicion porque no se puede eliminar boletas no nulas
			DELETE RECORD:C58([ACT_Boletas:181])
		End if 
	Else 
		$0:=False:C215
	End if 
	KRL_UnloadReadOnly (->[ACT_Boletas:181])
End if 