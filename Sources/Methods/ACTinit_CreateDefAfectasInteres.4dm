//%attributes = {}
  //ACTinit_CreateDefAfectasInteres
C_TEXT:C284($1;$vt_accion)
C_POINTER:C301($ptr1;${2})
C_BLOB:C604($xBlob)

If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
Case of 
	: ($vt_accion="DeclaraVars")
		C_LONGINT:C283(cbNCtasAfectas;cbNApdosAfectos)
		cbNCtasAfectas:=0
		cbNApdosAfectos:=0
		
	: ($vt_accion="")
		ACTinit_CreateDefAfectasInteres ("DeclaraVars")
		ACTinit_CreateDefAfectasInteres ("GuardaBlob")
		
	: ($vt_accion="LeeBlob")
		ACTinit_CreateDefAfectasInteres ("DeclaraVars")
		ACTinit_CreateDefAfectasInteres ("ArmaBlob";->$xBlob)
		$xBlob:=PREF_fGetBlob (0;"AfectacionInteres";$xBlob)
		BLOB_Blob2Vars (->$xBlob;0;->cbNCtasAfectas;->cbNApdosAfectos)
		SET BLOB SIZE:C606($xBlob;0)
		
	: ($vt_accion="GuardaBlob")
		ACTinit_CreateDefAfectasInteres ("ArmaBlob";->$xBlob)
		PREF_SetBlob (0;"AfectacionInteres";$xBlob)
		SET BLOB SIZE:C606($xBlob;0)
		
	: ($vt_accion="ArmaBlob")
		BLOB_Variables2Blob ($ptr1;0;->cbNCtasAfectas;->cbNApdosAfectos)
		
		
End case 