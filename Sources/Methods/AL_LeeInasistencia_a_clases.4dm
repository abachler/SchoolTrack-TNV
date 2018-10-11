//%attributes = {}
  //AL_leeInasistencia_a_clases

  // ----------------------------------------------------
  // Nombre usuario (OS): asepulveda
  // Fecha y hora: 27/03/12, 11:07:03
  // ----------------------------------------------------
  // Método: AL_leeInasistencia_a_clases
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

$size:=0
ARRAY TEXT:C222(at_AbsencesTerm1;$size)
ARRAY TEXT:C222(at_AbsencesTerm2;$size)
ARRAY TEXT:C222(at_AbsencesTerm3;$size)
ARRAY TEXT:C222(at_AbsencesTerm4;$size)
ARRAY TEXT:C222(at_AbsencesTerm5;$size)
ARRAY TEXT:C222(at_AbsencesTotal;$size)
ARRAY INTEGER:C220($al_AbsencesTerm1;$size)
ARRAY INTEGER:C220($al_AbsencesTerm2;$size)
ARRAY INTEGER:C220($al_AbsencesTerm3;$size)
ARRAY INTEGER:C220($al_AbsencesTerm4;$size)
ARRAY INTEGER:C220($al_AbsencesTerm5;$size)
ARRAY INTEGER:C220($al_AbsencesTotal;$size)
ARRAY INTEGER:C220($al_JustAbsencesTerm1;$size)
ARRAY INTEGER:C220($al_JustAbsencesTerm2;$size)
ARRAY INTEGER:C220($al_JustAbsencesTerm3;$size)
ARRAY INTEGER:C220($al_JustAbsencesTerm4;$size)
ARRAY INTEGER:C220($al_JustAbsencesTerm5;$size)
ARRAY INTEGER:C220($al_JustAbsencesTotal;$size)
ARRAY INTEGER:C220(al_AbsencesPercent;$size)
ARRAY REAL:C219(ar_AbsencesPercent;$size)

$l_IdAlumno:=$1
$l_año:=<>gyear
KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$l_IdAlumno;False:C215)
$l_NivelAlumno:=[Alumnos:2]nivel_numero:29
Case of 
	: (Count parameters:C259=2)
		$l_año:=$2
	: (Count parameters:C259=3)
		$l_año:=$2
		$l_NivelAlumno:=$3
End case 

If ($l_año=<>gyear)
	PERIODOS_LoadData ($l_NivelAlumno)  // se leen los periodos Actuales.
Else 
	PERIODOS_LeeDatosHistoricos ($l_NivelAlumno;$l_año)  // se leen los periodos historicos de ser necesario
End if 

$l_modoRegistroInasistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->vl_nivelSeleccionado;->[xxSTR_Niveles:6]AttendanceMode:3)
  //AL_LeeInasistenciaSesiones ($l_IdAlumno;vl_nivelSeleccionado;vl_year)

Case of 
	: ($l_modoRegistroInasistencia=2)
		AL_LeeInasistenciaSesiones ($l_IdAlumno;vl_nivelSeleccionado;vl_year)
	: ($l_modoRegistroInasistencia=4)
		AL_LeeInasistenciasAcumuladas ($l_IdAlumno;vl_nivelSeleccionado;vl_year)
End case 

  //MONO, se visualizan las horas efectivas de las asignaturas en las que el alumno ya no participa, estas no son consideradas para el cálculo del % de asistencia
  // pero al ser mostradas aquí les causa confusión a los usuarios, ticket 137869

C_LONGINT:C283($i_asighora;$fia)
ARRAY LONGINT:C221($al_id_asignaturasAlu;0)
READ ONLY:C145([Alumnos_Calificaciones:208])
QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;$al_id_asignaturasAlu)

For ($i_asighora;1;Size of array:C274(al_IDAsignaturas))
	$fia:=Find in array:C230($al_id_asignaturasAlu;al_IDAsignaturas{$i_asighora})
	If ($fia=-1)
		ai_HorasEfectivas{$i_asighora}:=0
	End if 
End for 
vlSTR_AL_HorasEfectuadas:=AT_GetSumArray (->ai_HorasEfectivas)
