//%attributes = {}
  // AL_TotalizaHorasDeClase()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 21/12/12, 12:36:58
  // ---------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($i_Periodos;$l_horasEfectivas;$l_horasInasistencia;$l_idAlumno;$l_inasistenciasP1;$l_inasistenciasP2;$l_inasistenciasP3;$l_inasistenciasP4;$l_inasistenciasP5;$l_modoRegistroAsistencia)
C_LONGINT:C283($l_nivel;$l_recNumAlumno;$l_totalHorasEfectivas;$l_totalHorasInasistencia;$l_valor)
C_TEXT:C284($t_llaveSintesisAnual)

ARRAY INTEGER:C220($ai_AusenciasP1;0)
ARRAY INTEGER:C220($ai_AusenciasP2;0)
ARRAY INTEGER:C220($ai_AusenciasP3;0)
ARRAY INTEGER:C220($ai_AusenciasP4;0)
ARRAY INTEGER:C220($ai_AusenciasP5;0)

If (False:C215)
	C_BOOLEAN:C305(AL_TotalizaHorasDeClase )
	C_LONGINT:C283(AL_TotalizaHorasDeClase )
	C_LONGINT:C283(AL_TotalizaHorasDeClase )
End if 
$0:=True:C214





  // CÓDIGO
If (Not:C34(<>vb_BloquearModifSituacionFinal))
	$l_idAlumno:=$1
	$l_recNumAlumno:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$l_idAlumno)
	If (Count parameters:C259=2)
		$l_nivel:=$2
	Else 
		$l_nivel:=[Alumnos:2]nivel_numero:29
	End if 
	
	If ($l_recNumAlumno>=0)
		PERIODOS_LoadData ($l_nivel)
		$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel;->[xxSTR_Niveles:6]AttendanceMode:3)
		
		  //Inicialización de los campos de sintesis de períodos relacionados con inasistencias
		$l_valor:=0
		$t_llaveSintesisAnual:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($l_nivel)+"."+String:C10($l_idAlumno)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]HorasEfectivas:32;->$l_valor;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]Inasistencias_Horas:31;->$l_valor;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P01_HorasEfectivas:99;->$l_valor;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98;->$l_valor;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P02_HorasEfectivas:128;->$l_valor;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127;->$l_valor;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P03_HorasEfectivas:157;->$l_valor;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156;->$l_valor;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P04_HorasEfectivas:186;->$l_valor;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185;->$l_valor;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P05_HorasEfectivas:215;->$l_valor;False:C215)
		AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214;->$l_valor;False:C215)
		AL_EscribeSintesisAnual 
		  //. Inicialización de los campos de sintesis de períodos relacionados con inasistencias
		
		  // Contabilización de las horas de clases efectivas
		  // Se contabilizan sólo las sesiones de clases de las asignaturas que el alumno cursa actualmente,
		  // excluyendo las asignaturas que el alumno ya no curse producto de un cambio de curso o asignaturas.
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incide_en_Asistencia:45=True:C214)
		KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Alumnos_Calificaciones:208]ID_Asignatura:5)
		CREATE SET:C116([Asignaturas_RegistroSesiones:168];"$Sesiones")
		
		
		  //  totalización de las horas de clases efectivamente impartidas en cada período
		$l_totalHorasEfectivas:=0
		For ($i_Periodos;1;Size of array:C274(aiSTR_Periodos_Numero))
			USE SET:C118("$Sesiones")
			If (([Alumnos:2]Fecha_de_retiro:42>!00-00-00!) & (adSTR_Periodos_Desde{$i_Periodos}>[Alumnos:2]Fecha_de_retiro:42))
				$l_horasEfectivas:=0
			Else 
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_horasEfectivas)
				QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=adSTR_Periodos_Desde{$i_Periodos};*)
				If (([Alumnos:2]Fecha_de_retiro:42>!00-00-00!) & ([Alumnos:2]Fecha_de_retiro:42<adSTR_Periodos_Hasta{$i_Periodos}))
					QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<[Alumnos:2]Fecha_de_retiro:42)
				Else 
					QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=adSTR_Periodos_Hasta{$i_Periodos})
				End if 
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
			End if 
			$t_llaveSintesisAnual:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($l_nivel)+"."+String:C10($l_idAlumno)
			Case of 
				: (aiSTR_Periodos_Numero{$i_Periodos}=1)
					AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P01_HorasEfectivas:99;->$l_horasEfectivas;False:C215)
				: (aiSTR_Periodos_Numero{$i_Periodos}=2)
					AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P02_HorasEfectivas:128;->$l_horasEfectivas;False:C215)
				: (aiSTR_Periodos_Numero{$i_Periodos}=3)
					AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P03_HorasEfectivas:157;->$l_horasEfectivas;False:C215)
				: (aiSTR_Periodos_Numero{$i_Periodos}=4)
					AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P04_HorasEfectivas:186;->$l_horasEfectivas;False:C215)
				: (aiSTR_Periodos_Numero{$i_Periodos}=5)
					AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P05_HorasEfectivas:215;->$l_horasEfectivas;False:C215)
			End case 
		End for 
		AL_EscribeSintesisAnual 
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		  //.Contabilización de las horas de clases efectivas ****
		
		
		
		  // Contabilización de horas de inasistencia
		$l_totalHorasInasistencia:=0
		Case of 
			: ($l_modoRegistroAsistencia=2)
				  // busqueda y totalización de los registros de inasistencia de cada período
				  // son incluidas dentro del conteo las inasistencias que el alumno pueda haber registrado en asignaturas que ya no cursa 
				  // (producto de cambio de curso o de asignatura)
				For ($i_Periodos;1;Size of array:C274(aiSTR_Periodos_Numero))
					SET QUERY DESTINATION:C396(Into variable:K19:4;$l_horasInasistencia)
					QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=$l_idAlumno;*)
					QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4>=adSTR_Periodos_Desde{$i_Periodos};*)
					QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=adSTR_Periodos_Hasta{$i_Periodos};*)
					QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas:18]Incide_en_Asistencia:45=True:C214)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					$l_totalHorasInasistencia:=$l_totalHorasInasistencia+$l_horasInasistencia
					$t_llaveSintesisAnual:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($l_nivel)+"."+String:C10($l_idAlumno)
					Case of 
						: (aiSTR_Periodos_Numero{$i_Periodos}=1)
							AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98;->$l_horasInasistencia;False:C215)
						: (aiSTR_Periodos_Numero{$i_Periodos}=2)
							AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127;->$l_horasInasistencia;False:C215)
						: (aiSTR_Periodos_Numero{$i_Periodos}=3)
							AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156;->$l_horasInasistencia;False:C215)
						: (aiSTR_Periodos_Numero{$i_Periodos}=4)
							AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185;->$l_horasInasistencia;False:C215)
						: (aiSTR_Periodos_Numero{$i_Periodos}=5)
							AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214;->$l_horasInasistencia;False:C215)
					End case 
				End for 
				AL_EscribeSintesisAnual 
				  // reconstruimos las inasistencias diarias por ausencias a sesiones de clase
				  //QUERY([Alumnos_Inasistencias];[Alumnos_Inasistencias]Alumno_Numero=$l_IdAlumno;*)
				  //QUERY([Alumnos_Inasistencias]; & [Alumnos_Inasistencias]Fecha>=vdSTR_Periodos_InicioEjercicio;*)
				  //QUERY([Alumnos_Inasistencias]; & [Alumnos_Inasistencias]Fecha<=vdSTR_Periodos_FinEjercicio)
				  //KRL_DeleteSelection (->[Alumnos_Inasistencias];False)
				  //$l_valorCampo:=0
				  //AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual]Inasistencias_Dias;->$l_valorCampo;True)
				ARRAY DATE:C224($ad_FechasSesiones;0)
				  //QUERY([Asignaturas_Inasistencias];[Asignaturas_Inasistencias]ID_Alumno=$l_idAlumno)
				  //20140311 ASM. se estaban considerando registros de inasistencias de años anteriores para crear las inasistencias diarias
				  // Agregue los datos del periodo.
				QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=$l_idAlumno;*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4>=vdSTR_Periodos_InicioEjercicio;*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4<=vdSTR_Periodos_FinEjercicio)
				AT_DistinctsFieldValues (->[Asignaturas_Inasistencias:125]dateSesion:4;->$ad_FechasSesiones)
				For ($i;1;Size of array:C274($ad_FechasSesiones))
					AL_InasistenciaDiariaPorHoras ($l_idAlumno;$ad_FechasSesiones{$i})
				End for 
				
			: ($l_modoRegistroAsistencia=4)
				  // busqueda y totalización del numero de inasistencias acumulado registrado en cada período
				EV2_RegistrosDelAlumno ($l_idAlumno;$l_nivel)
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Asignaturas:18]Incide_en_Asistencia:45=True:C214)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18;$ai_AusenciasP1;[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23;$ai_AusenciasP2;[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28;$ai_AusenciasP3;[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33;$ai_AusenciasP4;[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38;$ai_AusenciasP5)
				$l_inasistenciasP1:=AT_GetSumArray (->$ai_AusenciasP1)
				$l_inasistenciasP2:=AT_GetSumArray (->$ai_AusenciasP2)
				$l_inasistenciasP3:=AT_GetSumArray (->$ai_AusenciasP3)
				$l_inasistenciasP4:=AT_GetSumArray (->$ai_AusenciasP4)
				$l_inasistenciasP5:=AT_GetSumArray (->$ai_AusenciasP5)
				$t_llaveSintesisAnual:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($l_nivel)+"."+String:C10($l_idAlumno)
				AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98;->$l_inasistenciasP1;False:C215)
				AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127;->$l_inasistenciasP2;False:C215)
				AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156;->$l_inasistenciasP3;False:C215)
				AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185;->$l_inasistenciasP4;False:C215)
				AL_EscribeSintesisAnual ($t_llaveSintesisAnual;->[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214;->$l_inasistenciasP5;False:C215)
				AL_EscribeSintesisAnual 
		End case 
		
	Else 
		$0:=False:C215
		
	End if 
Else 
	$0:=True:C214
End if 
