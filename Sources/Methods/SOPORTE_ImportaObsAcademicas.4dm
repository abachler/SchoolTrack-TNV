//%attributes = {}
  //Método: SOPORTE_ImportaObsAcademicas



  //********************************************
  //********* NO COPIAR A SCHOOLTRACK X ********
  //********************************************


C_TEXT:C284($codigoAlumno;$curso;$asignatura;$observaciones)

Case of 
	: (Count parameters:C259>0)
		$identificador:=$1
		$tipoArchivo:=$2
		$path:=$3
		  //$ref:=Append document($path)
		  //$size:=Get document size(document)
		  //SEND PACKET($ref;"\r")
		  //CLOSE DOCUMENT($ref)
	Else 
		$ref:=Open document:C264("")
		  //$size:=Get document size(document)
		  //SET DOCUMENT POSITION($ref;$size)
		  //SEND PACKET($ref;"\r")
		  //CLOSE DOCUMENT($ref)
End case 
$size:=Get document size:C479(document)


0xDev_AvoidTriggerExecution (True:C214)
ARRAY TEXT:C222($aErrores;0)

If ($tipoArchivo#"")
	If ($tipoArchivo="Win")
		USE CHARACTER SET:C205("windows-1252";1)
	Else 
		USE CHARACTER SET:C205("MacRoman";1)
	End if 
Else 
	If (SYS_IsWindows )
		USE CHARACTER SET:C205("windows-1252";1)
	Else 
		USE CHARACTER SET:C205("MacRoman";1)
	End if 
End if 


READ WRITE:C146([Alumnos_Calificaciones:208])
READ WRITE:C146([Asignaturas:18])
$ref:=Open document:C264(document;Read mode:K24:5)
$size:=Get document size:C479(document)
RECEIVE PACKET:C104($ref;$text;"\r")



$p:=IT_UThermometer (1;0;"Normalizando identificador...")
READ WRITE:C146([Alumnos:2])
ALL RECORDS:C47([Alumnos:2])
APPLY TO SELECTION:C70([Alumnos:2];$identificador->:=ST_GetCleanString ($identificador->))
$p:=IT_UThermometer (-2;$p)

$length:=0
$lineNumber:=0

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Importando registros de notas... ")
While ((ok=1) & ($text#""))
	$lineNumber:=$lineNumber+1
	$length:=$length+Length:C16($text)+1
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$length/$size;"Importando Observaciones...")
	ARRAY TEXT:C222(aText1;0)
	AT_Text2Array (->aText1;$text;"\t")
	ARRAY TEXT:C222(aText1;9)
	$codigoAlumno:=ST_GetCleanString (aText1{1})
	$codigoAsignatura:=ST_GetCleanString (aText1{2})
	$asignatura:=ST_GetCleanString (aText1{3})
	$obsP1:=ST_GetCleanString (aText1{4})
	$obsP2:=ST_GetCleanString (aText1{5})
	$obsP3:=ST_GetCleanString (aText1{6})
	$obsP4:=ST_GetCleanString (aText1{7})
	$obsP5:=ST_GetCleanString (aText1{8})
	$obsF:=ST_GetCleanString (aText1{9})
	
	$go:=True:C214
	If ($codigoAlumno#"")
		$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]Codigo_interno:6;->$codigoAlumno)
		If ($recNum<0)
			APPEND TO ARRAY:C911($aErrores;("Alumno no encontrado"+"\t"+$codigoAlumno+"\t"+$curso+"\t"+$asignatura+"\t"+$observaciones))
			$go:=False:C215
		End if 
	End if 
	
	  //If ($go)
	  //If (($curso#"") & ([Alumnos]Curso#$curso) & ([Alumnos]Status#"Retirado@"))
	  //APPEND TO ARRAY($aErrores;("Curso incorrecto"+"\t"+$codigoAlumno+"\t"+$curso+"\t"+$asignatura+"\t"+$observaciones))
	  //$go:=False
	  //End if 
	  //End if 
	
	If ($go)
		$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]Codigo_interno:6;->$codigoAlumno)
		EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;$aId;[Asignaturas:18]denominacion_interna:16;$aNames;[Asignaturas:18]CHILE_CodigoMineduc:41;$aCodigoAsignatura)
		Case of 
			: (($codigoAsignatura#"") & ($asignatura=""))
				QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]CHILE_CodigoMineduc:41=$codigoAsignatura)
				
			: (($codigoAsignatura#"") & ($asignatura#""))
				QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]denominacion_interna:16=$asignatura;*)
				QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & [Asignaturas:18]CHILE_CodigoMineduc:41=$codigoAsignatura)
				
			: (($codigoAsignatura="") & ($asignatura#""))
				QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]denominacion_interna:16=$asignatura)
				
			Else 
				APPEND TO ARRAY:C911($aErrores;("No hay referencia a ninguna asignatura"+"\t"+$codigoAlumno+"\t"+$codigoAsignatura+"\t"+$asignatura+"\t"+$obsP1+"\t"+$obsP2+"\t"+$obsP3+"\t"+$obsP4+"\t"+$obsP5+"\t"+$obsF))
				$go:=False:C215
		End case 
		
		If ($go)
			Case of 
				: (Records in selection:C76([Alumnos_Calificaciones:208])=0)
					APPEND TO ARRAY:C911($aErrores;("Asignatura no encontrada"+"\t"+$codigoAlumno+"\t"+$codigoAsignatura+"\t"+$asignatura+"\t"+$obsP1+"\t"+$obsP2+"\t"+$obsP3+"\t"+$obsP4+"\t"+$obsP5+"\t"+$obsF))
				: (Records in selection:C76([Alumnos_Calificaciones:208])=1)
					$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->[Alumnos_Calificaciones:208]Llave_principal:1;True:C214)
					If ($recNum<0)
						CREATE RECORD:C68([Alumnos_ComplementoEvaluacion:209])
						[Alumnos_ComplementoEvaluacion:209]Año:3:=<>GYear
						[Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4:=[Alumnos_Calificaciones:208]NIvel_Numero:4
						[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5:=[Alumnos_Calificaciones:208]ID_Asignatura:5
						[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6:=[Alumnos_Calificaciones:208]ID_Alumno:6
						SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
					End if 
					If ($obs1#"")
						[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19:=$obs1
					End if 
					If ($obs2#"")
						[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24:=$obs2
					End if 
					If ($obs3#"")
						[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29:=$obs3
					End if 
					If ($obs4#"")
						[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34:=$obs4
					End if 
					If ($obs5#"")
						[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39:=$obs5
					End if 
					If ($obsf#"")
						[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46:=$obsF
					End if 
					If (vCR_Replacement#"")
						[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19:=Replace string:C233([Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;vCR_Replacement;Char:C90(Carriage return:K15:38))
						[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24:=Replace string:C233([Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24;vCR_Replacement;Char:C90(Carriage return:K15:38))
						[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29:=Replace string:C233([Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;vCR_Replacement;Char:C90(Carriage return:K15:38))
						[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34:=Replace string:C233([Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;vCR_Replacement;Char:C90(Carriage return:K15:38))
						[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39:=Replace string:C233([Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;vCR_Replacement;Char:C90(Carriage return:K15:38))
						[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46:=Replace string:C233([Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46;vCR_Replacement;Char:C90(Carriage return:K15:38))
					End if 
					SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
					
				: (Records in selection:C76([Alumnos_Calificaciones:208])>1)
					APPEND TO ARRAY:C911($aErrores;("Asignatura no encontrada"+"\t"+$codigoAlumno+"\t"+$codigoAsignatura+"\t"+$asignatura+"\t"+$obsP1+"\t"+$obsP2+"\t"+$obsP3+"\t"+$obsP4+"\t"+$obsP5+"\t"+$obsF))
			End case 
		End if 
	End if 
	
	RECEIVE PACKET:C104($ref;$text;"\r")
	
End while 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
FLUSH CACHE:C297
CLOSE DOCUMENT:C267($ref)
USE CHARACTER SET:C205(*;0)
USE CHARACTER SET:C205(*;1)


  //0xDev_AvoidTriggerExecution (True)
0xDev_AvoidTriggerExecution (False:C215)  //20140325 RCH Se restablece la ejecucion de triggers



If (Size of array:C274($aErrores)>0)
	If (Application type:C494=4D Remote mode:K5:5)
		$t_rutaLogErrores:=SYS_CarpetaAplicacion (CLG_DocumentosLocal)+"Logs"+Folder separator:K24:12+"Errores import obs.txt"
		CREATE FOLDER:C475($t_rutaLogErrores;*)
	Else 
		$t_rutaLogErrores:=SYS_CarpetaAplicacion (CLG_Estructura)+"Logs"+Folder separator:K24:12+"Errores import obs.txt"
	End if 
	CREATE FOLDER:C475($t_rutaLogErrores;*)
	
	
	$docRef:=Create document:C266($t_rutaLogErrores)
	For ($i;1;Size of array:C274($aErrores))
		SEND PACKET:C103($docRef;$aErrores{$i}+"\r")
	End for 
	CLOSE DOCUMENT:C267($docRef)
	CD_Dlog (0;String:C10(Size of array:C274($aErrores))+" registros de notas no pudieron ser importados.\r\rDetalles en el archivo: "+$t_rutaLogErrores)
	SHOW ON DISK:C922($t_rutaLogErrores)
End if 

