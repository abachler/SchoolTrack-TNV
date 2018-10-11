//%attributes = {}
  // AL_LeeInasistenciaSesiones()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 24/12/12, 18:00:34
  // ---------------------------------------------
_O_C_INTEGER:C282($i_asignaturas;$i_Periodos)
C_LONGINT:C283($l_año;$l_idAlumno;$l_IdAsignatura;$l_inasistencias;$l_inasistenciasJustificadas;$l_inasistenciasPeriodo;$l_InasistenciasPeriodoJust;$l_nivel;$l_sesiones;vlSTR_AL_HorasSemanaA;vlSTR_AL_HorasSemanaB)
C_POINTER:C301($y_ArregloPeriodo)
C_TEXT:C284($t_llaveSintesisAnual;$t_valorCeldaPeriodo;$t_valorCeldaTotal)

C_REAL:C285(vr_horas_semana_a;vr_horas_semana_B)

ARRAY LONGINT:C221(al_IDAsignaturas;0)
ARRAY LONGINT:C221($al_IdAsignaturasCalificaciones;0)
ARRAY LONGINT:C221($al_IdAsignaturasInasistencias;0)

ARRAY TEXT:C222(at_subjectName;0)
ARRAY TEXT:C222(at_OrdenAsignaturas;0)
ARRAY INTEGER:C220(ai_horas_semana_A;0)
ARRAY INTEGER:C220(ai_horas_semana_B;0)
ARRAY INTEGER:C220(ai_HorasSemanales;0)
ARRAY INTEGER:C220(ai_HorasEfectivas;0)
ARRAY TEXT:C222(at_AbsencesPercent;0)
ARRAY TEXT:C222(at_AbsencesTotal;0)
ARRAY REAL:C219(ar_AbsencesPercent;0)
ARRAY TEXT:C222(at_AbsencesTerm1;0)
ARRAY TEXT:C222(at_AbsencesTerm2;0)
ARRAY TEXT:C222(at_AbsencesTerm3;0)
ARRAY TEXT:C222(at_AbsencesTerm4;0)
ARRAY TEXT:C222(at_AbsencesTerm5;0)
ARRAY BOOLEAN:C223(ab_IncideEnAsistencia;0)
ARRAY LONGINT:C221($al_InasistenciasTotales;0)

  // CÓDIGO
$l_idAlumno:=$1
$l_nivel:=$2

$l_año:=<>gYear
If (Count parameters:C259=3)
	$l_año:=$3
End if 

If ($l_año<<>gYear)
	$l_idAlumno:=-Abs:C99($l_idAlumno)
End if 

  // busco todas las inasistencias a clases del alumno
QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=$l_idAlumno;*)
QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4;>=;adSTR_Periodos_Desde{1};*)
QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4;<=;adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Desde)})
If (vi_incidePO=1)  // si el usuario activó la restricción a las asignaturas con incidencia en promedio
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	If ($l_año=<>gYear)
		QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas:18]Incide_en_Asistencia:45=True:C214)
	Else 
		QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Historico:84]Incide_en_Asistencia:28=True:C214)
	End if 
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
End if 
CREATE SET:C116([Asignaturas_Inasistencias:125];"$Inasistencias")
If ($l_año=<>gYear)
	AT_DistinctsFieldValues (->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->$al_IdAsignaturasInasistencias)
Else 
	AT_DistinctsFieldValues (->[Asignaturas_Inasistencias:125]ID_HistoricoAsignatura:12;->$al_IdAsignaturasInasistencias)
End if 

  // busqueda de las asignaturas del alumno
EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;$l_nivel;$l_año)
If (vi_incidePO=1)  // si el usuario activó la restricción a las asignaturas con incidencia en promedio
	If ($l_año=<>gYear)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incide_en_Asistencia:45=True:C214)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	Else 
		SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;Automatic:K51:4;Structure configuration:K51:2)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas_Historico:84]Incide_en_Asistencia:28=True:C214)
		SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;Structure configuration:K51:2;Structure configuration:K51:2)
	End if 
End if 
If ($l_año=<>gYear)
	AT_DistinctsFieldValues (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->$al_IdAsignaturasCalificaciones)
Else 
	AT_DistinctsFieldValues (->[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493;->$al_IdAsignaturasCalificaciones)
End if 
AT_Union (->$al_IdAsignaturasInasistencias;->$al_IdAsignaturasCalificaciones;->al_IDAsignaturas)



  // asignación de valores a los arreglos que se desplegarán en la lista
AT_RedimArrays (Size of array:C274(al_IDAsignaturas);->at_subjectName;->ai_HorasSemanales;->ai_HorasEfectivas;->at_AbsencesTotal;->$al_inasistenciasTotales;->ar_AbsencesPercent;->at_AbsencesPercent;->at_AbsencesTerm1;->at_AbsencesTerm2;->at_AbsencesTerm3;->at_AbsencesTerm4;->at_AbsencesTerm5;->ab_IncideEnAsistencia;->at_OrdenAsignaturas;->ai_horas_semana_A;->ai_horas_semana_B)
For ($i_asignaturas;1;Size of array:C274(al_IDAsignaturas))
	  // columnas de totales por asignatura (nombre asignatura, horas semanales, horas efectivas, inasistencias y porcentaje
	$l_inasistencias:=0
	$l_inasistenciasJustificadas:=0
	$t_valorCeldaTotal:=""
	$l_IdAsignatura:=Abs:C99(al_IDAsignaturas{$i_asignaturas})
	If ($l_año=<>gYear)
		at_subjectName{$i_asignaturas}:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_IdAsignatura;->[Asignaturas:18]denominacion_interna:16)
	Else 
		at_subjectName{$i_asignaturas}:=KRL_GetTextFieldData (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->$l_IdAsignatura;->[Asignaturas_Historico:84]Nombre_interno:3)
	End if 
	If (Find in array:C230($al_IdAsignaturasCalificaciones;al_IDAsignaturas{$i_asignaturas})<0)
		at_subjectName{$i_asignaturas}:=at_subjectName{$i_asignaturas}+" (en "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_IdAsignatura;->[Asignaturas:18]Curso:5)+")"
	End if 
	
	If ($l_año=<>gYear)
		
		at_OrdenAsignaturas{$i_asignaturas}:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_IdAsignatura;->[Asignaturas:18]ordenGeneral:105)
		ai_HorasSemanales{$i_asignaturas}:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->$l_IdAsignatura;->[Asignaturas:18]Horas_Semanales:51)
		  // Modificado por: Alexis Bustamante (14-06-2017)
		  //TICKET 183249
		  //agregar arreglos semana AyB 
		If (VLSTR_HORARIO_NOCICLOS=2)
			vr_horas_semana_a:=0
			vr_horas_semana_b:=0
			READ ONLY:C145([TMT_Horario:166])
			SET QUERY DESTINATION:C396(Into variable:K19:4;vr_horas_semana_a)
			QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=$l_IdAsignatura;*)
			QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12<=Current date:C33(*);*)
			QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=Current date:C33(*);*)
			QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]No_Ciclo:14=1)
			
			SET QUERY DESTINATION:C396(Into variable:K19:4;vr_horas_semana_b)
			QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=$l_IdAsignatura;*)
			QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesDesde:12<=Current date:C33(*);*)
			QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=Current date:C33(*);*)
			QUERY:C277([TMT_Horario:166]; & ;[TMT_Horario:166]No_Ciclo:14=2)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			ai_horas_semana_A{$i_asignaturas}:=vr_horas_semana_a
			ai_horas_semana_b{$i_asignaturas}:=vr_horas_semana_b
		End if 
		
		If ([Alumnos:2]Fecha_de_retiro:42>!00-00-00!)
			$l_sesiones:=0
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_sesiones)
			QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$l_IdAsignatura;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=adSTR_Periodos_Desde{1};*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<[Alumnos:2]Fecha_de_retiro:42)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			ai_HorasEfectivas{$i_asignaturas}:=$l_sesiones
		Else 
			ai_HorasEfectivas{$i_asignaturas}:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->$l_IdAsignatura;->[Asignaturas:18]Horas_de_clases_efectivas:52)
		End if 
		ab_IncideEnAsistencia{$i_asignaturas}:=KRL_GetBooleanFieldData (->[Asignaturas:18]Numero:1;->$l_IdAsignatura;->[Asignaturas:18]Incide_en_Asistencia:45)
	Else 
		at_OrdenAsignaturas{$i_asignaturas}:=KRL_GetTextFieldData (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->$l_IdAsignatura;->[Asignaturas_Historico:84]OrdenGeneral:42)
		ai_HorasSemanales{$i_asignaturas}:=KRL_GetNumericFieldData (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->$l_IdAsignatura;->[Asignaturas_Historico:84]Horas_Semanales:35)
		ai_HorasEfectivas{$i_asignaturas}:=KRL_GetNumericFieldData (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->$l_IdAsignatura;->[Asignaturas_Historico:84]Horas_Efectivas:36)
		QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;=;$l_IdAsignatura;*)
		QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Año:13;=;$l_año)
		ab_IncideEnAsistencia{$i_asignaturas}:=KRL_GetBooleanFieldData (->[Asignaturas_Historico:84]ID_RegistroHistorico:1;->$l_IdAsignatura;->[Asignaturas_Historico:84]Incide_en_Asistencia:28)
	End if 
	USE SET:C118("$Inasistencias")
	If ($l_año=<>gYear)
		QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Asignatura:6=$l_IdAsignatura)
	Else 
		QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_HistoricoAsignatura:12;=;$l_IdAsignatura)
	End if 
	$al_InasistenciasTotales{$i_asignaturas}:=Records in selection:C76([Asignaturas_Inasistencias:125])
	If ($al_InasistenciasTotales{$i_asignaturas}>0)
		$t_valorCeldaTotal:=String:C10($al_InasistenciasTotales{$i_asignaturas})
		QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]Justificacion:3#"")
		$l_inasistenciasJustificadas:=Records in selection:C76([Asignaturas_Inasistencias:125])
		If ($l_InasistenciasJustificadas>0)
			$t_valorCeldaTotal:=$t_valorCeldaTotal+" ("+String:C10($l_InasistenciasJustificadas)+")"
		End if 
	Else 
		$t_valorCeldaTotal:=""
	End if 
	at_AbsencesTotal{$i_asignaturas}:=$t_valorCeldaTotal
	
	
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
			  // Modificado por: Saúl Ponce (19-05-2017) Ticket 181896, en ST v12 formato incorrecto, concateno directamente el "%", ya está redondeado a un decimal
			  //at_AbsencesPercent{$i_asignaturas}:=String(ar_AbsencesPercent{$i_asignaturas};"|pct_1Dec")  //20151016 ASM Ticket 151088  
			at_AbsencesPercent{$i_asignaturas}:=String:C10(ar_AbsencesPercent{$i_asignaturas})+"%"
		Else 
			ar_AbsencesPercent{$i_asignaturas}:=0
			at_AbsencesPercent{$i_asignaturas}:=__ ("N/D")
	End case 
	
	
	
	  // columnas para los períodos
	For ($i_Periodos;1;Size of array:C274(aiSTR_Periodos_Numero))
		USE SET:C118("$Inasistencias")
		QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Asignatura:6=$l_IdAsignatura;*)
		QUERY SELECTION:C341([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4>=adSTR_Periodos_Desde{$i_Periodos};*)
		QUERY SELECTION:C341([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=adSTR_Periodos_Hasta{$i_Periodos})
		$l_inasistenciasPeriodo:=Records in selection:C76([Asignaturas_Inasistencias:125])
		If ($l_inasistenciasPeriodo>0)
			QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]Justificacion:3#"")
			$l_InasistenciasPeriodoJust:=Records in selection:C76([Asignaturas_Inasistencias:125])
			$t_valorCeldaPeriodo:=String:C10($l_inasistenciasPeriodo)
			If ($l_InasistenciasPeriodoJust>0)
				$t_valorCeldaPeriodo:=$t_valorCeldaPeriodo+" ("+String:C10($l_InasistenciasPeriodoJust)+")"
			End if 
		Else 
			$t_valorCeldaPeriodo:=""
		End if 
		$y_ArregloPeriodo:=Get pointer:C304("at_AbsencesTerm"+String:C10($i_Periodos))
		$y_ArregloPeriodo->{$i_asignaturas}:=$t_valorCeldaPeriodo
	End for 
End for 
  // .Asignación de valores a los arreglos que se desplegarán en la lista



  // Totales que se muestran en el pie de la lista
$t_llaveSintesisAnual:="0."+String:C10($l_año)+"."+String:C10(vl_NivelSeleccionado)+"."+String:C10([Alumnos:2]numero:1)
KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveSintesisAnual)

  //se agregan 2 variables de proceso para mostrar totales.
vlSTR_AL_HorasSemanaA:=AT_GetSumArray (->ai_horas_semana_A)
vlSTR_AL_HorasSemanaB:=AT_GetSumArray (->ai_horas_semana_B)

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

