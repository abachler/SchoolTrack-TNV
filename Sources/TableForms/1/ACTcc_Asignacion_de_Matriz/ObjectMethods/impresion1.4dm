If (Size of array:C274(atACT_MAtrixNameCopy)<=50)
	$choice:=Pop up menu:C542(vt_Matrices)
	If ($choice>0)
		If ($choice=1)
			vsACT_AsignedMatrix2:="Ninguna"
		Else 
			vsACT_AsignedMatrix2:=atACT_MatrixNameCopy2{$choice-2}
			atACT_MatrixNameCopy2:=$choice-2
		End if 
	End if 
Else 
	ARRAY POINTER:C280(<>aChoicePtrs;0)
	ARRAY POINTER:C280(<>aChoicePtrs;1)
	<>aChoicePtrs{1}:=->atACTcc_MatrixName
	TBL_ShowChoiceList (1;"Seleccione la Matriz";1;->vsACT_AsignedMatrix2)
	If (ok=1)
		vsACT_AsignedMatrix2:=atACTcc_MatrixName{choiceIdx}
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