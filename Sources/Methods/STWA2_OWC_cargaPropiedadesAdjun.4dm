//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:53:27
  // ----------------------------------------------------
  // Método: STWA2_OWC_cargaPropiedadesAdjun
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

$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
If (KRL_GotoRecord (->[xShell_Documents:91];$rn;False:C215))
	$ob_raiz:=OB_Create 
	OB_SET ($ob_raiz;->[xShell_Documents:91]DocumentName:3;"vinculo")
	OB_SET ($ob_raiz;->[xShell_Documents:91]DocumentDescription:4;"descripcion")
	OB_SET ($ob_raiz;->[xShell_Documents:91]DocumentType:5;"tipo")
	OB_SET ($ob_raiz;->[xShell_Documents:91]ApplicationName:6;"app")
	OB_SET_Text ($ob_raiz;STWA2_MakeDate4JS ([xShell_Documents:91]Created_On:14);"creadoel")
	OB_SET_Text ($ob_raiz;String:C10([xShell_Documents:91]CreatedAt:15;HH MM:K7:2);"creadoalas")
	OB_SET_Text ($ob_raiz;STWA2_MakeDate4JS ([xShell_Documents:91]ModifiedOn:16);"modificadoel")
	OB_SET_Text ($ob_raiz;String:C10([xShell_Documents:91]ModifiedAt:17;HH MM:K7:2);"modificadoalas")
	OB_SET ($ob_raiz;->[xShell_Documents:91]DocSize:13;"peso")
	$json:=OB_Object2Json ($ob_raiz)
	
Else 
	$json:=STWA2_JSON_SendError (-60006)
End if 

$0:=$json
