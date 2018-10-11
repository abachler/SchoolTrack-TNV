//%attributes = {}
  //CMT_Send_Asignaturas
C_BLOB:C604($blob)
C_LONGINT:C283($vl_RecordsToSend)
C_TEXT:C284($t_resultadoCompresion)
C_BOOLEAN:C305($b_archivoComprimido)

$vt_nomFile:="Asignaturas"

Error:=0
If (Is compiled mode:C492)
	ON ERR CALL:C155("ERR_CMTErrorsCallBack")
End if 
READ ONLY:C145([Asignaturas:18])

ALL RECORDS:C47([Asignaturas:18])

ARRAY LONGINT:C221($al_recNumAsignaturas;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNumAsignaturas;"")
$vl_RecordsToSend:=Records in selection:C76([Asignaturas:18])

If ($vl_RecordsToSend>0)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($vl_RecordsToSend)+__ (" registros de asignaturas..."))
	$vt_FileName:=SYS_CarpetaAplicacion (CLG_Intercambios_CMT)+<>vtXS_CountryCode+"_"+<>gRolBD+"_"+$vt_nomFile+"_"+DTS_MakeFromDateTime +".xml"
	$raizAsignaturas:=DOM Create XML Ref:C861("asignaturas")
	DOM SET XML DECLARATION:C859($raizAsignaturas;"ISO-8859-1")
	
	For ($vl_Records;1;Size of array:C274($al_recNumAsignaturas))
		GOTO RECORD:C242([Asignaturas:18];$al_recNumAsignaturas{$vl_Records})
		$refAsignatura:=DOM_SetElementValueAndAttr ($raizAsignaturas;"asignatura")
		DOM_SetElementValueAndAttr ($refAsignatura;"nombre";XML_GetValidXMLText ([Asignaturas:18]denominacion_interna:16);True:C214)
		DOM_SetElementValueAndAttr ($refAsignatura;"ID";String:C10([Asignaturas:18]Numero:1);True:C214)
		DOM_SetElementValueAndAttr ($refAsignatura;"curso";XML_GetValidXMLText ([Asignaturas:18]Curso:5);True:C214)
		DOM_SetElementValueAndAttr ($refAsignatura;"nivel";String:C10([Asignaturas:18]Numero_del_Nivel:6);True:C214)
		DOM_SetElementValueAndAttr ($refAsignatura;"ID_profesor";String:C10([Asignaturas:18]profesor_numero:4);True:C214)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$vl_Records/$vl_RecordsToSend)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	DOM EXPORT TO FILE:C862($raizAsignaturas;$vt_FileName)
	If (ok=1)
		  //archivo generado correctamente
		CMT_LogAction ("Información";"Generación del documento con "+String:C10($vl_RecordsToSend)+" registros de asignaturas.")
		
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
		CMT_LogAction ("Error";"El documento con registros de asignaturas no pudo ser generado";Error)
	End if 
	DOM CLOSE XML:C722($raizAsignaturas)
End if 
ON ERR CALL:C155("")