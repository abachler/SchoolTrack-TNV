//%attributes = {"executedOnServer":true}
  //XDOC_RemoveAttachedDocument
C_BOOLEAN:C305($log_plandeclases)
C_TEXT:C284($t_logmsj)
C_LONGINT:C283($l_idAsignatura)

$recNum:=$1
If (Count parameters:C259=2)
	$folder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+$2
Else 
	$folder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"
	$log_plandeclases:=True:C214
End if 

READ WRITE:C146([xShell_Documents:91])
GOTO RECORD:C242([xShell_Documents:91];$recNum)
$extension:=[xShell_Documents:91]DocumentType:5
If ($extension#"")
	$fileName:=String:C10([xShell_Documents:91]DocID:9)+"."+$extension
Else 
	$fileName:=String:C10([xShell_Documents:91]DocID:9)
End if 
$folder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"
  //$fileName:=$2
$dataFilePath:=sys_getRutaBaseDatos 
$folderPath:=$dataFilePath+"Archivos"+Folder separator:K24:12+$folder
$filePath:=$folderPath+Folder separator:K24:12+$filename
If (SYS_TestPathName ($filePath)=Is a document:K24:1)
	DELETE DOCUMENT:C159($filePath)
End if 

  //MONO 193174
If ($log_plandeclases)
	$l_idAsignatura:=KRL_GetNumericFieldData (->[Asignaturas_PlanesDeClases:169]ID_Plan:1;->[xShell_Documents:91]RelatedID:2;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2)
	$t_logmsj:="Planes de Clases: Eliminación de archivo "+[xShell_Documents:91]DocumentName:3
	$t_logmsj:=$t_logmsj+" del plan id :"+String:C10([xShell_Documents:91]RelatedID:2)
	$t_logmsj:=$t_logmsj+" en la asignatura"+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_idAsignatura;->[Asignaturas:18]denominacion_interna:16)+"("+String:C10($l_idAsignatura)+") - "
	$t_logmsj:=$t_logmsj+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_idAsignatura;->[Asignaturas:18]Curso:5)
	LOG_RegisterEvt ($t_logmsj)
End if 

DELETE RECORD:C58([xShell_Documents:91])