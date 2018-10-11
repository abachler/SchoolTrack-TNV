//%attributes = {}


  //  //`======
  //  // Modified by: abachler (5/2/10)
  //vb_ConstantesModificadas:=True
  //  //`======


  //C_BOOLEAN($1;$2;$todos;$useArrays)
  //C_TIME($refXMLDoc)

  //$todos:=True
  //$useArrays:=False
  //Case of 
  //: (Count parameters=1)
  //$todos:=$1
  //: (Count parameters=2)
  //$todos:=$1
  //$useArrays:=$2
  //End case 

  //$currentErrorHandler:=SN3_SetErrorHandler ("set")

  //SN3_BuildSelections (10013;$todos;$useArrays;-1)
  //If (Records in selection([xShell_Documents])>0)
  //ARRAY LONGINT($arrayLong;0)
  //ARRAY LONGINT($recNums;0)
  //SELECTION TO ARRAY([xShell_Documents];$recNums;[xShell_Documents]DocID;$arrayLong)

  //$size:=Size of array($recNums)

  //$vt_FileName:=SN3_CreateFile2Send ("crear";"";10014;"sax";->$refXMLDoc)
  //SN3_BuildFileHeader ($refXMLDoc;10014;"documentos";$todos;$useArrays)
  //CD_THERMOMETREXSEC (1;0;__ ("Generando documento con ")+String($size)+__ (" registros de referencias..."))
  //For ($indice;1;$size)
  //KRL_GotoRecord (->[xShell_Documents];$recNums{$indice};False)
  //QUERY([Asignaturas_Adjuntos];[Asignaturas_Adjuntos]ID=[xShell_Documents]RelatedID)
  //SAX_CreateNode ($refXMLDoc;"documento")
  //SAX_CreateNode ($refXMLDoc;"idAdjunto";True;String([Asignaturas_Adjuntos]ID))
  //SAX_CreateNode ($refXMLDoc;"internalfileid";True;String([xShell_Documents]DocID))
  //SAX_CreateNode ($refXMLDoc;"reftype";True;[xShell_Documents]RefType;True)
  //SAX_CreateNode ($refXMLDoc;"nombre";True;[xShell_Documents]DocumentName;True)
  //SAX_CreateNode ($refXMLDoc;"descripcion";True;[xShell_Documents]DocumentDescription;True)
  //SAX_CreateNode ($refXMLDoc;"url";True;[xShell_Documents]URL;True)
  //SAX CLOSE XML ELEMENT($refXMLDoc)
  //If ([xShell_Documents]RefType="DOC")
  //APPEND TO ARRAY(SN3_Docs2Send;[xShell_Documents]DocID)
  //APPEND TO ARRAY(SN3_extensions;[xShell_Documents]DocumentType)
  //APPEND TO ARRAY(SN3_DocsNames;[xShell_Documents]DocumentName)
  //End if 
  //CD_THERMOMETREXSEC (0;$indice/$size*100)
  //End for 
  //CD_THERMOMETREXSEC (-1)
  //SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
  //If (Error=0)
  //SN3_ManejaReferencias ("eliminar";10014;0;SNT_Accion_Actualizar;->$arrayLong)
  //SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String($size)+" registros de referencias.")
  //Else 
  //SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de referencias no pudo ser generado.";Error)
  //End if 
  //End if 

  //SN3_SetErrorHandler ("clear";$currentErrorHandler)

