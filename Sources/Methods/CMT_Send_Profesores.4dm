//%attributes = {}
  //CMT_Send_Profesores

C_BLOB:C604($blob)
C_LONGINT:C283($vl_RecordsToSend)
C_TEXT:C284($t_resultadoCompresion)
C_BOOLEAN:C305($b_archivoComprimido)


$vt_nomFile:="Profesores"


Error:=0
If (Is compiled mode:C492)
	ON ERR CALL:C155("ERR_CMTErrorsCallBack")
End if 
READ ONLY:C145([Profesores:4])

ALL RECORDS:C47([Profesores:4])

ARRAY LONGINT:C221($al_recNumProfesores;0)
LONGINT ARRAY FROM SELECTION:C647([Profesores:4];$al_recNumProfesores;"")
$vl_RecordsToSend:=Records in selection:C76([Profesores:4])

If ($vl_RecordsToSend>0)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($vl_RecordsToSend)+__ (" registros de profesores..."))
	$vt_FileName:=SYS_CarpetaAplicacion (CLG_Intercambios_CMT)+<>vtXS_CountryCode+"_"+<>gRolBD+"_"+$vt_nomFile+"_"+DTS_MakeFromDateTime +".xml"
	$raizProfesores:=DOM Create XML Ref:C861("profesores")
	DOM SET XML DECLARATION:C859($raizProfesores;"ISO-8859-1")
	
	For ($vl_Records;1;Size of array:C274($al_recNumProfesores))
		GOTO RECORD:C242([Profesores:4];$al_recNumProfesores{$vl_Records})
		REDUCE SELECTION:C351([Cursos:3];0)
		KRL_FindAndLoadRecordByIndex (->[Cursos:3]Numero_del_profesor_jefe:2;->[Profesores:4]Numero:1)
		$refProfesor:=DOM_SetElementValueAndAttr ($raizProfesores;"profesor")
		DOM_SetElementValueAndAttr ($refProfesor;"apellido_paterno";XML_GetValidXMLText ([Profesores:4]Apellido_paterno:3);True:C214)
		DOM_SetElementValueAndAttr ($refProfesor;"apellido_materno";XML_GetValidXMLText ([Profesores:4]Apellido_materno:4);True:C214)
		DOM_SetElementValueAndAttr ($refProfesor;"nombres";XML_GetValidXMLText ([Profesores:4]Nombres:2);True:C214)
		DOM_SetElementValueAndAttr ($refProfesor;"ID";String:C10([Profesores:4]Numero:1);True:C214)
		DOM_SetElementValueAndAttr ($refProfesor;"es_profesor_jefe";ST_Boolean2Str (Records in selection:C76([Cursos:3])>0;"Si";"No");True:C214)
		DOM_SetElementValueAndAttr ($refProfesor;"email_personal";XML_GetValidXMLText ([Profesores:4]eMail_Personal:61);True:C214)
		DOM_SetElementValueAndAttr ($refProfesor;"email_profesional";XML_GetValidXMLText ([Profesores:4]eMail_profesional:38);True:C214)
		DOM_SetElementValueAndAttr ($refProfesor;"fecha_nacimiento";Substring:C12(DTS_MakeFromDateTime ([Profesores:4]Fecha_de_nacimiento:6);1;8);True:C214)
		DOM_SetElementValueAndAttr ($refProfesor;"telefono_domicilio";XML_GetValidXMLText ([Profesores:4]Telefono_domicilio:24);True:C214)
		DOM_SetElementValueAndAttr ($refProfesor;"celular";XML_GetValidXMLText ([Profesores:4]Celular:44);True:C214)
		DOM_SetElementValueAndAttr ($refProfesor;"sexo";XML_GetValidXMLText ([Profesores:4]Sexo:5);True:C214)
		DOM_SetElementValueAndAttr ($refProfesor;"identificador_nacional";XML_GetValidXMLText ([Profesores:4]RUT:27);True:C214)
		DOM_SetElementValueAndAttr ($refProfesor;"estado";String:C10(Num:C11([Profesores:4]Inactivo:62));True:C214)
		DOM_SetElementValueAndAttr ($refProfesor;"departamento";XML_GetValidXMLText ([Profesores:4]Departamento:14);True:C214)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$vl_Records/$vl_RecordsToSend)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	DOM EXPORT TO FILE:C862($raizProfesores;$vt_FileName)
	If (ok=1)
		  //archivo generado correctamente
		CMT_LogAction ("Información";"Generación del documento con "+String:C10($vl_RecordsToSend)+" registros de profesores.")
		
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
		CMT_LogAction ("Error";"El documento con registros de profesores no pudo ser generado";Error)
	End if 
	DOM CLOSE XML:C722($raizProfesores)
End if 
ON ERR CALL:C155("")