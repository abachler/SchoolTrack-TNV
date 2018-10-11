//%attributes = {}
  //CMT_Send_Actividades


C_BLOB:C604($blob)
C_LONGINT:C283($vl_RecordsToSend)
C_TEXT:C284($t_resultadoCompresion)
C_BOOLEAN:C305($b_archivoComprimido)


$vl_NumFile:=200817
$vt_nomFile:="Actividades"


Error:=0
If (Is compiled mode:C492)
	ON ERR CALL:C155("ERR_CMTErrorsCallBack")
End if 
READ ONLY:C145([Actividades:29])

ALL RECORDS:C47([Actividades:29])

ARRAY LONGINT:C221($al_recNumActividades;0)
LONGINT ARRAY FROM SELECTION:C647([Actividades:29];$al_recNumActividades;"")
$vl_RecordsToSend:=Records in selection:C76([Actividades:29])

If ($vl_RecordsToSend>0)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($vl_RecordsToSend)+__ (" registros de actividades..."))
	$vt_FileName:=SYS_CarpetaAplicacion (CLG_Intercambios_CMT)+<>vtXS_CountryCode+"_"+<>gRolBD+"_"+$vt_nomFile+"_"+DTS_MakeFromDateTime +".xml"
	$raizActividades:=DOM Create XML Ref:C861("actividades")
	DOM SET XML DECLARATION:C859($raizActividades;"ISO-8859-1")
	
	
	For ($vl_Records;1;Size of array:C274($al_recNumActividades))
		GOTO RECORD:C242([Actividades:29];$al_recNumActividades{$vl_Records})
		$refActividades:=DOM_SetElementValueAndAttr ($raizActividades;"actividad")
		DOM_SetElementValueAndAttr ($refActividades;"ID";String:C10([Actividades:29]ID:1);True:C214)
		DOM_SetElementValueAndAttr ($refActividades;"nombre";XML_GetValidXMLText ([Actividades:29]Nombre:2);True:C214)
		DOM_SetElementValueAndAttr ($refActividades;"ID_profesor";String:C10([Actividades:29]No_Profesor:3);True:C214)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$vl_Records/$vl_RecordsToSend)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	DOM EXPORT TO FILE:C862($raizActividades;$vt_FileName)
	If (ok=1)
		  //archivo generado correctamente
		CMT_LogAction ("Información";"Generación del documento con "+String:C10($vl_RecordsToSend)+" registros de actividades.")
		
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
		CMT_LogAction ("Error";"El documento con registros de actividades no pudo ser generado";Error)
	End if 
	DOM CLOSE XML:C722($raizActividades)
End if 
ON ERR CALL:C155("")