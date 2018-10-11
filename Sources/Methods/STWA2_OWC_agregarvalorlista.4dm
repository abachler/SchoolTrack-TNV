//%attributes = {}


  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:32:48
  // ----------------------------------------------------
  // Método: STWA2_OWC_agregarvalorlista
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

$lista:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"lista")
$valor:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"valor")
  //$jsonT:=JSON New 
$ob_raiz:=OB_Create 
ARRAY TEXT:C222(sElements;0)
READ WRITE:C146([xShell_List:39])
QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=$lista)
If (Records in selection:C76([xShell_List:39])=1)
	$arrayPointer:=Get pointer:C304([xShell_List:39]ArrayName1:5)
	BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;$arrayPointer)
	COPY ARRAY:C226($arrayPointer->;sElements)
	If (Find in array:C230(sElements;$valor)=-1)
		APPEND TO ARRAY:C911(sElements;$valor)
		SORT ARRAY:C229(sElements;>)
		changed:=True:C214
		TBL_SaveList 
		changed:=False:C215
	End if 
	  //$node:=JSON Append text array ($jsonT;"listaactualizada";sElements)
	OB_SET ($ob_raiz;->sElements;"listaactualizada")
Else 
	  //$node:=JSON Append text ($jsonT;"ERR";"ERR")
	OB_SET_Text ($ob_raiz;"ERR";"ERR")
End if 
$json:=OB_Object2Json ($ob_raiz)
  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
ARRAY TEXT:C222(sElements;0)

$0:=$json