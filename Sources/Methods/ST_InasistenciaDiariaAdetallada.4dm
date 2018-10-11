//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 27-09-18, 15:45:58
  // ----------------------------------------------------
  // Método: ST_InasistenciaDiariaAdetallada
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_BOOLEAN:C305($fecha)
C_LONGINT:C283($l_indice;$l_indiceAlu;$l_indiceLicencias;$l_indiceSesion;$l_progress)
C_LONGINT:C283($l_versionPrincipal;$l_versionRevision;$l_versionBD_Build)
C_TEXT:C284($t_mensajeAlu;$t_mensajeLog;$t_mensajeNiveles;$t_mensajeSesion;$t_mensaje;$t_versionBaseDeDatos;$t_versionConFormato)

ARRAY DATE:C224($ad_FechaInasistencias;0)
ARRAY DATE:C224($ad_hasta;0)
ARRAY DATE:C224($ad_LicenciasDesde;0)
ARRAY DATE:C224($ad_LicenciasHasta;0)
ARRAY LONGINT:C221($al_AlumnosID;0)
ARRAY LONGINT:C221($al_asignaturasID;0)
ARRAY LONGINT:C221($al_LicenciasID;0)
ARRAY LONGINT:C221($al_recNumNiveles;0)
ARRAY LONGINT:C221($al_registroSesiones;0)

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([xxSTR_Niveles:6])

QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]AttendanceMode:3=2)
SELECTION TO ARRAY:C260([xxSTR_Niveles:6];$al_recNumNiveles)




$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("build";->$l_versionBD_Build)
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("principal";->$l_versionPrincipal)
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("revision";->$l_versionRevision)

If ($l_versionPrincipal>=12)
	dbu_CreaSesiones 
	
	$t_mensaje:="Para los niveles en los que se encuentra configurado el modo de registro de asistencia "+ST_Qte ("Por Hora, detallado")
	$t_mensaje:=$t_mensaje+", se verificarán las inasistencias diarias registradas y se crearán inasistencia por hora.\r"
	$t_mensaje:=$t_mensaje+"¿Desea continuar?"
	$l_respuesta:=CD_Dlog (1;$t_mensaje;"";"Si";"No")
	
	If ($l_respuesta=1)
		$l_progress:=IT_Progress (1;0;0;"")
		For ($l_indice;1;Size of array:C274($al_recNumNiveles))
			GOTO RECORD:C242([xxSTR_Niveles:6];$al_recNumNiveles{$l_indice})
			QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=[xxSTR_Niveles:6]NoNivel:5)
			
			$t_mensajeNiveles:="Revisando datos en nivel: "+[xxSTR_Niveles:6]Nivel:1
			$l_progress:=IT_Progress (0;$l_progress;$l_indice/Size of array:C274($al_recNumNiveles);$t_mensajeNiveles)
			
			If (Records in selection:C76([Alumnos:2])>0)
				SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_AlumnosID)
				For ($l_indiceAlu;1;Size of array:C274($al_AlumnosID))
					QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$al_AlumnosID{$l_indiceAlu})
					QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=$al_AlumnosID{$l_indiceAlu})
					QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$al_AlumnosID{$l_indiceAlu})
					
					$t_mensajeAlu:="Verificando datos del alumno(a): "+[Alumnos:2]apellidos_y_nombres:40
					$l_progress:=IT_Progress (0;$l_progress;$l_indice/Size of array:C274($al_recNumNiveles);$t_mensajeNiveles;$l_indiceAlu/Size of array:C274($al_AlumnosID);$t_mensajeAlu)
					
					  //busco si existen licencias
					QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos:2]numero:1)
					SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$ad_LicenciasDesde;[Alumnos_Licencias:73]Hasta:3;$ad_LicenciasHasta;[Alumnos_Licencias:73]ID:6;$al_LicenciasID)
					
					If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;$al_asignaturasID)
						AT_DistinctsFieldValues (->[Alumnos_Inasistencias:10]Fecha:1;->$ad_FechaInasistencias)
						QUERY WITH ARRAY:C644([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;$ad_FechaInasistencias)
						QUERY SELECTION WITH ARRAY:C1050([Asignaturas_RegistroSesiones:168]ID_Asignatura:2;$al_asignaturasID)
						If (Records in selection:C76([Asignaturas_RegistroSesiones:168])>0)
							SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168];$al_registroSesiones)
							
							For ($l_indiceSesion;1;Size of array:C274($al_registroSesiones))
								GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];$al_registroSesiones{$l_indiceSesion})
								$t_mensajeSesion:="Verificando sesión ID: "+String:C10([Asignaturas_RegistroSesiones:168]ID_Sesion:1)+"- Fecha: "+String:C10([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)
								$l_progress:=IT_Progress (0;$l_progress;$l_indice/Size of array:C274($al_recNumNiveles);$t_mensajeNiveles;$l_indiceAlu/Size of array:C274($al_AlumnosID);$t_mensajeAlu;$l_indiceSesion/Size of array:C274($al_registroSesiones);$t_mensajeSesion)
								
								QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=[Asignaturas_RegistroSesiones:168]ID_Sesion:1;*)
								QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos:2]numero:1)
								If (Records in selection:C76([Asignaturas_Inasistencias:125])=0)
									CREATE RECORD:C68([Asignaturas_Inasistencias:125])
									[Asignaturas_Inasistencias:125]ID_Alumno:2:=[Alumnos:2]numero:1
									[Asignaturas_Inasistencias:125]ID_Asignatura:6:=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2
									[Asignaturas_Inasistencias:125]dateSesion:4:=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3
									[Asignaturas_Inasistencias:125]ID_Sesión:1:=[Asignaturas_RegistroSesiones:168]ID_Sesion:1
									[Asignaturas_Inasistencias:125]Hora:8:=[Asignaturas_RegistroSesiones:168]Hora:4
									[Asignaturas_Inasistencias:125]Dia:7:=[Asignaturas_RegistroSesiones:168]NumeroDia:15
									[Asignaturas_Inasistencias:125]Año:11:=[Asignaturas_RegistroSesiones:168]Año:13
									
									For ($l_indiceLicencias;1;Size of array:C274($ad_LicenciasDesde))
										If (([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=$ad_LicenciasDesde{$l_indiceLicencias}) & ([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=$ad_LicenciasHasta{$l_indiceLicencias}))
											[Asignaturas_Inasistencias:125]ID_Licencia:9:=$al_LicenciasID{$l_indiceLicencias}
											[Asignaturas_Inasistencias:125]Justificacion:3:="Licencia Nº "+String:C10($al_LicenciasID{$l_indiceLicencias})
											[Asignaturas_Inasistencias:125]Observaciones:5:="Licencia Nº "+String:C10($al_LicenciasID{$l_indiceLicencias})
											$l_indiceLicencias:=Size of array:C274($ad_LicenciasDesde)
										End if 
									End for 
									
									SAVE RECORD:C53([Asignaturas_Inasistencias:125])
									QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
									$t_mensajeLog:="Migración asistencia diaria a hora detallada: Creación de inasistencia. \rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+", Fecha: "+String:C10([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)+"\rHora:"+String:C10([Asignaturas_RegistroSesiones:168]Hora:4)+"\r"
									$t_mensajeLog:=$t_mensajeLog+"Asignatura : "+[Asignaturas:18]Asignatura:3+" (ID: "+String:C10([Asignaturas_RegistroSesiones:168]ID_Asignatura:2)+")"
									LOG_RegisterEvt ($t_mensajeLog)
								End if 
							End for 
							
						End if 
					End if 
				End for 
				
			End if 
		End for 
		$l_progress:=IT_Progress (-1;$l_progress)
	End if 
	
Else 
	CD_Dlog (0;"La versión en la que está ejecutando el script no es compatible, debe actualizar a la última versión pública de SchoolTrack.")
End if 