//%attributes = {}
  //AS_EliminaAdjuntoPlanesDeClases

C_LONGINT:C283($1;$2)
$vl_idplan:=$1
$vl_Tabla:=$2

QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RelatedID:2=$vl_idplan;*)
QUERY:C277([xShell_Documents:91]; & ;[xShell_Documents:91]RelatedTable:1=$vl_Tabla)
QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RelatedID:2=$vl_idplan;*)
QUERY:C277([xShell_Documents:91]; & ;[xShell_Documents:91]RelatedTable:1=$vl_Tabla)
SELECTION TO ARRAY:C260([xShell_Documents:91]DocID:9;$idDocument;[xShell_Documents:91]DocumentName:3;$aDocumentName;[xShell_Documents:91];alXDOC_AttachedRecNum)
For ($i;1;Size of array:C274(alXDOC_AttachedRecNum))
	XDOC_RemoveAttachedDocument (alXDOC_AttachedRecNum{$i})
End for 
$text:=AT_array2text (->$aDocumentName;",")
LOG_RegisterEvt ("Asignatura: "+[Asignaturas:18]Asignatura:3+" Curso: "+[Asignaturas:18]Curso:5+".Se eliminaron los siguientes adjuntos de Planes de clase: "+$text)
  //SELECTION TO ARRAY([xShell_Documents]DocID;$idDocument;[xShell_Documents]DocumentName;$aDocumentName)
  //$vl_continuar:=KRL_DeleteSelection (->[xShell_Documents])
  //If ($vl_continuar=1)
  //$serverFolder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"
  //$dataFilePath:=sys_getRutaBaseDatos 
  //For ($i;1;Size of array($idDocument))
  //$extensions:=ST_CountWords ($aDocumentName{$i};0;".")
  //$extension:=ST_GetWord ($aDocumentName{$i};$extensions;".")
  //If ($extension#"")
  //$externalFileName:=String($idDocument{$i})+"."+$extension
  //Else 
  //$externalFileName:=String($idDocument{$i})
  //End if 
  //$filePath:=$dataFilePath+"Archivos"+SYS_FolderDelimiter +$serverFolder+SYS_FolderDelimiter +$externalFileName
  //If (SYS_TestPathName ($filePath)=1)
  //DELETE DOCUMENT($filePath)
  //End if 
  //End for 
  //End if 

