//%attributes = {}
  // TMT_InfoAsignacionAsignatura()
  // Por: Alberto Bachler: 30/05/13, 16:37:59
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($i;$l_IdAsignatura)

ARRAY INTEGER:C220($ai_diaAsignacion;0)
If (False:C215)
	C_LONGINT:C283(TMT_InfoAsignacionAsignatura ;$1)
End if 
ARRAY TEXT:C222(at_DiasAsignados;0)
ARRAY TEXT:C222(at_asignacionDesde;0)
ARRAY TEXT:C222(at_asignacionHasta;0)
ARRAY LONGINT:C221(al_recnumAsignaciones;0)
ARRAY INTEGER:C220(ai_HorasAsignadas;0)
ARRAY TEXT:C222(at_SalasAsignadas;0)
ARRAY LONGINT:C221(al_InasistenciasAlumno;0)
ARRAY LONGINT:C221(al_InasistenciasAsignacion;0)

$l_IdAsignatura:=$1

KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_IdAsignatura)

READ ONLY:C145([TMT_Horario:166])
QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=$l_IdAsignatura)
ORDER BY:C49([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1;>;[TMT_Horario:166]NumeroHora:2;>)
SELECTION TO ARRAY:C260([TMT_Horario:166];al_recnumAsignaciones;[TMT_Horario:166]NumeroDia:1;$ai_diaAsignacion;[TMT_Horario:166]NumeroHora:2;ai_HorasAsignadas;[TMT_Horario:166]Sala:8;at_SalasAsignadas;[TMT_Horario:166]SesionesDesde:12;ad_asignacionDesde;[TMT_Horario:166]SesionesHasta:13;ad_asignacionHasta)

EV2_RegistrosDeLaAsignatura ($l_IdAsignatura)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]apellidos_y_nombres:40;>)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;al_TMT_IdAlumno;[Alumnos:2]Nombre_Común:30;atTMT_alumnos_nombres;[Alumnos:2]curso:20;atTMT_alumnos_curso;[Alumnos:2]apellidos_y_nombres:40;at_ApellidosNombres)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
ARRAY LONGINT:C221(al_InasistenciasAlumno;Size of array:C274(al_TMT_IdAlumno))
ARRAY LONGINT:C221(al_InasistenciasAsignacion;Size of array:C274(al_TMT_IdAlumno))

If (Size of array:C274(atTMT_alumnos_nombres)>0)
	vt_etiquetaAlumnos:=__ ("Alumnos")+" ("+String:C10(Size of array:C274(atTMT_alumnos_nombres))+")"
Else 
	vt_etiquetaAlumnos:=__ ("Alumnos")
End if 

ARRAY TEXT:C222(at_DiasAsignados;Size of array:C274($ai_diaAsignacion))
For ($i;1;Size of array:C274($ai_diaAsignacion))
	at_DiasAsignados{$i}:=DT_DayNameFromISODayNumber ($ai_diaAsignacion{$i})
End for 

WDW_OpenFormWindow (->[TMT_Horario:166];"InfoAsignacionAsignatura";-1;8)
DIALOG:C40([TMT_Horario:166];"InfoAsignacionAsignatura")
CLOSE WINDOW:C154

