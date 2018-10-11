//%attributes = {}
  //UD_v20110407_ACTCtasVacias

ARRAY LONGINT:C221(aQR_Longint1;0)
C_LONGINT:C283($pID;$i;$recNumCta)

READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Alumnos:2])

$pID:=IT_UThermometer (1;0;"Eliminando cuentas corrientes sin datos asociados...")

QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
CREATE SET:C116([ACT_CuentasCorrientes:175];"setCtasCtesTodas")
KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;"")
CREATE SET:C116([ACT_CuentasCorrientes:175];"setCtasCtesConAlumnos")
DIFFERENCE:C122("setCtasCtesTodas";"setCtasCtesConAlumnos";"setCtasCtesTodas")
USE SET:C118("setCtasCtesTodas")
SET_ClearSets ("setCtasCtesTodas";"setCtasCtesConAlumnos")

LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];aQR_Longint1;"")
For ($i;1;Size of array:C274(aQR_Longint1))
	$recNumCta:=aQR_Longint1{$i}
	GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNumCta)
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
	KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
	KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
	If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=0)
		GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNumCta)
		START TRANSACTION:C239
		KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
		KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
		KRL_DeleteSelection (->[ACT_Documentos_de_Cargo:174])
		If (OK=1)
			GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNumCta)
			KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")
			KRL_DeleteSelection (->[ACT_Cargos:173])
		End if 
		If (OK=1)
			GOTO RECORD:C242([ACT_CuentasCorrientes:175];$recNumCta)
			KRL_DeleteSelection (->[ACT_CuentasCorrientes:175])
		End if 
		If (OK=1)
			VALIDATE TRANSACTION:C240
		Else 
			CANCEL TRANSACTION:C241
		End if 
	End if 
End for 
IT_UThermometer (-2;$pID)