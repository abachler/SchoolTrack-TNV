//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:49:27
  // ----------------------------------------------------
  // Método: STWA2_OWC_doquery
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

$qname:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"qname")
$table:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"table")
$go:=True:C214
Case of 
	: ($table="asignaturas")
		vyQRY_TablePointer:=->[Asignaturas:18]
		vlBWR_SelectedTableRef:=Table:C252(vyQRY_TablePointer)
		<>vsXS_CurrentModule:="SchoolTrack"
		yBWR_currentTable:=vyQRY_TablePointer
		vLocation:="output"
	Else 
		$go:=False:C215
End case 
If ($go)
	$profID:=STWA2_Session_GetProfID ($uuid)
	$userID:=STWA2_Session_GetUserSTID ($uuid)
	$admin:=USR_IsGroupMember_by_GrpID (-15001;$userID)
	If ($qname="-1")
		If (($profID=0) | ($admin))
			ALL RECORDS:C47(yBWR_currentTable->)
			dhQF_RefineQuery 
		Else 
			dhSTWA2_SpecialSearch ("SchoolTrack";yBWR_currentTable;$profID)
		End if 
		$json:=STWA2_AJAX_ListaAsignaturas ($uuid)
	Else 
		QRY_ExecuteBuildQuery ($qname)
		If (USR_LimitedSearch ($userID))
			CREATE SET:C116(yBWR_currentTable->;"temp")
			dhSTWA2_SpecialSearch ("SchoolTrack";yBWR_currentTable;$profID)
			CREATE SET:C116(yBWR_currentTable->;"xx")
			INTERSECTION:C121("temp";"xx";"xx")
			USE SET:C118("xx")
			SET_ClearSets ("xx";"temp")
		End if 
		$json:=STWA2_AJAX_ListaAsignaturas ($uuid)
	End if 
Else 
	$json:=STWA2_JSON_SendError (-60000)
End if 

$0:=$json
