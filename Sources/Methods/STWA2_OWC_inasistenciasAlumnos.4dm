//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:45:20
  // ----------------------------------------------------
  // Método: STWA2_OWC_inasistenciasAlumnos
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)
C_LONGINT:C283($l_idUsuario)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$l_idUsuario:=STWA2_Session_GetUserSTID ($uuid)  //MONO Ticket 179808
$curso:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"curso")
$dd:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dd"))
$md:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"md"))
$ad:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"ad"))
$fecha:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Alumnos_Inasistencias:10])
QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=$fecha)
KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Inasistencias:10]Alumno_Numero:4;"")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20=$curso)
ARRAY LONGINT:C221($arnalusinasistentes;0)
ARRAY LONGINT:C221($aLicencias;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$arnalusinasistentes)
For ($i;1;Size of array:C274($arnalusinasistentes))
	KRL_GotoRecord (->[Alumnos:2];$arnalusinasistentes{$i};False:C215)
	QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=$fecha)
	APPEND TO ARRAY:C911($aLicencias;[Alumnos_Inasistencias:10]Licencia:5)
End for 
  //MONO TICKET 179808
$l_nivel:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->$curso;->[Cursos:3]Nivel_Numero:7)
$l_modoAsist:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel;->[xxSTR_Niveles:6]AttendanceMode:3)

$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$arnalusinasistentes;"inasistentes")
OB_SET ($ob_raiz;->$aLicencias;"licencias")

  // 20151019 ASM Ticket 150766 
ARRAY OBJECT:C1221($aob_periodos;0)
If (Find in array:C230(<>aCursos;$curso)#-1)
	$nivelCurso:=<>aCUNivNo{Find in array:C230(<>aCursos;$curso)}
	PERIODOS_LoadData ($nivelCurso)
Else 
	PERIODOS_LoadData (0;-1)
End if 
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

  //MONO Ticket 179808
$vb_CrearInasistencias:=(PREF_fGet ($l_idUsuario;"SuspencionCreaInasistencia";"0")="1")
$vb_CrearInasistenciasFuturas:=(PREF_fGet ($l_idUsuario;"SuspencionCreaInasistenciaFutura";"0")="1")

$ob_opciones:=OB_Create 
OB_SET ($ob_opciones;->$vb_CrearInasistencias;"crear_inasistencia")
OB_SET ($ob_opciones;->$vb_CrearInasistenciasFuturas;"crear_inasistenciasFuturas")
OB_SET ($ob_opciones;->$l_modoAsist;"modo_de_asistencia")

OB_SET ($ob_raiz;->$ob_opciones;"opciones")

$json:=OB_Object2Json ($ob_raiz)
$0:=$json