//%attributes = {}
  //SN3_SendVerificadorXML

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


C_TIME:C306($refXMLDoc)


$currentErrorHandler:=SN3_SetErrorHandler ("set")
$vt_FileName:=SN3_CreateFile2Send ("crear";"";66666;"sax";->$refXMLDoc)
SN3_BuildFileHeader ($refXMLDoc;66666;"alumnos";True:C214;False:C215)
SN3_BuildSelections (SN3_DTi_Alumnos;True:C214;False:C215)
If (Records in selection:C76([Alumnos:2])>0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Alumnos:2];$recNums)
	
	$size1:=Size of array:C274($recNums)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size1)+__ (" registros de verificación de alumnos..."))
	For ($indice;1;$size1)
		KRL_GotoRecord (->[Alumnos:2];$recNums{$indice};False:C215)
		SAX_CreateNode ($refXMLDoc;"alumno")
		SAX_CreateNode ($refXMLDoc;"alumid";True:C214;String:C10([Alumnos:2]numero:1))
		SAX_CreateNode ($refXMLDoc;"famida";True:C214;String:C10([Alumnos:2]Familia_Número:24))
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size1)
	End for 
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 
SN3_BuildSelections (SN3_DTi_RelacionesFamiliares;True:C214;False:C215)
If (Records in selection:C76([Personas:7])>0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Personas:7];$recNums)
	
	$size2:=Size of array:C274($recNums)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size2)+__ (" registros de verificación de relaciones familiares..."))
	SAX_CreateNode ($refXMLDoc;"relfams")
	For ($indice;1;$size2)
		KRL_GotoRecord (->[Personas:7];$recNums{$indice};False:C215)
		SAX_CreateNode ($refXMLDoc;"relfam")
		SAX_CreateNode ($refXMLDoc;"relfamid";True:C214;String:C10([Personas:7]No:1))
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1;*)
		QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Familia:2#0)
		FIRST RECORD:C50([Familia_RelacionesFamiliares:77])
		SAX_CreateNode ($refXMLDoc;"familias")
		While (Not:C34(End selection:C36([Familia_RelacionesFamiliares:77])))
			SAX_CreateNode ($refXMLDoc;"famidr";True:C214;String:C10([Familia_RelacionesFamiliares:77]ID_Familia:2))
			NEXT RECORD:C51([Familia_RelacionesFamiliares:77])
		End while 
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size2)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
End if 
SAX CLOSE XML ELEMENT:C854($refXMLDoc)

SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
If (Error=0)
	SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size1+$size2)+" registros de verificación.")
Else 
	SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de verificación no pudo ser generado.";Error)
End if 
$zipFileName:=Replace string:C233($vt_FileName;".snt";".zip")
$file:=SYS_Path2FileName ($zipFileName)
SN3_LoadGeneralSettings 
SN3_FTP_SendFile (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;"/SchoolFiles3/";$zipFileName;"/SchoolFiles3/"+$file;True:C214)
If (SYS_TestPathName ($zipFileName)=Is a document:K24:1)
	DELETE DOCUMENT:C159($zipFileName)
End if 
SN3_SetErrorHandler ("clear";$currentErrorHandler)