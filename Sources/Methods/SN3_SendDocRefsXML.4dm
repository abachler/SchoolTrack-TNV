//%attributes = {}
  //SN3_SendDocRefsXML

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


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

$currentErrorHandler:=SN3_SetErrorHandler ("set")

SN3_BuildSelections (SN3_DTi_PlanesClase;$todos;$useArrays;SN3_SDTx_Referencias)
If (Records in selection:C76([xShell_Documents:91])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([xShell_Documents:91];$recNums;[xShell_Documents:91]DocID:9;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Documentos;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_Documentos;"documentos";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de referencias..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[xShell_Documents:91];$recNums{$indice};False:C215)
		QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Plan:1=[xShell_Documents:91]RelatedID:2)
		SAX_CreateNode ($refXMLDoc;"documento")
		SAX_CreateNode ($refXMLDoc;"idplan";True:C214;String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1))
		SAX_CreateNode ($refXMLDoc;"internalfileid";True:C214;String:C10([xShell_Documents:91]DocID:9))
		SAX_CreateNode ($refXMLDoc;"reftype";True:C214;[xShell_Documents:91]RefType:10;True:C214)
		SAX_CreateNode ($refXMLDoc;"nombre";True:C214;[xShell_Documents:91]DocumentName:3;True:C214)
		SAX_CreateNode ($refXMLDoc;"descripcion";True:C214;[xShell_Documents:91]DocumentDescription:4;True:C214)
		SAX_CreateNode ($refXMLDoc;"url";True:C214;[xShell_Documents:91]URL:11;True:C214)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		If ([xShell_Documents:91]RefType:10="DOC")
			APPEND TO ARRAY:C911(SN3_Docs2Send;[xShell_Documents:91]DocID:9)
			APPEND TO ARRAY:C911(SN3_extensions;[xShell_Documents:91]DocumentType:5)
			APPEND TO ARRAY:C911(SN3_DocsNames;[xShell_Documents:91]DocumentName:3)
			APPEND TO ARRAY:C911(SN3_AdjuntoMD;False:C215)
			APPEND TO ARRAY:C911(SN3_FileReferenceKey;"PLANES."+String:C10([xShell_Documents:91]DocID:9))  //MONO 206467
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_Documentos;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de referencias.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de referencias no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)

