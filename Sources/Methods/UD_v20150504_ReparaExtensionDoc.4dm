//%attributes = {}
  //UD_v20150504_ReparaExtensionDoc

C_LONGINT:C283($pos;$extensions;$l_therm)
C_TEXT:C284($dataFilePath;$extension;$serverFolder)

READ ONLY:C145([Asignaturas_PlanesDeClases:169])
READ WRITE:C146([xShell_Documents:91])


$l_therm:=IT_UThermometer (1;0;"Verificando extensión de adjuntos en Planes de clases...")

ALL RECORDS:C47([Asignaturas_PlanesDeClases:169])

$serverFolder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"+Folder separator:K24:12
$dataFilePath:=sys_getRutaBaseDatos +"Archivos"+Folder separator:K24:12+$serverFolder

If (SYS_TestPathName ($dataFilePath)=Is a folder:K24:2)
	DOCUMENT LIST:C474($dataFilePath;aQR_Text1)
	If (Size of array:C274(aQR_Text1)>0)
		While (Not:C34(End selection:C36([Asignaturas_PlanesDeClases:169])))
			QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RelatedID:2=[Asignaturas_PlanesDeClases:169]ID_Plan:1;*)
			QUERY:C277([xShell_Documents:91]; & ;[xShell_Documents:91]RelatedTable:1=Table:C252(->[Asignaturas_PlanesDeClases:169]))
			
			If (Records in selection:C76([xShell_Documents:91])>0)
				
				While (Not:C34(End selection:C36([xShell_Documents:91])))
					$pos:=Find in array:C230(aQR_Text1;String:C10([xShell_Documents:91]DocID:9)+"."+[xShell_Documents:91]DocumentType:5+"@")
					If ($pos>0)
						$extensions:=ST_CountWords (aQR_Text1{$pos};0;".")
						$extension:=ST_GetWord (aQR_Text1{$pos};$extensions;".")
						If ([xShell_Documents:91]DocumentType:5#$extension)
							[xShell_Documents:91]DocumentType:5:=$extension
							SAVE RECORD:C53([xShell_Documents:91])
						End if 
					End if 
					NEXT RECORD:C51([xShell_Documents:91])
				End while 
				
			End if 
			NEXT RECORD:C51([Asignaturas_PlanesDeClases:169])
		End while 
	End if 
End if 
IT_UThermometer (-2;$l_therm)
KRL_UnloadReadOnly (->[xShell_Documents:91])
KRL_UnloadReadOnly (->[Asignaturas_PlanesDeClases:169])

