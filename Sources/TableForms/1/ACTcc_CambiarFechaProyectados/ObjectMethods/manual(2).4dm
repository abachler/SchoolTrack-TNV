QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
If (r2=1)
	If (vsACT_AsignedMatrix2#"")
		$idmatriz:=<>alACT_MatrixID{Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix2)}
		QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=$idmatriz)
		CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
		viACT_cuentas5:=Records in selection:C76([ACT_CuentasCorrientes:175])
	Else 
		viACT_cuentas5:=0
	End if 
	OBJECT SET COLOR:C271(viACT_cuentas4;-12)
	OBJECT SET COLOR:C271(viACT_cuentas5;-3)
Else 
	viACT_cuentas4:=viACT_cuentas3
	OBJECT SET COLOR:C271(viACT_cuentas4;-3)
	OBJECT SET COLOR:C271(viACT_cuentas5;-12)
End if 