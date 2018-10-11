//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:46:40
  // ----------------------------------------------------
  // Método: STWA2_OWC_atrasosAlumnos
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$userID:=STWA2_Session_GetUserSTID ($uuid)
$curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"curso")
$dd:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dd"))
$md:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"md"))
$ad:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ad"))
$fecha:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Alumnos_Atrasos:55])
C_LONGINT:C283($modoRegistroAsistencia;$vl_nonivel)
$vl_nonivel:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->$curso;->[Cursos:3]Nivel_Numero:7)
$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$vl_nonivel;->[xxSTR_Niveles:6]AttendanceMode:3)
QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Fecha:2=$fecha)
KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Atrasos:55]Alumno_numero:1;"")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20=$curso)
ARRAY LONGINT:C221($atrasos;0)
ARRAY LONGINT:C221($ausencias;0)
ARRAY LONGINT:C221($idAlumnos;0)
ARRAY LONGINT:C221($cuantosAtrasos;0)
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$idAlumnos)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$atrasos)
C_LONGINT:C283($atrasosTotales)
SET QUERY DESTINATION:C396(Into variable:K19:4;$atrasosTotales)
For ($i;1;Size of array:C274($atrasos))
	QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$idAlumnos{$i};*)
	QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$fecha)
	APPEND TO ARRAY:C911($cuantosAtrasos;$atrasosTotales)
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
  //$vb_permiso:=((USR_checkRights ("D";->[Asignaturas_Inasistencias];$userID)) & (<>viSTR_NoModificarNotas=0) & (<>viSTR_CambiaInasistenciaxAtraso=1))
$vb_permiso:=((USR_checkRights ("D";->[Asignaturas_Inasistencias:125];$userID)) & (<>viSTR_CambiaInasistenciaxAtraso=1))
If (Not:C34($vb_permiso))  //MONO Si se permite el reemplazo de inasistencia por atraso no deben ir bloqueados los inasistentes
	READ ONLY:C145([Alumnos_Inasistencias:10])
	QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=$fecha)
	KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Inasistencias:10]Alumno_Numero:4;"")
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20=$curso)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$ausencias)
End if 

QUERY:C277([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]activo:5=True:C214)
ORDER BY:C49([xxSTR_JustificacionAtrasos:227];[xxSTR_JustificacionAtrasos:227]ID:1;>)
SELECTION TO ARRAY:C260([xxSTR_JustificacionAtrasos:227];$al_RecNumJustificacion;[xxSTR_JustificacionAtrasos:227]Motivo:2;$at_motivoJustificacion)


$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$atrasos;"atrasados")
OB_SET ($ob_raiz;->$cuantosAtrasos;"cuantos")
OB_SET ($ob_raiz;->$ausencias;"ausente")
OB_SET ($ob_raiz;->$modoRegistroAsistencia;"modoAsistencia")
  //cargo los tipos de justificaciones de atrasos
OB_SET ($ob_raiz;->$al_RecNumJustificacion;"RecNumJustificacion")
OB_SET ($ob_raiz;->$at_motivoJustificacion;"MotivoJustificacion")

  // 20151019 ASM Ticket 150766 
If ($curso#"")
	$nivelCurso:=<>aCUNivNo{Find in array:C230(<>aCursos;$curso)}
	PERIODOS_LoadData ($nivelCurso)
Else 
	PERIODOS_LoadData (0;-1)
End if 
ARRAY OBJECT:C1221($aob_periodos;0)
C_OBJECT:C1216($ob_periodosCurso;$ob_periodos)
$ob_periodosCurso:=OB_Create 
For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
	$ob_periodos:=OB_Create 
	OB_SET_Text ($ob_periodos;STWA2_MakeDate4JS (adSTR_Periodos_Desde{$i});"inicio")
	OB_SET_Text ($ob_periodos;STWA2_MakeDate4JS (adSTR_Periodos_Hasta{$i});"fin")
	APPEND TO ARRAY:C911($aob_periodos;$ob_periodos)
	CLEAR VARIABLE:C89($ob_periodos)
End for 
OB_SET ($ob_raiz;->$aob_periodos;"periodosCurso")
$json:=OB_Object2Json ($ob_raiz)
$0:=$json



