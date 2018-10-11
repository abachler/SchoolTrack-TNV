//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:55:44
  // ----------------------------------------------------
  // Método: STWA2_OWC_objasignatura
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

$idObjetivos:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"id"))
$rnAsig:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rnAsig"))
$vObj_P1:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P1:6)
$vObj_P2:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P2:7)
$vObj_P3:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P3:8)
$vObj_P4:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P4:9)
$vObj_P5:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P5:10)

$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$vObj_P1;"objP1")
OB_SET ($ob_raiz;->$vObj_P2;"objP2")
OB_SET ($ob_raiz;->$vObj_P3;"objP3")
OB_SET ($ob_raiz;->$vObj_P4;"objP4")
OB_SET ($ob_raiz;->$vObj_P5;"objP5")
$json:=OB_Object2Json ($ob_raiz)


If (KRL_GotoRecord (->[Asignaturas:18];$rnAsig;True:C214))
	modObjetivos:=True:C214
	vObj_P1:=$vObj_P1
	vObj_P2:=$vObj_P2
	vObj_P3:=$vObj_P3
	vObj_P4:=$vObj_P4
	vObj_P5:=$vObj_P5
	AS_GuardaObjetivos 
Else 
	$json:=STWA2_JSON_SendError (-60000)
End if 

$0:=$json