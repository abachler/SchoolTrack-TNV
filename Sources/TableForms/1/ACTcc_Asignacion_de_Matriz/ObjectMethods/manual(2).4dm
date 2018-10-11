QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
ACTcc_QuitarAdmision 
CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
viACT_cuentas3:=Records in selection:C76([ACT_CuentasCorrientes:175])
Case of 
	: (r1=1)
		QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=0)
		viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
	: (r2=1)
		If ((vsACT_AsignedMatrix2#"") & (vsACT_AsignedMatrix2#"Ninguna"))
			$idmatriz:=<>alACT_MatrixID{Find in array:C230(<>atACT_MatrixName;vsACT_AsignedMatrix2)}
			QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=$idmatriz)
			viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
		Else 
			QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Matriz:7=0)
			viACT_cuentas:=Records in selection:C76([ACT_CuentasCorrientes:175])
		End if 
	: (r3=1)
		viACT_cuentas:=viACT_cuentas3
End case 
