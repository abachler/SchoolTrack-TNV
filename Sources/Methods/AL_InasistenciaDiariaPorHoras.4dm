//%attributes = {}
  // AL_InasistenciaDiariaPorHoras()
  // Por: Alberto Bachler: 24/06/13, 18:02:27
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_DATE:C307($2)

C_DATE:C307($d_fecha)
C_LONGINT:C283($i;$l_IdAlumno;$l_inasistencias_a_clases;$l_Nivel;$l_sesiones)

ARRAY DATE:C224($ad_fechasInasistencias;0)
If (False:C215)
	C_LONGINT:C283(AL_InasistenciaDiariaPorHoras ;$1)
	C_DATE:C307(AL_InasistenciaDiariaPorHoras ;$2)
End if 

$l_IdAlumno:=$1
$d_fecha:=$2


READ ONLY:C145([Alumnos_Calificaciones:208])
READ ONLY:C145([Asignaturas_Inasistencias:125])
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Asignaturas_RegistroSesiones:168])
READ WRITE:C146([Alumnos_Inasistencias:10])

$l_inasistencias_a_clases:=0
$l_sesiones:=0
$l_resultado:=1

  // busco todas las inasistencias por horas del alumno en la fecha pasada en $2
QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2;=;$l_IdAlumno;*)
QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4;=;$d_fecha)
$l_inasistencias_a_clases:=Records in selection:C76([Asignaturas_Inasistencias:125])

  // busco las sesiones de clases en las asignaturas que el alumno cursa actualmente para la fecha pasada en $2
QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=$l_IdAlumno)
KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_fecha;*)
QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Impartida:5=True:C214)
REDUCE SELECTION:C351([Alumnos_Calificaciones:208];0)
$l_sesiones:=Records in selection:C76([Asignaturas_RegistroSesiones:168])

Case of 
	: (($l_sesiones=$l_inasistencias_a_clases) & ($l_inasistencias_a_clases>0))
		  // si el número de sesiones es igual a las inasistencias por horas significa que el alumno estuvo ausente todo el día
		  // creo el registro de inasistencia diario.
		READ WRITE:C146([Alumnos_Inasistencias:10])
		QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$l_IdAlumno;*)
		QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=$d_fecha)
		If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
			CREATE RECORD:C68([Alumnos_Inasistencias:10])
			[Alumnos_Inasistencias:10]Alumno_Numero:4:=$l_IdAlumno
			[Alumnos_Inasistencias:10]Fecha:1:=$d_fecha
			[Alumnos_Inasistencias:10]Nivel_Numero:9:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]nivel_numero:29)
		End if 
		[Alumnos_Inasistencias:10]Año:8:=<>gYear
		[Alumnos_Inasistencias:10]Observaciones:3:="Alumno(a) inasistente a todas las sesiones de clases del día."
		[Alumnos_Inasistencias:10]Horas_academicas:7:=$l_sesiones
		[Alumnos_Inasistencias:10]Horas_inasistencia:6:=$l_inasistencias_a_clases
		SAVE RECORD:C53([Alumnos_Inasistencias:10])
		KRL_ReloadAsReadOnly (->[Alumnos_Inasistencias:10])
		AL_AsociaLicenciaInasistencia ("AsociaLicencia";$l_IdAlumno;[Alumnos_Inasistencias:10]Fecha:1)
		
		
	: (($l_sesiones>$l_inasistencias_a_clases) | ($l_sesiones=0))
		  // si el número de sesiones es superior al número de inasistencias por horas significa que el alumno solo estuvo ausente en algunas sesiones
		  // busco y elimino un eventual registro de inasistencia diario.
		READ ONLY:C145([Alumnos_Inasistencias:10])
		QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$l_IdAlumno;*)
		QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=$d_fecha)
		If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
			$l_resultado:=KRL_DeleteSelection (->[Alumnos_Inasistencias:10])
		End if 
End case 

$0:=$l_resultado