//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:06:57
  // ----------------------------------------------------
  // Método: STWA2_OWC_uploadfile
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($1;$0;$uuid;$action)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_LONGINT:C283($userID)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3
$action:=$4

C_BLOB:C604($file)
WEB GET HTTP BODY:C814($file)
$parameters:=ST_GetWord ($action;2;"?")
If ($parameters#"")
	$action:=Substring:C12($action;1;Position:C15("?";$action)-1)
	$countParameters:=ST_CountWords ($parameters;0;"&")
	ARRAY TEXT:C222($y_ParameterNames->;$countParameters)
	ARRAY TEXT:C222($y_ParameterValues->;$countParameters)
	For ($i;1;$countParameters)
		$parameterPair:=ST_GetWord ($parameters;$i;"&")
		$y_ParameterNames->{$i}:=ST_GetWord ($parameterPair;1;"=")
		$y_ParameterValues->{$i}:=ST_GetWord ($parameterPair;2;"=")
	End for 
End if 
$uuid:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"UUID")
If (STWA2_Session_UpdateLastSeen ($uuid))
	$recNum:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"rn"))
	$fileName:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"filename")
	$userID:=STWA2_Session_GetUserSTID ($uuid)  //ABC Obtengo ID de usuario de sesion STWA 192194
	
	If (KRL_GotoRecord (->[Asignaturas_PlanesDeClases:169];$recNum;False:C215))
		CREATE RECORD:C68([xShell_Documents:91])
		[xShell_Documents:91]RelatedTable:1:=Table:C252(->[Asignaturas_PlanesDeClases:169])
		[xShell_Documents:91]RelatedID:2:=[Asignaturas_PlanesDeClases:169]ID_Plan:1
		[xShell_Documents:91]DocumentCreator:8:=""
		[xShell_Documents:91]RefType:10:="DOC"
		[xShell_Documents:91]DocumentName:3:=$fileName
		[xShell_Documents:91]OriginalPath:12:="DocsPlan"
		[xShell_Documents:91]Created_On:14:=Current date:C33
		[xShell_Documents:91]CreatedAt:15:=Current time:C178
		[xShell_Documents:91]ModifiedOn:16:=Current date:C33
		[xShell_Documents:91]ModifiedAt:17:=Current time:C178
		[xShell_Documents:91]DocSize:13:=0
		[xShell_Documents:91]DocumentDescription:4:=""
		[xShell_Documents:91]ApplicationName:6:=""
		SAVE RECORD:C53([xShell_Documents:91])
		$extensions:=ST_CountWords ([xShell_Documents:91]DocumentName:3;0;".")
		$extension:=ST_GetWord ([xShell_Documents:91]DocumentName:3;$extensions;".")
		If ($extension#"")
			$externalFileName:=String:C10([xShell_Documents:91]DocID:9)+"."+$extension
			[xShell_Documents:91]DocumentType:5:=$extension
		Else 
			[xShell_Documents:91]DocumentType:5:=""
			$externalFileName:=String:C10([xShell_Documents:91]DocID:9)
		End if 
		$serverFolder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"
		$dataFilePath:=sys_getRutaBaseDatos 
		$filePath:=$dataFilePath+"Archivos"+Folder separator:K24:12+$serverFolder+Folder separator:K24:12+$externalFileName
		$parentH:=SYS_GetParentNme ($filePath)
		SYS_CreateFolder ($parentH)
		BLOB TO DOCUMENT:C526($filePath;$file)
		$size:=Get document size:C479($filePath)
		[xShell_Documents:91]DocSize:13:=$size
		SAVE RECORD:C53([xShell_Documents:91])
		  //ABC agrego LOG desde STWA 192194
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_PlanesDeClases:169]ID_Asignatura:2)
		Log_RegisterEvtSTW ("Asignaturas - Modificación de las propiedades: "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5;$userID)
		
		KRL_UnloadReadOnly (->[xShell_Documents:91])
		$json:="{\"success\": true}"
	Else 
		$json:="{\"success\": false}"
	End if 
Else 
	$json:="{\"success\": false}"
End if 
TEXT TO BLOB:C554($json;$blob;UTF8 text without length:K22:17)
WEB SEND RAW DATA:C815($blob;*)

$0:=$json