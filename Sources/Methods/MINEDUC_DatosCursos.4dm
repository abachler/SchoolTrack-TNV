//%attributes = {}
  //MINEDUC_DatosCursos

If (Count parameters:C259=0)
	QUERY:C277([MINEDUC_Documentos:171];[MINEDUC_Documentos:171]Tipo_documento:1="Boletin Subvenciones";*)
	QUERY:C277([MINEDUC_Documentos:171];[MINEDUC_Documentos:171]Año:2=<>gYear)
	ORDER BY:C49([MINEDUC_Documentos:171];[MINEDUC_Documentos:171]Año:2;<;[MINEDUC_Documentos:171]Mes:3;<)
	$nextMonth:=[MINEDUC_Documentos:171]Mes:3+1
Else 
	$nextMonth:=$1
End if 
$begindate:=DT_GetDateFromDayMonthYear (1;$nextmonth;<>gYear)
While (Not:C34(DateIsValid ($begindate;0)))
	$begindate:=$beginDate+1
End while 
$endDate:=DT_GetDateFromDayMonthYear (DT_GetLastDay2 ($begindate);Month of:C24($beginDate);<>gYear)
While (Not:C34(DateIsValid ($endDate;0)))
	$endDate:=$endDate-1
End while 
SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
QUERY:C277([xShell_Feriados:71];[xShell_Feriados:71]Fecha:1>=$begindate;*)
QUERY:C277([xShell_Feriados:71]; & [xShell_Feriados:71]Fecha:1<=$endDate)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
$Days:=$endDate-$begindate+1

For ($i;1;Size of array:C274(aDiasHabiles))
	aDiasHabiles{$i}:=$Days
End for 

READ ONLY:C145([Cursos:3])
QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7>=1;*)
QUERY:C277([Cursos:3]; & [Cursos:3]Nivel_Numero:7<=8;*)
QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>0)
ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>)
SELECTION TO ARRAY:C260([Cursos:3]Nivel_Nombre:10;at_Mineduc_Nivel;[Cursos:3]Curso:1;at_Mineduc_LetraCurso;[Cursos:3]Nivel_Numero:7;al_Mineduc_NivelCurso)
ARRAY INTEGER:C220(ai_Mineduc_Dias;Size of array:C274(at_Mineduc_Nivel))
ARRAY INTEGER:C220(ai_Mineduc_MatriculaCursos;Size of array:C274(at_Mineduc_Nivel))
ARRAY INTEGER:C220(ai_Mineduc_AsistCursos;Size of array:C274(at_Mineduc_Nivel))
ARRAY INTEGER:C220(ai_Mineduc_AltasCursos;Size of array:C274(at_Mineduc_Nivel))
ARRAY INTEGER:C220(ai_Mineduc_BajasCursos;Size of array:C274(at_Mineduc_Nivel))
READ ONLY:C145([Alumnos:2])

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Compilando información de asistencia..."))
For ($I;1;Size of array:C274(at_Mineduc_Nivel))
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(at_Mineduc_Nivel);__ ("Compilando información de asistencia en ")+at_Mineduc_LetraCurso{$i})
	ai_Mineduc_Dias{$i}:=$Days
	SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=at_Mineduc_LetraCurso{$i};*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50="Activo")
	ai_Mineduc_MatriculaCursos{$i}:=$records
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=at_Mineduc_LetraCurso{$i};*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Fecha_de_Ingreso:41>=$begindate;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Fecha_de_Ingreso:41<=$enddate)
	ai_Mineduc_AltasCursos{$i}:=$records
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=at_Mineduc_LetraCurso{$i};*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Fecha_de_retiro:42>=$begindate;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Fecha_de_retiro:42<=$enddate)
	ai_Mineduc_BajasCursos{$i}:=$records
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1>=$begindate;*)
	QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1>=$enddate;*)
	QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos:2]curso:20=at_Mineduc_LetraCurso{$i})
	ai_Mineduc_AsistCursos{$i}:=(ai_Mineduc_Dias{$i}*ai_Mineduc_MatriculaCursos{$i})-$records
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)



