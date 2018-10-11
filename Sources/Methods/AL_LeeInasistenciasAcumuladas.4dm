//%attributes = {}
  // AL_LeeInasistenciasAcumuladas()
  // Por: Alberto Bachler: 10/04/13, 13:53:33
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------




$l_institucion:=0
$l_idAlumno:=$1
$l_nivel:=$2

$l_año:=<>gYear
If (Count parameters:C259=3)
	$l_año:=$3
End if 

ARRAY LONGINT:C221(al_IDAsignaturas;0)  //20130514 ASM arreglo necesario en el area 
ARRAY TEXT:C222(at_subjectName;0)
ARRAY TEXT:C222(at_OrdenAsignaturas;0)
ARRAY INTEGER:C220(ai_HorasSemanales;0)
ARRAY INTEGER:C220(ai_HorasEfectivas;0)
ARRAY TEXT:C222(at_AbsencesTotal;0)
ARRAY REAL:C219(ar_AbsencesPercent;0)
ARRAY TEXT:C222(at_AbsencesPercent;0)
ARRAY TEXT:C222(at_absencesTerm1;0)
ARRAY TEXT:C222(at_absencesTerm2;0)
ARRAY TEXT:C222(at_absencesTerm3;0)
ARRAY TEXT:C222(at_absencesTerm4;0)
ARRAY TEXT:C222(at_absencesTerm5;0)
ARRAY BOOLEAN:C223(ab_IncideEnAsistencia;0)


ARRAY INTEGER:C220($al_InasistenciasP1;0)
ARRAY INTEGER:C220($al_InasistenciasP2;0)
ARRAY INTEGER:C220($al_InasistenciasP3;0)
ARRAY INTEGER:C220($al_InasistenciasP4;0)
ARRAY INTEGER:C220($al_InasistenciasP5;0)
ARRAY INTEGER:C220($al_InasistenciasTotales;0)

$t_llaveAlumno:=KRL_MakeStringAccesKey (->$l_institucion;->$l_año;->$l_nivel;->$l_idAlumno)

READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Asignaturas_Historico:84])
READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]LLave_Alumno:55=$t_llaveAlumno)

If ($l_año=<>gYear)
	SET FIELD RELATION:C919([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5;Automatic:K51:4;Structure configuration:K51:2)
	  //SELECTION TO ARRAY([Alumnos_ComplementoEvaluacion]P01_Inasistencias;$al_InasistenciasP1;[Alumnos_ComplementoEvaluacion]P02_Inasistencias;$al_InasistenciasP2;[Alumnos_ComplementoEvaluacion]P03_Inasistencias;$al_InasistenciasP3;[Alumnos_ComplementoEvaluacion]P04_Inasistencias;$al_InasistenciasP4;[Alumnos_ComplementoEvaluacion]P05_Inasistencias;$al_InasistenciasP5;[Alumnos_ComplementoEvaluacion]TotalInasistencias;$al_inasistenciasTotales;[Asignaturas]Denominación_interna;at_subjectName;[Asignaturas]OrdenGeneral;at_OrdenAsignaturas;[Asignaturas]Horas_Semanales;ai_HorasSemanales;[Asignaturas]Horas_de_clases_efectivas;ai_HorasEfectivas;[Asignaturas]Horas_Anuales;$al_HorasAnuales;[Asignaturas]Incide_en_Asistencia;ab_IncideEnAsistencia)
	SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5;al_IDAsignaturas;[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18;$al_InasistenciasP1;[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23;$al_InasistenciasP2;[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28;$al_InasistenciasP3;[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33;$al_InasistenciasP4;[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38;$al_InasistenciasP5;[Alumnos_ComplementoEvaluacion:209]TotalInasistencias:10;$al_inasistenciasTotales;[Asignaturas:18]denominacion_interna:16;at_subjectName;[Asignaturas:18]ordenGeneral:105;at_OrdenAsignaturas;[Asignaturas:18]Horas_Semanales:51;ai_HorasSemanales;[Asignaturas:18]Horas_de_clases_efectivas:52;ai_HorasEfectivas;[Asignaturas:18]Horas_Anuales:68;$al_HorasAnuales;[Asignaturas:18]Incide_en_Asistencia:45;ab_IncideEnAsistencia)
	SET FIELD RELATION:C919([Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5;Structure configuration:K51:2;Structure configuration:K51:2)
Else 
	  //SET FIELD RELATION([Alumnos_ComplementoEvaluacion]ID_HistoricoAsignatura;Automatic;Structure configuration)
	  //SELECTION TO ARRAY([Alumnos_ComplementoEvaluacion]P01_Inasistencias;$al_InasistenciasP1;[Alumnos_ComplementoEvaluacion]P02_Inasistencias;$al_InasistenciasP2;[Alumnos_ComplementoEvaluacion]P03_Inasistencias;$al_InasistenciasP3;[Alumnos_ComplementoEvaluacion]P04_Inasistencias;$al_InasistenciasP4;[Alumnos_ComplementoEvaluacion]P05_Inasistencias;$al_InasistenciasP5;[Alumnos_ComplementoEvaluacion]TotalInasistencias;$al_inasistenciasTotales;[Asignaturas_Histórico]Nombre_interno;at_subjectName;[Asignaturas_Histórico]OrdenGeneral;at_OrdenAsignaturas;[Asignaturas_Histórico]Horas_Semanales;ai_HorasSemanales;[Asignaturas_Histórico]Horas_Efectivas;ai_HorasEfectivas;[Asignaturas_Histórico]HorasAnuales;$al_HorasAnuales;[Asignaturas_Histórico]Incide_en_Asisencia;ab_IncideEnAsistencia)
	  //SELECTION TO ARRAY([Alumnos_ComplementoEvaluacion]ID_Asignatura;al_IDAsignaturas;[Alumnos_ComplementoEvaluacion]P01_Inasistencias;$al_InasistenciasP1;[Alumnos_ComplementoEvaluacion]P02_Inasistencias;$al_InasistenciasP2;[Alumnos_ComplementoEvaluacion]P03_Inasistencias;$al_InasistenciasP3;[Alumnos_ComplementoEvaluacion]P04_Inasistencias;$al_InasistenciasP4;[Alumnos_ComplementoEvaluacion]P05_Inasistencias;$al_InasistenciasP5;[Alumnos_ComplementoEvaluacion]TotalInasistencias;$al_inasistenciasTotales;[Asignaturas_Historico]Nombre_interno;at_subjectName;[Asignaturas_Historico]OrdenGeneral;at_OrdenAsignaturas;[Asignaturas_Historico]Horas_Semanales;ai_HorasSemanales;[Asignaturas_Historico]Horas_Efectivas;ai_HorasEfectivas;[Asignaturas_Historico]HorasAnuales;$al_HorasAnuales;[Asignaturas_Historico]Incide_en_Asistencia;ab_IncideEnAsistencia)
	  //SET FIELD RELATION([Alumnos_ComplementoEvaluacion]ID_HistoricoAsignatura;Structure configuration;Structure configuration)
	  // 20160921 ASM ticket 167302
	SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]ID_HistoricoAsignatura:48;$al_idHistoricoAsig;[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5;al_IDAsignaturas;[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18;$al_InasistenciasP1;[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23;$al_InasistenciasP2;[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28;$al_InasistenciasP3;[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33;$al_InasistenciasP4;[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38;$al_InasistenciasP5;[Alumnos_ComplementoEvaluacion:209]TotalInasistencias:10;$al_inasistenciasTotales)
	
	For ($i;1;Size of array:C274($al_idHistoricoAsig))
		QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]ID_RegistroHistorico:1=$al_idHistoricoAsig{$i})
		APPEND TO ARRAY:C911(at_subjectName;[Asignaturas_Historico:84]Nombre_interno:3)
		APPEND TO ARRAY:C911(at_OrdenAsignaturas;[Asignaturas_Historico:84]OrdenGeneral:42)
		APPEND TO ARRAY:C911(ai_HorasSemanales;[Asignaturas_Historico:84]Horas_Semanales:35)
		APPEND TO ARRAY:C911(ai_HorasEfectivas;[Asignaturas_Historico:84]Horas_Efectivas:36)
		APPEND TO ARRAY:C911($al_HorasAnuales;[Asignaturas_Historico:84]HorasAnuales:29)
		APPEND TO ARRAY:C911(ab_IncideEnAsistencia;[Asignaturas_Historico:84]Incide_en_Asistencia:28)
	End for 
End if 



AT_RedimArrays (Size of array:C274(at_subjectName);->at_absencesTerm1;->at_absencesTerm2;->at_absencesTerm3;->at_absencesTerm4;->at_absencesTerm5;->ar_AbsencesPercent;->at_AbsencesPercent;->at_AbsencesTotal)
For ($i_asignaturas;1;Size of array:C274(ar_AbsencesPercent))
	at_absencesTerm1{$i_asignaturas}:=String:C10($al_InasistenciasP1{$i_asignaturas};"####")
	at_absencesTerm2{$i_asignaturas}:=String:C10($al_InasistenciasP2{$i_asignaturas};"####")
	at_absencesTerm3{$i_asignaturas}:=String:C10($al_InasistenciasP3{$i_asignaturas};"####")
	at_absencesTerm4{$i_asignaturas}:=String:C10($al_InasistenciasP4{$i_asignaturas};"####")
	at_absencesTerm5{$i_asignaturas}:=String:C10($al_InasistenciasP5{$i_asignaturas};"####")
	at_AbsencesTotal{$i_asignaturas}:=String:C10($al_InasistenciasTotales{$i_asignaturas};"####")
	If (ai_HorasEfectivas{$i_asignaturas}>0)
		Case of 
			: (Not:C34(ab_IncideEnAsistencia{$i_asignaturas}))
				at_AbsencesPercent{$i_asignaturas}:=""
				
			: ($al_InasistenciasTotales{$i_asignaturas}=0)
				at_AbsencesPercent{$i_asignaturas}:="100%"
				
			: (ai_HorasEfectivas{$i_asignaturas}=0)
				ar_AbsencesPercent{$i_asignaturas}:=0
				at_AbsencesPercent{$i_asignaturas}:=__ ("N/D")
				
			: ((ai_HorasEfectivas{$i_asignaturas}>0) & ($al_InasistenciasTotales{$i_asignaturas}>0) & (ai_HorasEfectivas{$i_asignaturas}<$al_InasistenciasTotales{$i_asignaturas}))
				ar_AbsencesPercent{$i_asignaturas}:=-1
				at_AbsencesPercent{$i_asignaturas}:="Error"
				
			: ((ai_HorasEfectivas{$i_asignaturas}>0) & ($al_InasistenciasTotales{$i_asignaturas}>0) & (ai_HorasEfectivas{$i_asignaturas}>=$al_InasistenciasTotales{$i_asignaturas}))
				ar_AbsencesPercent{$i_asignaturas}:=Round:C94((ai_HorasEfectivas{$i_asignaturas}-$al_InasistenciasTotales{$i_asignaturas})/ai_HorasEfectivas{$i_asignaturas}*100;1)
				  //at_AbsencesPercent{$i_asignaturas}:=String(ar_AbsencesPercent{$i_asignaturas};"###,0%")
				at_AbsencesPercent{$i_asignaturas}:=String:C10(ar_AbsencesPercent{$i_asignaturas};"|pct_1Dec")  //20151016 ASM Ticket 151088  
				
			Else 
				ar_AbsencesPercent{$i_asignaturas}:=0
				at_AbsencesPercent{$i_asignaturas}:=__ ("N/D")
		End case 
	End if 
End for 


  // Totales que se muestran en el pie de la lista
$t_llaveSintesisAnual:="0."+String:C10($l_año)+"."+String:C10(vl_NivelSeleccionado)+"."+String:C10([Alumnos:2]numero:1)
KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveSintesisAnual)
vlSTR_AL_HorasSemanales:=AT_GetSumArray (->ai_HorasSemanales)
vlSTR_AL_HorasEfectuadas:=AT_GetSumArray (->ai_HorasEfectivas)
vr_PorcentajeAsistencia:=[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33
vtSTR_AL_Ausencias:=String:C10([Alumnos_SintesisAnual:210]Inasistencias_Horas:31;"####")
vtSTR_AL_AusenciasP1:=String:C10([Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98;"####")
vtSTR_AL_AusenciasP2:=String:C10([Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127;"####")
vtSTR_AL_AusenciasP3:=String:C10([Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156;"####")
vtSTR_AL_AusenciasP4:=String:C10([Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185;"####")
vtSTR_AL_AusenciasP5:=String:C10([Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214;"####")
  // .Totales que se muestran en el pie de la lista

