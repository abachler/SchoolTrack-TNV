//%attributes = {}
  // TMT_LeeDetallesAsignacion()
  // Por: Alberto Bachler: 30/05/13, 17:04:16
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

_O_C_INTEGER:C282($i_alumnos;$i_sesiones)
C_LONGINT:C283($i;$l_inasistencias;$l_InasistenciasAsignacion;$l_recNumAsignacion)

ARRAY LONGINT:C221($al_IdSesion;0)
If (False:C215)
	C_LONGINT:C283(TMT_LeeDetallesAsignacion ;$1)
End if 

$l_recNumAsignacion:=$1
ARRAY LONGINT:C221(al_recNumSesiones;0)
ARRAY DATE:C224(ad_FechaSesiones;0)
ARRAY LONGINT:C221(al_Inasistencias;0)

KRL_GotoRecord (->[TMT_Horario:166];$l_recNumAsignacion)

QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[TMT_Horario:166]ID_Asignatura:5;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]NumeroDia:15=[TMT_Horario:166]NumeroDia:1;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Hora:4=[TMT_Horario:166]NumeroHora:2;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=[TMT_Horario:166]No_Ciclo:14;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=[TMT_Horario:166]SesionesDesde:12;*)
QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=[TMT_Horario:166]SesionesHasta:13)
ORDER BY:C49([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;<)
SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168];al_recNumSesiones;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;ad_FechaSesiones;[Asignaturas_RegistroSesiones:168]ID_Sesion:1;$al_IdSesion)

SET QUERY DESTINATION:C396(Into variable:K19:4;$l_inasistencias)
ARRAY LONGINT:C221(al_Inasistencias;Size of array:C274($al_IdSesion))
For ($i;1;Size of array:C274(al_recNumSesiones))
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$al_IdSesion{$i})
	al_Inasistencias{$i}:=$l_inasistencias
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)

SET QUERY DESTINATION:C396(Into variable:K19:4;$l_inasistencias)
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

KRL_RelateSelection (->[Asignaturas_Inasistencias:125]dateSesion:4;->[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)
If (Size of array:C274(al_RecNumSesiones)>0)
	vt_etiquetaSesiones:=__ ("Sesiones (^0 sesiones, ^1 inasistencias)")
	vt_etiquetaSesiones:=Replace string:C233(vt_etiquetaSesiones;"^0";String:C10(Size of array:C274(al_RecNumSesiones)))
	vt_etiquetaSesiones:=Replace string:C233(vt_etiquetaSesiones;"^1";String:C10(AT_GetSumArray (->al_Inasistencias)))
Else 
	vt_etiquetaSesiones:=__ ("Sesiones")
End if 

LISTBOX SORT COLUMNS:C916(lb_alumnos;5;>)
vl_ColumnaAlumnos:=1