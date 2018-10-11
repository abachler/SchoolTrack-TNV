//%attributes = {}
  //MINEDUC_Subvenciones

C_LONGINT:C283($records)
ARRAY TEXT:C222(at_Mineduc_Nivel;0)
ARRAY TEXT:C222(at_Mineduc_LetraCurso;0)
ARRAY INTEGER:C220(ai_Mineduc_Dias;0)
ARRAY LONGINT:C221(al_Mineduc_NivelCurso;0)
ARRAY INTEGER:C220(ai_Mineduc_MatriculaCursos;0)
ARRAY INTEGER:C220(ai_Mineduc_AsistCursos;0)
ARRAY INTEGER:C220(ai_Mineduc_AltasCursos;0)
ARRAY INTEGER:C220(ai_Mineduc_BajasCursos;0)
ARRAY INTEGER:C220(aCampoNo;0)
ARRAY TEXT:C222(aCampoBoletin;0)
ARRAY TEXT:C222(aValorBoletin;0)


QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5>=1;*)
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5<=8)

SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;aNivel;[xxSTR_Niveles:6]NoNivel:5;aNivelNo)
ARRAY INTEGER:C220(aDiasHabiles;Size of array:C274(aNivel))

QUERY:C277([MINEDUC_Documentos:171];[MINEDUC_Documentos:171]Tipo_documento:1="Boletin Subvenciones";*)
QUERY:C277([MINEDUC_Documentos:171];[MINEDUC_Documentos:171]Año:2=<>gYear)
ORDER BY:C49([MINEDUC_Documentos:171];[MINEDUC_Documentos:171]Año:2;<;[MINEDUC_Documentos:171]Mes:3;<)
$nextMonth:=[MINEDUC_Documentos:171]Mes:3+1
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

ARRAY TEXT:C222(aMeses;0)
COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
aMeses:=Month of:C24($begindate)


ARRAY INTEGER:C220(aCampoNo;369)
ARRAY TEXT:C222(aCampoBoletin;369)
ARRAY TEXT:C222(aValorBoletin;369)
MINEDUC_GeneraBoletin ("Etiquetas")

  //WDW_Open (620;400;0;8;"Asistente para la creación de Pan de Estudios";"wdwClosedlog")
WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_CL_Asistente_Subvenciones";0;8;__ ("Asistente para la creación de Plan de Estudios"))
DIALOG:C40([xxSTR_Constants:1];"STR_CL_Asistente_Subvenciones")
CLOSE WINDOW:C154

ARRAY TEXT:C222(at_Mineduc_Nivel;0)
ARRAY TEXT:C222(at_Mineduc_LetraCurso;0)
ARRAY INTEGER:C220(ai_Mineduc_Dias;0)
ARRAY INTEGER:C220(ai_Mineduc_MatriculaCursos;0)
ARRAY INTEGER:C220(ai_Mineduc_AsistCursos;0)
ARRAY INTEGER:C220(ai_Mineduc_AltasCursos;0)
ARRAY INTEGER:C220(ai_Mineduc_BajasCursos;0)
ARRAY INTEGER:C220(aCampoNo;0)
ARRAY TEXT:C222(aCampoBoletin;0)
ARRAY TEXT:C222(aValorBoletin;0)
