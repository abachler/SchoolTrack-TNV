//%attributes = {}
  //ACTpgs_InitArraysDocumentar

C_TEXT:C284($vt_accion;$1)
C_POINTER:C301(${2})
$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="DeclaraArrays")
		ARRAY TEXT:C222(atACT_BancoNombre;0)
		ARRAY TEXT:C222(atACT_BancoCodigo;0)
		ARRAY TEXT:C222(atACT_Cuenta;0)
		ARRAY TEXT:C222(atACT_Titular;0)
		ARRAY TEXT:C222(atACT_RUTTitular;0)
		_O_ARRAY STRING:C218(80;asACT_RUTTitular;0)
		ARRAY TEXT:C222(atACT_Serie;0)
		ARRAY TEXT:C222(atACT_Fecha;0)
		ARRAY DATE:C224(adACT_Fecha;0)
		ARRAY REAL:C219(arACT_MontoCheque;0)
		ARRAY BOOLEAN:C223(abACT_Modificados;0)
		ARRAY LONGINT:C221(alACT_RecNumsAvisos;0)
		ARRAY TEXT:C222(atACT_ObsDoc;0)
		ARRAY TEXT:C222(aCtasApdo;0)
		
		ARRAY REAL:C219(arACT_TempMontos;0)
		ARRAY BOOLEAN:C223(abACT_TempModificados;0)
		
	: ($vt_accion="ArmaBlob")
		SET BLOB SIZE:C606($ptr1->;0)
		BLOB_Variables2Blob ($ptr1;0;->Params;->vrACT_Monto;->atACT_BancoNombre;->atACT_BancoCodigo;->atACT_Cuenta;->atACT_Titular;->atACT_RUTTitular;->asACT_RUTTitular;->atACT_Serie;->atACT_Fecha;->adACT_Fecha;->arACT_MontoCheque;->abACT_Modificados;->alACT_RecNumsAvisos;->atACT_ObsDoc;->aCtasApdo;->arACT_TempMontos;->abACT_TempModificados)
		
	: ($vt_accion="DesarmaBlob")
		BLOB_Blob2Vars ($ptr1;0;->Params;->vrACT_Monto;->atACT_BancoNombre;->atACT_BancoCodigo;->atACT_Cuenta;->atACT_Titular;->atACT_RUTTitular;->asACT_RUTTitular;->atACT_Serie;->atACT_Fecha;->adACT_Fecha;->arACT_MontoCheque;->abACT_Modificados;->alACT_RecNumsAvisos;->atACT_ObsDoc;->aCtasApdo;->arACT_TempMontos;->abACT_TempModificados)
		SET BLOB SIZE:C606($ptr1->;0)
		
	: ($vt_accion="CargaVars")
		vrACT_MontoDescto:=0
		vrACT_MontoAdeudado:=vrACT_Monto
		vrACT_MontoPago:=vrACT_Monto
		vdACT_FechaPago:=[ACT_Documentos_de_Pago:176]FechaPago:4
		
		fUnaBoletaporDocumento:=0
		fUnaBoleta:=0
		vl_indexLC:=0
		vsACT_LugardePago:=""
		vrACT_MontoAdeudado:=vrACT_Monto
		vsACT_NomApellido:=KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Documentos_de_Pago:176]ID_Apoderado:2;->[Personas:7]Apellidos_y_nombres:30)
		
	: ($vt_accion="LimpiaVars")
		vrACT_MontoDescto:=0
		vrACT_MontoAdeudado:=0
		vrACT_MontoPago:=0
		vdACT_FechaPago:=!00-00-00!
		
		fUnaBoletaporDocumento:=0
		fUnaBoleta:=0
		vl_indexLC:=0
		vsACT_LugardePago:=""
		vrACT_MontoAdeudado:=0
		vsACT_NomApellido:=""
		
	: ($vt_accion="LimpiaVarsFormP7")
		C_REAL:C285(vrACT_MontoAPagarApdo;vlACT_Cuotas;vrACT_MontoPrimero)
		C_TEXT:C284(vtACT_BancoNombre;vtACT_BancoID;vtACT_BancoCuenta;vtACT_BancoTitular;vtACT_NoSerie;vtACT_FechaDocumento)
		C_DATE:C307(vdACT_FechaDocumento)
		C_LONGINT:C283(rCheques)
		
		vtACT_BancoCuenta:=""
		vtACT_NoSerie:=""
		vtACT_FechaDocumento:=String:C10(Current date:C33(*))
		vdACT_FechaDocumento:=Current date:C33(*)
		vrACT_MontoPrimero:=0
		rCheques:=1
		vlACT_Cuotas:=2
		vrACT_MontoAPagarApdo:=vrACT_Monto
		vtACT_BancoTitular:=vsACT_Titular
		vtACT_BancoNombre:=KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Documentos_de_Pago:176]ID_Apoderado:2;->[Personas:7]ACT_Banco_Cta:47)
		vtACT_BancoID:=KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Documentos_de_Pago:176]ID_Apoderado:2;->[Personas:7]ACT_ID_Banco_Cta:48)
		vdACT_FechaPago:=Current date:C33(*)
		
	: ($vt_accion="InitVarsFormP7")
		vtACT_BancoCuenta:=""
		vtACT_NoSerie:=""
		vtACT_FechaDocumento:=""
		vdACT_FechaDocumento:=!00-00-00!
		vrACT_MontoPrimero:=0
		rCheques:=0
		vlACT_Cuotas:=0
		vrACT_MontoAPagarApdo:=0
		vtACT_BancoTitular:=""
		vtACT_BancoNombre:=""
		vtACT_BancoID:=""
		vdACT_FechaPago:=!00-00-00!
		
End case 