//%attributes = {}
  // ASrs_RegistraInasistencia()
  // Por: Alberto Bachler: 02/07/13, 19:40:42
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)


C_LONGINT:C283($l_IdAlumno;$l_IdSesion;$l_resultado)
C_TEXT:C284($t_motivoLicencia)
C_TEXT:C284($t_asignatura;$t_asignaturaCurso;$t_alumno)  //20170415 RCH
If (False:C215)
	C_LONGINT:C283(ASrs_RegistraInasistencia ;$0)
	C_LONGINT:C283(ASrs_RegistraInasistencia ;$1)
	C_LONGINT:C283(ASrs_RegistraInasistencia ;$2)
End if 

$l_IdSesion:=Abs:C99($1)
$l_IdAlumno:=$2


KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_IdSesion;False:C215)

  // determino si el alumno tiene ya una licencia registrada
READ ONLY:C145([Alumnos_Licencias:73])
QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=$l_IdAlumno;*)
QUERY:C277([Alumnos_Licencias:73]; & ;[Alumnos_Licencias:73]Desde:2<=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
QUERY:C277([Alumnos_Licencias:73]; & ;[Alumnos_Licencias:73]Hasta:3>=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)
If (Records in selection:C76([Alumnos_Licencias:73])>0)
	$t_motivoLicencia:="Licencia Nº "+String:C10([Alumnos_Licencias:73]ID:6)+": "+[Alumnos_Licencias:73]Tipo_licencia:4
End if 

If ((OK=1) & ([Asignaturas_RegistroSesiones:168]Impartida:5))
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$l_IdSesion;*)
	QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]ID_Alumno:2=$l_IdAlumno)
	If (Records in selection:C76([Asignaturas_Inasistencias:125])=0)
		CREATE RECORD:C68([Asignaturas_Inasistencias:125])
		[Asignaturas_Inasistencias:125]ID_Asignatura:6:=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2
		[Asignaturas_Inasistencias:125]ID_Sesión:1:=$l_IdSesion
		[Asignaturas_Inasistencias:125]ID_Alumno:2:=$l_IdAlumno
		[Asignaturas_Inasistencias:125]dateSesion:4:=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3
		[Asignaturas_Inasistencias:125]Dia:7:=[Asignaturas_RegistroSesiones:168]NumeroDia:15
		[Asignaturas_Inasistencias:125]Hora:8:=[Asignaturas_RegistroSesiones:168]Hora:4
		[Asignaturas_Inasistencias:125]Año:11:=<>gYear
		[Asignaturas_Inasistencias:125]Justificacion:3:=$t_motivoLicencia
		SAVE RECORD:C53([Asignaturas_Inasistencias:125])
		
		  //20170415 RCH
		$t_asignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Asignaturas:18]denominacion_interna:16)
		$t_asignaturaCurso:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Asignaturas:18]Curso:5)
		$t_alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_IdAlumno;->[Alumnos:2]apellidos_y_nombres:40)
		LOG_RegisterEvt ("Asistencia por hora detallada: "+String:C10([Asignaturas_Inasistencias:125]dateSesion:4)+" Inasistencia en la hora "+String:C10([Asignaturas_Inasistencias:125]Hora:8)+" de "+$t_asignatura+" "+$t_asignaturaCurso+", para "+$t_alumno)
		
		AL_InasistenciaDiariaPorHoras ($l_IdAlumno;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)
		$l_resultado:=1
		
		KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_IdSesion;True:C214)
		If ([Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18=False:C215)
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=True:C214
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=String:C10(Current date:C33(*);ISO date GMT:K1:10;Current time:C178(*))
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=USR_GetUserName (USR_GetUserID )
			SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
		End if 
	End if 
End if 

KRL_ReloadAsReadOnly (->[Asignaturas_RegistroSesiones:168])
$0:=$l_resultado
