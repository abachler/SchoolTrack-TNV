//%attributes = {}
  //  SN3_SendguiasXML

vb_ConstantesModificadas:=True:C214
C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)

$todos:=True:C214
$useArrays:=False:C215
Case of 
	: (Count parameters:C259=1)
		$todos:=$1
	: (Count parameters:C259=2)
		$todos:=$1
		$useArrays:=$2
End case 

ARRAY LONGINT:C221($recNums;0)
ARRAY LONGINT:C221($arrayLong;0)

$currentErrorHandler:=SN3_SetErrorHandler ("set")

SN3_BuildSelections (10013;$todos;$useArrays)  //sesiones
READ ONLY:C145([Asignaturas_Adjuntos:230])
READ ONLY:C145([xShell_Documents:91])
If (Records in selection:C76([Asignaturas_Adjuntos:230])>0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Asignaturas_Adjuntos:230];$recNums;[Asignaturas_Adjuntos:230]ID:1;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";10013;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;10013;"adjuntos_asignaturas";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de adjuntos de asignaturas..."))
	
	For ($indice;1;Size of array:C274($recNums))
		KRL_GotoRecord (->[Asignaturas_Adjuntos:230];$recNums{$indice};False:C215)
		QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RelatedID:2=[Asignaturas_Adjuntos:230]ID:1;*)
		QUERY:C277([xShell_Documents:91]; & ;[xShell_Documents:91]RelatedTable:1=Table:C252(->[Asignaturas_Adjuntos:230]))
		
		If ([xShell_Documents:91]DocumentType:5#"")
			$fileName:=String:C10([xShell_Documents:91]DocID:9)+"."+[xShell_Documents:91]DocumentType:5
		Else 
			$fileName:=String:C10([xShell_Documents:91]DocID:9)
		End if 
		$folderServer:=<>vtXS_CountryCode+"."+<>gRolBD+"."+"DocsGuias"
		$filePath:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+SYS_ServerFolderSeparator +$folderServer+SYS_ServerFolderSeparator +$filename
		
		If ((SYS_TestPathNameOnServer ($filePath)=1) | ([xShell_Documents:91]DocumentType:5="URL"))  //Si el archivo no se encuentra en el servidor, no lo agrego al XMl porque si no irá una referencia vacía.
			SAX_CreateNode ($refXMLDoc;"adjunto")
			SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Asignaturas_Adjuntos:230]ID:1))
			SAX_CreateNode ($refXMLDoc;"nombre_archivo";True:C214;String:C10([Asignaturas_Adjuntos:230]nombre_adjunto:10);True:C214)
			SAX_CreateNode ($refXMLDoc;"fecha";True:C214;SN3_MakeDateInmune2LocalFormat ([Asignaturas_Adjuntos:230]fecha_adjunto:5);True:C214)
			SAX_CreateNode ($refXMLDoc;"descripcion";True:C214;String:C10([Asignaturas_Adjuntos:230]descripcion:3);True:C214)
			SAX_CreateNode ($refXMLDoc;"fecha_modificacion";True:C214;SN3_MakeDateInmune2LocalFormat ([Asignaturas_Adjuntos:230]fecha_ultima_modificacion:6))
			SAX_CreateNode ($refXMLDoc;"id_profesor";True:C214;String:C10([Asignaturas_Adjuntos:230]id_profesor:9))
			SAX_CreateNode ($refXMLDoc;"id_asignatura";True:C214;String:C10([Asignaturas_Adjuntos:230]id_asignatura:7))
			SAX_CreateNode ($refXMLDoc;"id_profesor_modificadoPor";True:C214;String:C10([Asignaturas_Adjuntos:230]id_modificadoPor:8))
			SAX_CreateNode ($refXMLDoc;"documento")
			SAX_CreateNode ($refXMLDoc;"internalfileid";True:C214;String:C10([xShell_Documents:91]DocID:9))
			SAX_CreateNode ($refXMLDoc;"reftype";True:C214;[xShell_Documents:91]RefType:10;True:C214)
			SAX_CreateNode ($refXMLDoc;"descripcion";True:C214;[xShell_Documents:91]DocumentDescription:4;True:C214)  //probar
			SAX_CreateNode ($refXMLDoc;"url";True:C214;[xShell_Documents:91]URL:11;True:C214)  //ASM Agregada la URL
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			If ([xShell_Documents:91]RefType:10="DOC")
				APPEND TO ARRAY:C911(SN3_Docs2Send;[xShell_Documents:91]DocID:9)
				APPEND TO ARRAY:C911(SN3_extensions;[xShell_Documents:91]DocumentType:5)
				APPEND TO ARRAY:C911(SN3_DocsNames;[xShell_Documents:91]DocumentName:3)
				APPEND TO ARRAY:C911(SN3_AdjuntoMD;True:C214)
				APPEND TO ARRAY:C911(SN3_FileReferenceKey;"GUIAS."+String:C10([xShell_Documents:91]DocID:9))  //MONO 206467
			End if 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		End if 
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";10013;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de adjuntos de asignaturas.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de adjuntos de asignaturas no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)
