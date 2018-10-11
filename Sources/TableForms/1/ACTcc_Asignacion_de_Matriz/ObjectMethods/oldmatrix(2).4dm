If (Self:C308->>0)
	vsACT_AsignedMatrix2:=Self:C308->{Self:C308->}
End if 
If (vsACT_AsignedMatrix2#"")
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