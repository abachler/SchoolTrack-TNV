vbSpell_StopChecking:=True:C214
C_LONGINT:C283($choice)
IT_Clairvoyance (Self:C308;->atACTcc_MatrixName;"";False:C215)
If (Form event:C388=On Data Change:K2:15)
	$choice:=Find in array:C230(<>atACT_MatrixName;Self:C308->)
	If ($choice#-1)
		Self:C308->:=<>atACT_MatrixName{$choice}
	Else 
		Self:C308->:="Ninguna"
	End if 
End if 

If ((vsACT_AsignedMatrix2#"") & (vsACT_AsignedMatrix2#"Ninguna"))
	SET_UseSet ("Selection")
	$idmatriz:=<>alACT_MatrixID{Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix2)}
	QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=$idmatriz)
Else 
	QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=0)
End if 
viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
If (viACT_cuentas=0)
	_O_DISABLE BUTTON:C193(bNext)
Else 
	_O_ENABLE BUTTON:C192(bNext)
End if 