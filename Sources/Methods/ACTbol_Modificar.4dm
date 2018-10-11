//%attributes = {}
  //ACTbol_Modificar

$0:=True:C214
idBol:=0
NumBol:=0
FechaBol:=!00-00-00!

ST_Deconcatenate (";";$1;->idBol;->NumBol;->FechaBol)
$found:=Find in field:C653([ACT_Boletas:181]ID:1;idBol)
If ($found#-1)
	READ WRITE:C146([ACT_Boletas:181])
	GOTO RECORD:C242([ACT_Boletas:181];$found)
	If (Not:C34(Locked:C147([ACT_Boletas:181])))
		[ACT_Boletas:181]Numero:11:=NumBol
		[ACT_Boletas:181]FechaEmision:3:=FechaBol
		SAVE RECORD:C53([ACT_Boletas:181])
	Else 
		$0:=False:C215
	End if 
	KRL_UnloadReadOnly (->[ACT_Boletas:181])
End if 