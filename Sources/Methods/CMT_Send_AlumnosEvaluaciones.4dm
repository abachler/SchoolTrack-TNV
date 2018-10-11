//%attributes = {}
  //CMT_Send_AlumnosEvaluaciones

C_BLOB:C604($blob)
C_LONGINT:C283($vl_RecordsToSend)
C_TEXT:C284($t_resultadoCompresion)
C_BOOLEAN:C305($b_archivoComprimido)

$vt_nomFile:="AEvaluaciones"


Error:=0
If (Is compiled mode:C492)
	ON ERR CALL:C155("ERR_CMTErrorsCallBack")
End if 
READ ONLY:C145([Alumnos_Calificaciones:208])

$vl_proc:=IT_UThermometer (1;0;__ ("Buscanco registros de Alumnos Asignaturas..."))
QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6>0)

ARRAY LONGINT:C221($al_idsAlumnos;0)
ARRAY LONGINT:C221($al_idsAsignaturas;0)
ARRAY TEXT:C222($as_llavePrincipal;0)
IT_UThermometer (0;$vl_proc;__ ("Cargando datos de Alumnos Asignaturas..."))
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_idsAlumnos;[Alumnos_Calificaciones:208]ID_Asignatura:5;$al_idsAsignaturas;[Alumnos_Calificaciones:208]Llave_principal:1;$as_llavePrincipal)
IT_UThermometer (-2;$vl_proc)

$vl_RecordsToSend:=Records in selection:C76([Alumnos_Calificaciones:208])

If ($vl_RecordsToSend>0)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($vl_RecordsToSend)+__ (" registros de Alumnos Asignaturas..."))
	$vt_FileName:=SYS_CarpetaAplicacion (CLG_Intercambios_CMT)+<>vtXS_CountryCode+"_"+<>gRolBD+"_"+$vt_nomFile+"_"+DTS_MakeFromDateTime +".xml"
	$raizAsignaturas:=DOM Create XML Ref:C861("alumnos_asignaturas")
	DOM SET XML DECLARATION:C859($raizAsignaturas;"ISO-8859-1")
	
	
	For ($vl_Records;1;Size of array:C274($al_idsAlumnos))
		$refAlAsignaturas:=DOM_SetElementValueAndAttr ($raizAsignaturas;"alumno_asignatura")
		DOM_SetElementValueAndAttr ($refAlAsignaturas;"ID_alumno";String:C10($al_idsAlumnos{$vl_Records});True:C214)
		DOM_SetElementValueAndAttr ($refAlAsignaturas;"ID_asignatura";String:C10($al_idsAsignaturas{$vl_Records});True:C214)
		DOM_SetElementValueAndAttr ($refAlAsignaturas;"ID";$as_llavePrincipal{$vl_Records};True:C214)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$vl_Records/$vl_RecordsToSend)
	End for 
	
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	DOM EXPORT TO FILE:C862($raizAsignaturas;$vt_FileName)
	If (ok=1)
		  //archivo generado correctamente
		CMT_LogAction ("Información";"Generación del documento con "+String:C10($vl_RecordsToSend)+" registros de Alumnos Asignaturas.")
		
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
		CMT_LogAction ("Error";"El documento con registros de evaluaciones no pudo ser generado";Error)
	End if 
	DOM CLOSE XML:C722($raizAsignaturas)
End if 
ON ERR CALL:C155("")

