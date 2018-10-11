//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:35:37
  // ----------------------------------------------------
  // Método: STWA2_OWC_eliminaInasistencia
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

$userID:=STWA2_Session_GetUserSTID ($uuid)
$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
  //$jsonT:=JSON New
$ob_raiz:=OB_Create 
KRL_GotoRecord (->[Alumnos_Inasistencias:10];$rn)
$alumnoNombre:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]apellidos_y_nombres:40)
$fecha:=[Alumnos_Inasistencias:10]Fecha:1
$permisoeliminar:=(USR_checkRights ("D";->[Alumnos_Inasistencias:10];$userID)) | (<>viSTR_NoModificarNotas=0)  //ASM 20151102 Ticket 151341 
If ($permisoeliminar)
	If (KRL_DeleteRecord (->[Alumnos_Inasistencias:10];$rn)=1)
		Log_RegisterEvtSTW ("Eliminación de Inasistencia ("+String:C10($fecha;Internal date short special:K1:4)+") para "+$alumnoNombre;$userID)
		  //$node:=JSON Append text ($jsonT;"ERR";"")
		OB_SET_Text ($ob_raiz;"";"ERR")
	Else 
		  //$node:=JSON Append text ($jsonT;"ERR";"-30001")
		OB_SET_Text ($ob_raiz;"-30001";"ERR")
	End if 
Else 
	  //$node:=JSON Append text ($jsonT;"ERR";"sinpermiso")
	OB_SET_Text ($ob_raiz;"sinpermiso";"ERR")
End if 
READ ONLY:C145([Alumnos_Suspensiones:12])
$json:=OB_Object2Json ($ob_raiz)
  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre


$0:=$json
