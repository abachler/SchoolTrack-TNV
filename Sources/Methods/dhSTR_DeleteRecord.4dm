//%attributes = {}
  //dhSTR_DeleteRecord
C_POINTER:C301($1)
$TablePointer:=$1
$deleted:=-1
Case of 
	: (Table:C252($TablePointer)=Table:C252(->[Asignaturas_PlanesDeClases:169]))
		  //QUERY([xShell_Documents];[xShell_Documents]RelatedID=[Asignaturas_PlanesDeClases]ID_Plan;*)
		  //QUERY([xShell_Documents]; & ;[xShell_Documents]RelatedTable=Table(->[Asignaturas_PlanesDeClases]))
		  //SELECTION TO ARRAY([xShell_Documents]DocumentName;$aDocumentName)
		  //If (Size of array($aDocumentName)>0)
		  //$text:=AT_array2text (->$aDocumentName;",")
		  //LOG_RegisterEvt ("Asignatura: "+[Asignaturas]Asignatura+" Curso: "+[Asignaturas]Curso+".Se eliminaron los siguientes adjuntos de Planes de clase: "+$text)
		  //End if 
		DELETE RECORD:C58($TablePointer->)
		$deleted:=1
End case 
$0:=$deleted