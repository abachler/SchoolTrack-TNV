//%attributes = {}
  //CMT_Send_Alumnos

$vt_nomFile:="Alumnos"
  //C_BOOLEAN($1;$vb_EnvioInfo)
  //$vb_EnvioInfo:=$1

C_BLOB:C604($blob)
C_LONGINT:C283($vl_RecordsToSend)

Error:=0
If (Is compiled mode:C492)
	ON ERR CALL:C155("ERR_CMTErrorsCallBack")
End if 
READ ONLY:C145([Alumnos:2])

ALL RECORDS:C47([Alumnos:2])

QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Ret@")
ARRAY LONGINT:C221($al_recNumAlumnos;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_recNumAlumnos;"")
$vl_RecordsToSend:=Records in selection:C76([Alumnos:2])

If ($vl_RecordsToSend>0)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($vl_RecordsToSend)+__ (" registros de alumnos..."))
	$vt_FileName:=SYS_CarpetaAplicacion (CLG_Intercambios_CMT)+<>vtXS_CountryCode+"_"+<>gRolBD+"_"+$vt_nomFile+"_"+DTS_MakeFromDateTime +".xml"
	$raizAlumnos:=DOM Create XML Ref:C861("Alumnos")
	DOM SET XML DECLARATION:C859($raizAlumnos;"ISO-8859-1")
	
	For ($vl_Records;1;Size of array:C274($al_recNumAlumnos))
		GOTO RECORD:C242([Alumnos:2];$al_recNumAlumnos{$vl_Records})
		$refAlumno:=DOM_SetElementValueAndAttr ($raizAlumnos;"Alumno")
		DOM_SetElementValueAndAttr ($refAlumno;"apellido_paterno";XML_GetValidXMLText ([Alumnos:2]Apellido_paterno:3);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"apellido_materno";XML_GetValidXMLText ([Alumnos:2]Apellido_materno:4);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"nombres";XML_GetValidXMLText ([Alumnos:2]Nombres:2);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"ID";String:C10([Alumnos:2]numero:1);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"curso";XML_GetValidXMLText ([Alumnos:2]curso:20);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"year";String:C10(<>gYear);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"nivel";String:C10([Alumnos:2]nivel_numero:29);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"ID_familia";String:C10([Alumnos:2]Familia_Número:24);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"ID_apoderado_cuentas";String:C10([Alumnos:2]Apoderado_Cuentas_Número:28);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"ID_apoderado_academico";String:C10([Alumnos:2]Apoderado_académico_Número:27);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"email";XML_GetValidXMLText ([Alumnos:2]eMAIL:68);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"fecha_nacimiento";Substring:C12(DTS_MakeFromDateTime ([Alumnos:2]Fecha_de_nacimiento:7);1;8);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"telefono_domicilio";XML_GetValidXMLText ([Alumnos:2]Telefono:17);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"celular";XML_GetValidXMLText ([Alumnos:2]Celular:95);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"sexo";XML_GetValidXMLText ([Alumnos:2]Sexo:49);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"identificador_nacional";XML_GetValidXMLText ([Alumnos:2]RUT:5);True:C214)
		DOM_SetElementValueAndAttr ($refAlumno;"estado";XML_GetValidXMLText ([Alumnos:2]Status:50);True:C214)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$vl_Records/$vl_RecordsToSend)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	DOM EXPORT TO FILE:C862($raizAlumnos;$vt_FileName)
	If (ok=1)
		  //archivo generado correctamente
		CMT_LogAction ("Información";"Generación del documento con "+String:C10($vl_RecordsToSend)+" registros de alumnos.")
		  //<comprime y elimina archivo
		$zipFileName:=Replace string:C233($vt_FileName;".xml";".zip")
		$path2:=$vt_FileName
		$path:=SYS_GetParentNme ($vt_FileName)
		$l_resultado:=Zip ($vt_FileName;$zipFileName)
		DELAY PROCESS:C323(Current process:C322;300)  //para permitir que ZIP Save File "suelte" el archivo para poder eliminarlo...
		If (SYS_TestPathName ($zipFileName)=Is a document:K24:1)
			DELETE DOCUMENT:C159($path2)
		Else 
			CMT_LogAction ("Información";"El archivo "+$vt_FileName+" no pudo ser comprimido correctamente.")
		End if 
		
	Else 
		  //archivo no generado
		CMT_LogAction ("Error";"El documento con registros de alumnos no pudo ser generado";Error)
	End if 
	DOM CLOSE XML:C722($raizAlumnos)
End if 
ON ERR CALL:C155("")