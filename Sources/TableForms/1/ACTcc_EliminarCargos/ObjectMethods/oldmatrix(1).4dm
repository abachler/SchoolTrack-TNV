If (Self:C308->>0)
	vsACT_AsignedMatrix2:=Self:C308->{Self:C308->}
	r2:=1
	r1:=0
	If (vsACT_AsignedMatrix2#"")
		SET_UseSet ("Selection")
		vlACT_SelectedMatrixID:=<>alACT_MatrixID{Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix2)}
		QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=vlACT_SelectedMatrixID)
		viACT_cuentas5:=Records in selection:C76([ACT_CuentasCorrientes:175])
		OBJECT SET COLOR:C271(viACT_cuentas1;-12)
		OBJECT SET COLOR:C271(viACT_cuentas2;-12)
		OBJECT SET COLOR:C271(viACT_cuentas3;-12)
		OBJECT SET COLOR:C271(viACT_cuentas4;-12)
		OBJECT SET COLOR:C271(viACT_cuentas5;-3)
		OBJECT SET VISIBLE:C603(viACT_cuentas5;True:C214)
	Else 
		viACT_cuentas5:=0
		OBJECT SET COLOR:C271(viACT_cuentas1;-12)
		OBJECT SET COLOR:C271(viACT_cuentas2;-12)
		OBJECT SET COLOR:C271(viACT_cuentas3;-12)
		OBJECT SET COLOR:C271(viACT_cuentas4;-12)
		OBJECT SET COLOR:C271(viACT_cuentas5;-12)
		OBJECT SET VISIBLE:C603(viACT_cuentas5;False:C215)
	End if 
End if 
If ((viACT_cuentas5=0) & (r2=1))
	_O_DISABLE BUTTON:C193(bNext)
Else 
	_O_ENABLE BUTTON:C192(bNext)
End if 
