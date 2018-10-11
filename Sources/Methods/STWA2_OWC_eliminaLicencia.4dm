//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:34:46
  // ----------------------------------------------------
  // Método: STWA2_OWC_eliminaLicencia
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$profID:=STWA2_Session_GetProfID ($uuid)
$userID:=STWA2_Session_GetUserSTID ($uuid)
$lic:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"licencia"))
  //$jsonT:=JSON New 
$ob_raiz:=OB_Create 
$rn:=Find in field:C653([Alumnos_Licencias:73]ID:6;$lic)
If (KRL_GotoRecord (->[Alumnos_Licencias:73];$rn;True:C214))
	If (([Alumnos_Licencias:73]Tipo_licencia:4=<>aLicencias{1}) | ([Alumnos_Licencias:73]Tipo_licencia:4=<>aLicencias{2}))
		READ WRITE:C146([Alumnos_Inasistencias:10])
		QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Licencia:5=[Alumnos_Licencias:73]ID:6)
		While (Not:C34(End selection:C36([Alumnos_Inasistencias:10])))
			LOAD RECORD:C52([Alumnos_Inasistencias:10])
			While (Locked:C147([Alumnos_Inasistencias:10]))
				DELAY PROCESS:C323(Current process:C322;15)
				LOAD RECORD:C52([Alumnos_Inasistencias:10])
			End while 
			$str:="\r"+[Alumnos_Licencias:73]Observaciones:5
			[Alumnos_Inasistencias:10]Justificación:2:=""
			[Alumnos_Inasistencias:10]Observaciones:3:=Replace string:C233([Alumnos_Inasistencias:10]Observaciones:3;$str;"")
			SAVE RECORD:C53([Alumnos_Inasistencias:10])
			NEXT RECORD:C51([Alumnos_Inasistencias:10])
		End while 
		UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
		SAVE RECORD:C53([Alumnos_Conducta:8])
	End if 
	$alumnoNombre:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Licencias:73]Alumno_numero:1;->[Alumnos:2]apellidos_y_nombres:40)
	$cursoLic:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Licencias:73]Alumno_numero:1;->[Alumnos:2]curso:20)
	DELETE RECORD:C58([Alumnos_Licencias:73])
	Log_RegisterEvtSTW ("Conducta - Eliminación de Licencia: "+$alumnoNombre+", "+$cursoLic;$userID)
	  //$node:=JSON Append text ($jsonT;"ERR";"")
	OB_SET_Text ($ob_raiz;"";"ERR")
Else 
	  //$node:=JSON Append text ($jsonT;"ERR";"-30001")
	OB_SET_Text ($ob_raiz;"-30001";"ERR")
End if 
  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
$json:=OB_Object2Json ($ob_raiz)

$0:=$json