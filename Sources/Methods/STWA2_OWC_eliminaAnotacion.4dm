//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:38:34
  // ----------------------------------------------------
  // Método: STWA2_OWC_eliminaAnotacion
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
$ob_raiz:=OB_Create 
KRL_GotoRecord (->[Alumnos_Anotaciones:11];$rn)
$alumnoNombre:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_Anotaciones:11]Alumno_Numero:6;->[Alumnos:2]apellidos_y_nombres:40)
$fecha:=[Alumnos_Anotaciones:11]Fecha:1
If (KRL_DeleteRecord (->[Alumnos_Anotaciones:11];$rn)=1)
	Log_RegisterEvtSTW ("Eliminación de Anotación ("+String:C10($fecha;Internal date short special:K1:4)+") para "+$alumnoNombre;$userID)
	OB_SET_Text ($ob_raiz;"";"ERR")
Else 
	OB_SET_Text ($ob_raiz;"-30001";"ERR")
End if 
READ ONLY:C145([Alumnos_Anotaciones:11])
$json:=OB_Object2Json ($ob_raiz)
$0:=$json