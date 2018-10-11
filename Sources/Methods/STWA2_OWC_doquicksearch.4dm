//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:49:06
  // ----------------------------------------------------
  // Método: STWA2_OWC_doquicksearch
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$campo:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"campo"))+1
$table:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"table")
$delim:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"delim"))+1
vtQRY_ValorLiteral:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"valor")
$tipo:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"tipo")
If ($tipo#"all")
	$sel:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"sel")
	
	  // Modificado por: Alexis Bustamante (12-06-2017)
	  //TICKET 179869
	
	C_OBJECT:C1216($ob)
	$ob:=OB_Create 
	$ob:=JSON Parse:C1218($sel;Is object:K8:27)
	  //$root:=JSON Parse text ($sel)
	ARRAY TEXT:C222($strValues;0)
	ARRAY LONGINT:C221($intValues;0)
	  //$node:=JSON Get child by name ($root;"sel")
	  //JSON GET TEXT ARRAY ($node;$strValues)
	OB_GET ($ob;->$strValues;"sel")
	$t:=AT_array2text (->$strValues)
	AT_Text2Array (->$intValues;$t;";")
	  //JSON CLOSE ($root)  //20150421 RCH Se agrega cierre
End if 
$go:=True:C214
Case of 
	: ($table="asignaturas")
		$tablePtr:=->[Asignaturas:18]
		yBWR_currentTable:=$tablePtr
		<>vsXS_CurrentModule:="SchoolTrack"
		If ($tipo#"all")
			CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];$intValues)
		End if 
	Else 
		$go:=False:C215
End case 
o2:=Num:C11($tipo="insel")
o3:=Num:C11($tipo="addtosel")
o4:=Num:C11($tipo="removefromsel")
QRY_LoadOperatorsArray 
If ($go)
	BWR_GetPanelSettings (SchoolTrack;Table:C252($tablePtr))
	atVS_QFSourceFieldAlias:=$campo
	CREATE SET:C116($tablePtr->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	aDelims:=$delim
	$profID:=STWA2_Session_GetProfID ($uuid)
	$userID:=STWA2_Session_GetUserSTID ($uuid)
	STWA2_QFRunQuery ($userID;$profID)
	$json:=STWA2_AJAX_ListaAsignaturas ($uuid)
End if 
$0:=$json
