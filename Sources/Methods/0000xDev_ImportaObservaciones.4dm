//%attributes = {}
  // MÉTODO: 0000xDev_ImportaObservaciones
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 03/04/12, 22:53:33
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // 0000xDev_ImportaObservaciones()
  // ----------------------------------------------------
C_LONGINT:C283($i;$l_Columnas;$l_filas;$l_periodo;$l_respuestaUsuario;$l_tamañoDocumento)
C_TIME:C306($h_referenciaLog;$h_refDocumento)
C_POINTER:C301($y_CampoObservaciones)
C_TEXT:C284($t_registroLog;$t_apellidoPaternoAlumno;$t_codigoInternoAlumno;$t_comandoOS;$t_directorioDocumento;$t_nombreDocumento;$t_nombreInternoAsignatura;$t_nombresAlumno;$t_observaciones)
C_TEXT:C284($t_rutaDocumento;$t_rutaLog;$t_separadorColumnas;$t_separadorFilas;$text)

ARRAY TEXT:C222($at_logImportacion;0)




  // CODIGO PRINCIPAL
$l_respuestaUsuario:=CD_Dlog (0;__ ("Antes de comenzar la importación de observaciones debe hacer un respaldo de la base de datos.\r\rSi ya posee un respaldo actualizado presione Continuar, de lo contrario respalde la base de datos y vuelva a ejecutar esta opción.");"";__ ("Cancelar");__ ("Continuar"))

If ($l_respuestaUsuario=2)
	$t_nombreDocumento:=Select document:C905(1;"Seleccione el documento con las observaciones a importar";"TEXT;.csv;.txt";0)
	$t_rutaDocumento:=document
	  // conservo la ruta del directorio en que se encuentra el documento paraeventualmente poner ahí el log
	$t_directorioDocumento:=SYS_GetFolderNam ($t_rutaDocumento)
	  // analizo el documento para obtener los separadores de filas y columnas que utiliza
	$l_tamañoDocumento:=SYS_getTextFileProperties ($t_rutaDocumento;2+4;->$t_separadorFilas;->$t_separadorColumnas;->$l_filas;->$l_Columnas)
	
	
	
	
	Case of 
		: ($l_tamañoDocumento=-1)
			CD_Dlog (0;__ ("El archivo seleccionado no parece ser un archivo de texto.\rNo es posible importar la información que contiene"))
		: ($l_tamañoDocumento<-1)
			CD_Dlog (0;__ ("La estructura del archivo no es válida.\rNo es posible importar la información que contiene"))
		: (($t_separadorFilas="") | ($t_separadorColumnas=""))
			CD_Dlog (0;__ ("No fue posible determinar con seguridad los separadores de filas y columnas utilizados en el archivo.\rNo es posible importar la información que contiene"))
			
			
			  // se inicia la importación sólo si no hay errores
		: ($l_tamañoDocumento>0)
			
			If (SYS_IsWindows )
				USE CHARACTER SET:C205("windows-1252";1)
			Else 
				USE CHARACTER SET:C205("MacRoman";1)
			End if 
			
			$h_refDocumento:=Open document:C264($t_rutaDocumento;"";Read mode:K24:5)
			RECEIVE PACKET:C104($h_refDocumento;$text;$t_separadorFilas)
			While ($text#"")
				$t_registroLog:=""
				$t_codigoInternoAlumno:=ST_GetCleanString (ST_GetWord ($text;1;$t_separadorColumnas))
				$t_apellidoPaternoAlumno:=ST_GetCleanString (ST_GetWord ($text;2;$t_separadorColumnas))
				$t_nombresAlumno:=ST_GetCleanString (ST_GetWord ($text;3;$t_separadorColumnas))
				$t_nombreInternoAsignatura:=ST_GetCleanString (ST_GetWord ($text;4;$t_separadorColumnas))
				$t_observaciones:=ST_GetCleanString (ST_GetWord ($text;5;$t_separadorColumnas))
				$t_periodo:=ST_GetCleanString (ST_GetWord ($text;6;$t_separadorColumnas))
				$l_periodo:=Num:C11($t_periodo)
				If (($t_codigoInternoAlumno#"") & ($t_apellidoPaternoAlumno#"") & ($t_nombresAlumno#"") & ($t_nombreInternoAsignatura#"") & ($t_observaciones#""))
					Case of 
						: ($t_periodo="")
							  // nada el registro no será importado, entrada en el log más abajo
						: ($l_periodo=0)
							$y_CampoObservaciones:=->[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
						: ($l_periodo=1)
							$y_CampoObservaciones:=->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
						: ($l_periodo=2)
							$y_CampoObservaciones:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
						: ($l_periodo=3)
							$y_CampoObservaciones:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
						: ($l_periodo=4)
							$y_CampoObservaciones:=->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
						: ($l_periodo=5)
							$y_CampoObservaciones:=->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
					End case 
					
					
					QUERY:C277([Alumnos:2];[Alumnos:2]Codigo_interno:6=$t_codigoInternoAlumno;*)
					QUERY:C277([Alumnos:2]; & [Alumnos:2]Apellido_paterno:3=$t_apellidoPaternoAlumno;*)
					QUERY:C277([Alumnos:2]; & [Alumnos:2]Nombres:2=$t_nombresAlumno)
					
					  // si no encuentro un alumnos que corresponda al código, apellido paterno y nombres busco un alumno que corresponda al código
					  // y registro la situación en el log
					If (Records in selection:C76([Alumnos:2])=0)
						$t_registroLog:="[ADVERTENCIA] No hay coincidencia exacta en SchoolTrack entre los nombres y apellidos ("+$t_nombresAlumno+" "+$t_apellidoPaternoAlumno+") y el codigo del alumno ("+$t_codigoInternoAlumno+"). La observación fue importada."
						QUERY:C277([Alumnos:2];[Alumnos:2]Codigo_interno:6=$t_codigoInternoAlumno)
					End if 
					
					Case of 
						: (Records in selection:C76([Alumnos:2])=0)
							$t_registroLog:="[ERROR] No se encontró el alumno código "+$t_codigoInternoAlumno+", "+$t_nombresAlumno+" "+$t_apellidoPaternoAlumno+". La observación no fue importada."
							
						: (Records in selection:C76([Alumnos:2])>1)
							$t_registroLog:="[ERROR] Se encontró más de un alumno con el código "+$t_codigoInternoAlumno+". La observación no fue importada."
							
						: ($t_periodo="")
							$t_registroLog:="[ERROR] El registro para el alumno código "+$t_codigoInternoAlumno+", asignatura "+$t_nombreInternoAsignatura+" no tiene número de período válido. La observación no fue importada."
							
						: (Records in selection:C76([Alumnos:2])=1)
							  // obtengo los registros de calificaciones del alumno en memoria (solo los de su nivel actual)
							EV2_RegistrosDelAlumno ([Alumnos:2]numero:1)
							
							  // restringo la selección de registros de calificaciones a aquella que corresponde al nombre interno de la observación en importación
							  // utilizo SET FIELD RELATION, para activar solo la relación con la tabla Asignaturas, sin cambiar la selección actual de alumnos
							SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Asignatura:5;Automatic:K51:4;Structure configuration:K51:2)
							QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]denominacion_interna:16=$t_nombreInternoAsignatura)
							SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Asignatura:5;Structure configuration:K51:2;Structure configuration:K51:2)
							
							  // asigno la observación o registro en el log el texto de error
							Case of 
								: (Records in selection:C76([Alumnos_Calificaciones:208])=1)
									KRL_ReloadInReadWriteMode (->[Alumnos_Calificaciones:208])
									$t_observaciones:=Replace string:C233($t_observaciones;"NAME";$t_nombresAlumno)
									$y_CampoObservaciones->:=$t_observaciones
									SAVE RECORD:C53([Alumnos_Calificaciones:208])
									KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
									
								: (Records in selection:C76([Alumnos_Calificaciones:208])=0)
									$t_registroLog:="No fue encontrado el registro de evaluaciones de la asignatura "+$t_nombreInternoAsignatura+" para el alumno código "+$t_codigoInternoAlumno+"."
									
								: (Records in selection:C76([Alumnos_Calificaciones:208])>1)
									$t_registroLog:="Se encontró más de un registro de evaluaciones para la asignatura "+$t_nombreInternoAsignatura+", para el alumno código "+$t_codigoInternoAlumno+"."
									
							End case 
					End case 
					
					If ($t_registroLog#"")
						APPEND TO ARRAY:C911($at_logImportacion;$t_registroLog)
					End if 
				End if 
				RECEIVE PACKET:C104($h_refDocumento;$text;$t_separadorFilas)
			End while 
			CLOSE DOCUMENT:C267($h_refDocumento)
			
			If (Size of array:C274($at_logImportacion)>0)
				If (SYS_IsWindows )
					USE CHARACTER SET:C205("windows-1252";0)
				Else 
					USE CHARACTER SET:C205("MacRoman";0)
				End if 
				$t_rutaLog:=$t_directorioDocumento+"Importacion Observaciones.txt"
				$h_referenciaLog:=Create document:C266($t_rutaLog)
				For ($i;1;Size of array:C274($at_logImportacion))
					SEND PACKET:C103($h_referenciaLog;$at_logImportacion{$i}+Char:C90(Carriage return:K15:38))
				End for 
				CLOSE DOCUMENT:C267($h_referenciaLog)
				$l_respuestaUsuario:=CD_Dlog (0;__ ("Se detectaron problemas durante la importación de observaciones.\rEl detalle está en el documento:\r"+$t_rutaLog+"\r\r¿Desea consultarlo ahora mismo?");"";__ ("Ver documento");__ ("No"))
				OPEN URL:C673($t_rutaLog)
				
				
			End if 
			
	End case 
End if 


USE CHARACTER SET:C205(*;0)
USE CHARACTER SET:C205(*;1)