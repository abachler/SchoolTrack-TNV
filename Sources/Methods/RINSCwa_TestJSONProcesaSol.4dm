//%attributes = {}
  //RINSCwa_TestJSONProcesaSol

  // Modificado por: Alexis Bustamante (10-06-2017)
  //TICKET 179869

C_TEXT:C284($json)
If (Not:C34(Is compiled mode:C492))
	$l_idApp:=4
	$t_llavePrivada:="79694f50d2e1bc9a0630524218056bd426a90f775ea1b025a09b51e5ec5c51e0"
	$t_parametro:=Generate UUID:C1066
	
	CONVERT FROM TEXT:C1011($t_llavePrivada+$t_parametro;"utf-8";$blob)
	$t_hash:=SHA512 ($blob;Crypto HEX)
	
	READ ONLY:C145([Personas:7])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([Alumnos:2])
	
	QUERY:C277([Personas:7];[Personas:7]No:1=3343)
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
	
	ARRAY LONGINT:C221(aQR_Longint1;0)
	ARRAY LONGINT:C221(aQR_Longint2;0)
	
	  //ids cargos
	APPEND TO ARRAY:C911(aQR_Longint1;236)
	APPEND TO ARRAY:C911(aQR_Longint1;237)
	APPEND TO ARRAY:C911(aQR_Longint1;230)
	
	APPEND TO ARRAY:C911(aQR_Longint2;234)
	APPEND TO ARRAY:C911(aQR_Longint2;237)
	APPEND TO ARRAY:C911(aQR_Longint2;230)
	
	C_TEXT:C284($vt_anio)
	
	C_OBJECT:C1216($ob_raiz;$ob_autenticacion)
	
	$ob_raiz:=OB_Create 
	$ob_autenticacion:=OB_Create 
	
	$vt_anio:="2016"
	
	
	OB_SET ($ob_autenticacion;->$l_idApp;"aplicacion")
	OB_SET ($ob_autenticacion;->$t_hash;"llave")
	OB_SET ($ob_autenticacion;->$t_parametro;"parametro")
	
	OB_SET ($ob_raiz;->$ob_autenticacion;"autenticacion")
	OB_SET ($ob_raiz;->$vt_anio;"anio")
	OB_SET ($ob_raiz;->[Personas:7]Auto_UUID:36;"uuid_apoderado")
	
	C_OBJECT:C1216($ob_temp)
	ARRAY OBJECT:C1221($ao_alumnos;0)
	
	While (Not:C34(End selection:C36([ACT_CuentasCorrientes:175])))
		$ob_temp:=OB_Create 
		KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
		
		OB_SET ($ob_temp;->[Alumnos:2]auto_uuid:72;"uuid")
		If (Selected record number:C246([ACT_CuentasCorrientes:175])=1)
			OB_SET ($ob_temp;->aQR_Longint1;"cargos")
		Else 
			OB_SET ($ob_temp;->aQR_Longint2;"cargos")
		End if 
		NEXT RECORD:C51([ACT_CuentasCorrientes:175])
		APPEND TO ARRAY:C911($ao_alumnos;$ob_temp)
	End while 
	OB_SET ($ob_raiz;->$ao_alumnos;"alumnos")
	$json:=OB_Object2Json ($ob_raiz)
End if 
$0:=$json
