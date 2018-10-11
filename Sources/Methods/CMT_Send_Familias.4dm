//%attributes = {}
  //CMT_Send_Familias
C_BLOB:C604($blob)
C_LONGINT:C283($vl_RecordsToSend)
C_TEXT:C284($t_resultadoCompresion)
C_BOOLEAN:C305($b_archivoComprimido)

$vt_nomFile:="Familias"



Error:=0
If (Is compiled mode:C492)
	ON ERR CALL:C155("ERR_CMTErrorsCallBack")
End if 
READ ONLY:C145([Familia:78])

ALL RECORDS:C47([Familia:78])

ARRAY LONGINT:C221($al_recNumFam;0)
LONGINT ARRAY FROM SELECTION:C647([Familia:78];$al_recNumFam;"")
$vl_RecordsToSend:=Records in selection:C76([Familia:78])

If ($vl_RecordsToSend>0)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($vl_RecordsToSend)+__ (" registros de Familias..."))
	$vt_FileName:=SYS_CarpetaAplicacion (CLG_Intercambios_CMT)+<>vtXS_CountryCode+"_"+<>gRolBD+"_"+$vt_nomFile+"_"+DTS_MakeFromDateTime +".xml"
	$raizFamilias:=DOM Create XML Ref:C861("familias")
	DOM SET XML DECLARATION:C859($raizFamilias;"ISO-8859-1")
	
	For ($vl_Records;1;Size of array:C274($al_recNumFam))
		GOTO RECORD:C242([Familia:78];$al_recNumFam{$vl_Records})
		
		$refFamilia:=DOM_SetElementValueAndAttr ($raizFamilias;"familia")
		
		DOM_SetElementValueAndAttr ($refFamilia;"id_familia";String:C10([Familia:78]Numero:1);True:C214)
		DOM_SetElementValueAndAttr ($refFamilia;"nombre_familia";XML_GetValidXMLText ([Familia:78]Nombre_de_la_familia:3);True:C214)
		DOM_SetElementValueAndAttr ($refFamilia;"email_familia";XML_GetValidXMLText ([Familia:78]eMail:21);True:C214)
		DOM_SetElementValueAndAttr ($refFamilia;"telefono_familia";XML_GetValidXMLText ([Familia:78]Telefono:10);True:C214)
		
		
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$vl_Records/$vl_RecordsToSend)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	DOM EXPORT TO FILE:C862($raizFamilias;$vt_FileName)
	If (ok=1)
		  //archivo generado correctamente
		CMT_LogAction ("Información";"Generación del documento con "+String:C10($vl_RecordsToSend)+" registros de Familias.")
		
		  //<comprime y elimina archivo
		$zipFileName:=Replace string:C233($vt_FileName;".xml";".zip")
		$b_archivoComprimido:=SYS_CompresionDescompresion ($vt_FileName;$zipFileName;"";->$t_resultadoCompresion)
		
		DELAY PROCESS:C323(Current process:C322;300)  //para permitir que ZIP Save File "suelte" el archivo para poder eliminarlo...
		If (SYS_TestPathName ($zipFileName)=Is a document:K24:1)
			DELETE DOCUMENT:C159($vt_FileName)
		Else 
			CMT_LogAction ("Información";"El archivo "+$vt_FileName+" no pudo ser comprimido correctamente.")
		End if 
		
	Else 
		  //archivo no generado
		CMT_LogAction ("Error";"El documento con registros de Familias no pudo ser generado";Error)
	End if 
	DOM CLOSE XML:C722($raizFamilias)
End if 
ON ERR CALL:C155("")