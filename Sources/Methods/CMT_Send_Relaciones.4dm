//%attributes = {}
  //CMT_Send_Relaciones

C_BLOB:C604($blob)
C_LONGINT:C283($vl_RecordsToSend)
C_TEXT:C284($t_resultadoCompresion)
C_BOOLEAN:C305($b_archivoComprimido)

$vt_nomFile:="Relaciones"



Error:=0
If (Is compiled mode:C492)
	ON ERR CALL:C155("ERR_CMTErrorsCallBack")
End if 
READ ONLY:C145([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Personas:7])
READ ONLY:C145([Familia:78])

ALL RECORDS:C47([Familia_RelacionesFamiliares:77])

ARRAY LONGINT:C221($al_recNumRelFam;0)
LONGINT ARRAY FROM SELECTION:C647([Familia_RelacionesFamiliares:77];$al_recNumRelFam;"")
$vl_RecordsToSend:=Records in selection:C76([Familia_RelacionesFamiliares:77])

If ($vl_RecordsToSend>0)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($vl_RecordsToSend)+__ (" registros de relaciones familiares..."))
	$vt_FileName:=SYS_CarpetaAplicacion (CLG_Intercambios_CMT)+<>vtXS_CountryCode+"_"+<>gRolBD+"_"+$vt_nomFile+"_"+DTS_MakeFromDateTime +".xml"
	$raizRelaciones:=DOM Create XML Ref:C861("relaciones")
	DOM SET XML DECLARATION:C859($raizRelaciones;"ISO-8859-1")
	
	For ($vl_Records;1;Size of array:C274($al_recNumRelFam))
		GOTO RECORD:C242([Familia_RelacionesFamiliares:77];$al_recNumRelFam{$vl_Records})
		KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3)
		KRL_FindAndLoadRecordByIndex (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2)
		$refPersona:=DOM_SetElementValueAndAttr ($raizRelaciones;"relacion")
		DOM_SetElementValueAndAttr ($refPersona;"apellido_paterno";XML_GetValidXMLText ([Personas:7]Apellido_paterno:3);True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"apellido_materno";XML_GetValidXMLText ([Personas:7]Apellido_materno:4);True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"nombres";XML_GetValidXMLText ([Personas:7]Nombres:2);True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"ID";String:C10([Personas:7]No:1);True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"ID_familia";String:C10([Familia:78]Numero:1);True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"es_padre";ST_Boolean2Str ([Familia:78]Padre_Número:5=[Personas:7]No:1;"Si";"No");True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"es_madre";ST_Boolean2Str ([Familia:78]Madre_Número:6=[Personas:7]No:1;"Si";"No");True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"es_apoderado_cuentas";ST_Boolean2Str ([Personas:7]ES_Apoderado_de_Cuentas:42;"Si";"No");True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"es_apoderado_academico";ST_Boolean2Str ([Personas:7]Es_Apoderado_Academico:41;"Si";"No");True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"email";XML_GetValidXMLText ([Personas:7]eMail:34);True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"fecha_nacimiento";Substring:C12(DTS_MakeFromDateTime ([Personas:7]Fecha_de_nacimiento:5);1;8);True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"telefono_domicilio";XML_GetValidXMLText ([Personas:7]Telefono_domicilio:19);True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"telefono_profesional";XML_GetValidXMLText ([Personas:7]Telefono_profesional:29);True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"celular";XML_GetValidXMLText ([Personas:7]Celular:24);True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"sexo";XML_GetValidXMLText ([Personas:7]Sexo:8);True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"identificador_nacional";XML_GetValidXMLText ([Personas:7]RUT:6);True:C214)
		DOM_SetElementValueAndAttr ($refPersona;"estado";String:C10(Num:C11([Personas:7]Inactivo:46));True:C214)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$vl_Records/$vl_RecordsToSend)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	DOM EXPORT TO FILE:C862($raizRelaciones;$vt_FileName)
	If (ok=1)
		  //archivo generado correctamente
		CMT_LogAction ("Información";"Generación del documento con "+String:C10($vl_RecordsToSend)+" registros de relaciones familiares.")
		
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
		CMT_LogAction ("Error";"El documento con registros de relaciones familiares no pudo ser generado";Error)
	End if 
	DOM CLOSE XML:C722($raizRelaciones)
End if 
ON ERR CALL:C155("")