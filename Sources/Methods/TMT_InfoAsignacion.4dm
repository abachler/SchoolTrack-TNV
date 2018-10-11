//%attributes = {}
  // TMT_InfoAsignacion()
  // Por: Alberto Bachler: 23/05/13, 19:17:55
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_BOOLEAN:C305($0)

C_DATE:C307($d_FechaInicioAnterior;$d_FechaTerminoAnterior)
_O_C_INTEGER:C282($i_alumnos;$i_sesiones)
C_LONGINT:C283($i;$l_inasistencias;$l_InasistenciasAsignacion;$l_recNumAsignacion)
C_BOOLEAN:C305($b_asignacionModificada)

ARRAY LONGINT:C221($al_IdSesion;0)
If (False:C215)
	C_BOOLEAN:C305(TMT_InfoAsignacion ;$0)
	C_LONGINT:C283(TMT_InfoAsignacion ;$1)
End if 

$l_recNumAsignacion:=$1

KRL_GotoRecord (->[TMT_Horario:166];$l_recNumAsignacion;True:C214)

$d_FechaInicioAnterior:=[TMT_Horario:166]SesionesDesde:12
$d_FechaTerminoAnterior:=[TMT_Horario:166]SesionesHasta:13

vt_DiaYHora:=DT_DayNameFromISODayNumber ([TMT_Horario:166]NumeroDia:1)+", "+String:C10([TMT_Horario:166]NumeroHora:2)+__ ("ª hora")

QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[TMT_Horario:166]ID_Asignatura:5;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]NumeroDia:15=[TMT_Horario:166]NumeroDia:1;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=[TMT_Horario:166]NumeroHora:2;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=[TMT_Horario:166]No_Ciclo:14)
QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=[TMT_Horario:166]SesionesDesde:12;*)
QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=[TMT_Horario:166]SesionesHasta:13)
ORDER BY:C49([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;<)
SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168];al_recNumSesiones;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;ad_FechaSesiones;[Asignaturas_RegistroSesiones:168]ID_Sesion:1;$al_IdSesion)
ARRAY LONGINT:C221(al_Inasistencias;Size of array:C274(al_recNumSesiones))

SET QUERY DESTINATION:C396(Into variable:K19:4;$l_inasistencias)
For ($i;1;Size of array:C274(al_recNumSesiones))
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$al_IdSesion{$i})
	al_Inasistencias{$i}:=$l_inasistencias
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)

KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;False:C215)
EV2_RegistrosDeLaAsignatura ([TMT_Horario:166]ID_Asignatura:5)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]apellidos_y_nombres:40;>)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;al_TMT_IdAlumno;[Alumnos:2]Nombre_Común:30;atTMT_alumnos_nombres;[Alumnos:2]curso:20;atTMT_alumnos_curso;[Alumnos:2]apellidos_y_nombres:40;at_ApellidosNombres)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

ARRAY LONGINT:C221(al_InasistenciasAlumno;Size of array:C274(atTMT_alumnos_nombres))
ARRAY LONGINT:C221(al_InasistenciasAsignacion;Size of array:C274(atTMT_alumnos_nombres))
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_Inasistencias)
For ($i_alumnos;1;Size of array:C274(atTMT_alumnos_nombres))
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=al_TMT_IdAlumno{$i_alumnos};*)
	QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]ID_Asignatura:6=[Asignaturas:18]Numero:1;*)
	QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]Año:11=<>gYear)
	al_InasistenciasAlumno{$i_alumnos}:=$l_Inasistencias
	
	$l_InasistenciasAsignacion:=0
	For ($i_sesiones;1;Size of array:C274(ad_FechaSesiones))
		QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=al_TMT_IdAlumno{$i_alumnos};*)
		QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]ID_Asignatura:6=[Asignaturas:18]Numero:1;*)
		QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Sesión:1=$al_IdSesion{$i_sesiones})
		$l_InasistenciasAsignacion:=$l_InasistenciasAsignacion+$l_Inasistencias
	End for 
	al_InasistenciasAsignacion{$i_alumnos}:=$l_InasistenciasAsignacion
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)

WDW_OpenFormWindow (->[TMT_Horario:166];"InfoSesiones";-1;Movable form dialog box:K39:8;__ ("Asignación de horario"))
KRL_ModifyRecord (->[TMT_Horario:166];"InfoSesiones")
CLOSE WINDOW:C154
If (($d_FechaInicioAnterior#[TMT_Horario:166]SesionesDesde:12) | ($d_FechaTerminoAnterior#[TMT_Horario:166]SesionesHasta:13))
	$b_asignacionModificada:=True:C214
End if 
KRL_ReloadAsReadOnly (->[TMT_Horario:166])

$0:=$b_asignacionModificada