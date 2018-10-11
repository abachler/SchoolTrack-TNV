//%attributes = {"executedOnServer":true}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 23-07-18, 15:14:44
  // ----------------------------------------------------
  // Método: ST_EliminaRelacionArchivoFisico
  // Descripción
  // Elimina la relación lógica de los archivos de planes de clases y material docentes eliminados manualmente del servidor
  //
  // Parámetros
  // ----------------------------------------------------

C_LONGINT:C283($l_indice;$l_ok;$l_progres)
C_TEXT:C284($dataFilePath;$extension;$fileName;$filePath;$folder;$folderPath;$t_log;$t_rutaLog)
C_TIME:C306($h_ref)
C_BOOLEAN:C305($b_escribirLog)

ARRAY LONGINT:C221($al_recNumDocumentos;0)
ARRAY LONGINT:C221($al_recNumDocumentosEliminar;0)

$b_escribirLog:=False:C215
START TRANSACTION:C239

$t_log:="Identificador_Asignatura\tAsignatura\tNombre_Archivo\tIdentificador_Registro\tTipo\r"
  //planes de clases
QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RelatedTable:1=Table:C252(->[Asignaturas_PlanesDeClases:169]))
SELECTION TO ARRAY:C260([xShell_Documents:91];$al_recNumDocumentos)
$folder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsPlan"

$l_progres:=IT_Progress (1;0;0;"Verficando adjuntos de planes de clases...")
For ($l_indice;1;Size of array:C274($al_recNumDocumentos))
	$l_progres:=IT_Progress (0;$l_progres;$l_indice/Size of array:C274($al_recNumDocumentos);"Verficando adjuntos de planes de clases...")
	GOTO RECORD:C242([xShell_Documents:91];$al_recNumDocumentos{$l_indice})
	$extension:=[xShell_Documents:91]DocumentType:5
	If ($extension#"")
		$fileName:=String:C10([xShell_Documents:91]DocID:9)+"."+$extension
	Else 
		$fileName:=String:C10([xShell_Documents:91]DocID:9)
	End if 
	$dataFilePath:=sys_getRutaBaseDatos 
	$folderPath:=$dataFilePath+"Archivos"+SYS_FolderDelimiterOnServer +$folder
	$filePath:=$folderPath+SYS_FolderDelimiterOnServer +$filename
	If (Not:C34(SYS_TestPathName ($filePath)=Is a document:K24:1))
		$b_escribirLog:=True:C214
		QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Plan:1=[xShell_Documents:91]RelatedID:2)
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_PlanesDeClases:169]ID_Asignatura:2)
		APPEND TO ARRAY:C911($al_recNumDocumentosEliminar;$al_recNumDocumentos{$l_indice})
		$t_log:=$t_log+String:C10([Asignaturas_PlanesDeClases:169]ID_Asignatura:2)+"\t"+[Asignaturas:18]Asignatura:3+"\t"
		$t_log:=$t_log+ST_CleanString ([xShell_Documents:91]DocumentName:3)+"\t"+String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1)+"\t"+"Planes de clases\r"
	End if 
End for 
$l_progres:=IT_Progress (-1;$l_progres)

$l_progres:=IT_UThermometer (1;0;"Eliminando registros")
CREATE SELECTION FROM ARRAY:C640([xShell_Documents:91];$al_recNumDocumentosEliminar)
$l_ok:=KRL_DeleteSelection (->[xShell_Documents:91])
IT_UThermometer (-2;$l_progres)

CREATE EMPTY SET:C140([Asignaturas_Adjuntos:230];"$eliminarMD")
QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RelatedTable:1=Table:C252(->[Asignaturas_Adjuntos:230]))
SELECTION TO ARRAY:C260([xShell_Documents:91];$al_recNumDocumentos)
$folder:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsGuias"

$l_progres:=IT_Progress (1;0;0;"Verficando adjuntos de Material Docente...")
For ($l_indice;1;Size of array:C274($al_recNumDocumentos))
	$l_progres:=IT_Progress (0;$l_progres;$l_indice/Size of array:C274($al_recNumDocumentos);"Verficando adjuntos de Material Docente...")
	GOTO RECORD:C242([xShell_Documents:91];$al_recNumDocumentos{$l_indice})
	$extension:=[xShell_Documents:91]DocumentType:5
	If ($extension#"")
		$fileName:=String:C10([xShell_Documents:91]DocID:9)+"."+$extension
	Else 
		$fileName:=String:C10([xShell_Documents:91]DocID:9)
	End if 
	$dataFilePath:=sys_getRutaBaseDatos 
	$folderPath:=$dataFilePath+"Archivos"+SYS_FolderDelimiterOnServer +$folder
	$filePath:=$folderPath+SYS_FolderDelimiterOnServer +$filename
	If (Not:C34(SYS_TestPathName ($filePath)=Is a document:K24:1))
		QUERY:C277([Asignaturas_Adjuntos:230];[Asignaturas_Adjuntos:230]ID:1=[xShell_Documents:91]RelatedID:2)
		If (Records in selection:C76([Asignaturas_Adjuntos:230])>0)
			$b_escribirLog:=True:C214
			ADD TO SET:C119([Asignaturas_Adjuntos:230];"$eliminarMD")
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_Adjuntos:230]id_asignatura:7)
			$t_log:=$t_log+String:C10([Asignaturas:18]Numero:1)+"\t"+[Asignaturas:18]Asignatura:3+"\t"
			$t_log:=$t_log+ST_CleanString ([xShell_Documents:91]DocumentName:3)+"\t"+String:C10([Asignaturas_Adjuntos:230]ID:1)+"\t"+"Material Docente\r"
		Else 
			$t_log:=$t_log+"Sin registro Logico"+"\t"+""+"\t"
			$t_log:=$t_log+ST_CleanString ([xShell_Documents:91]DocumentName:3)+"\t"+""+"\t"+"Material Docente\r"
		End if 
		APPEND TO ARRAY:C911($al_recNumDocumentosEliminar;$al_recNumDocumentos{$l_indice})
		$t_log:=$t_log+[xShell_Documents:91]DocumentName:3+"\r"
	End if 
End for 
$l_progres:=IT_Progress (-1;$l_progres)

$l_progres:=IT_UThermometer (1;0;"Eliminando registros")
CREATE SELECTION FROM ARRAY:C640([xShell_Documents:91];$al_recNumDocumentosEliminar)
$l_ok:=$l_ok+KRL_DeleteSelection (->[xShell_Documents:91])

USE SET:C118("$eliminarMD")
$l_ok:=$l_ok+KRL_DeleteSelection (->[Asignaturas_Adjuntos:230])
IT_UThermometer (-2;$l_progres)

If ($l_ok=3)
	VALIDATE TRANSACTION:C240
	If ($b_escribirLog)
		$t_rutaLog:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ST)+"log_eliminacion_documento_Sin_archivo_fisico"+DTS_Get_GMT_TimeStamp +".txt"
		$h_ref:=Create document:C266($t_rutaLog;"TEXT")
		If ($h_ref#?00:00:00?)
			If (SYS_IsWindows )
				USE CHARACTER SET:C205("windows-1252";0)
			Else 
				USE CHARACTER SET:C205("MacRoman";0)
			End if 
			IO_SendPacket ($h_ref;$t_log)
			CLOSE DOCUMENT:C267($h_ref)
			USE CHARACTER SET:C205(*;0)
		End if 
	End if 
Else 
	CANCEL TRANSACTION:C241
End if 

