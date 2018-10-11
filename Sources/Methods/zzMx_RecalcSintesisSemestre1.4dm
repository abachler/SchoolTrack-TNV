//%attributes = {}
  //zzMx_RecalcSintesisSemestre1

If (<>vtXS_CountryCode="mx")
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=2009;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]ID_Alumno:4;<;0)
	
	
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=127;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; | [Alumnos_SintesisAnual:210]ID_Alumno:4;=;-127)
	
	
	ARRAY LONGINT:C221($aRecNumsSintesis;0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];$aRecNumsSintesis;"")
	For ($iRecords;1;Size of array:C274($aRecNumsSintesis))
		READ WRITE:C146([Alumnos_SintesisAnual:210])
		
		$recNumSintesis:=$aRecNumsSintesis{$iRecords}
		KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$recNumSintesis;True:C214)
		
		
		$id_alumno:=Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
		$nivel:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_Alumno;->[Alumnos:2]nivel_numero:29)
		
		If ($nivel#[Alumnos_SintesisAnual:210]NumeroNivel:6)
			
			
			
			
			PERIODOS_LoadData ([Alumnos_SintesisAnual:210]NumeroNivel:6)
			
			  //TOTALIZACION DE INASISTENCIAS
			[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=100
			[Alumnos_SintesisAnual:210]InasistenciasInjustif_Dias:50:=0
			[Alumnos_SintesisAnual:210]InasistenciasJustif_Dias:49:=0
			[Alumnos_SintesisAnual:210]Inasistencias_Dias:30:=0
			
			[Alumnos_SintesisAnual:210]P01_InasistenciasInjustif_Dias:117:=0
			[Alumnos_SintesisAnual:210]P01_InasistenciasJustif_Dias:116:=0
			[Alumnos_SintesisAnual:210]P01_Inasistencias_Dias:97:=0
			[Alumnos_SintesisAnual:210]P02_InasistenciasInjustif_Dias:146:=0
			[Alumnos_SintesisAnual:210]P02_InasistenciasJustif_Dias:145:=0
			[Alumnos_SintesisAnual:210]P02_Inasistencias_Dias:126:=0
			[Alumnos_SintesisAnual:210]P03_InasistenciasInjustif_Dias:175:=0
			[Alumnos_SintesisAnual:210]P03_InasistenciasJustif_Dias:174:=0
			[Alumnos_SintesisAnual:210]P03_Inasistencias_Dias:155:=0
			[Alumnos_SintesisAnual:210]P04_InasistenciasInjustif_Dias:204:=0
			[Alumnos_SintesisAnual:210]P04_InasistenciasJustif_Dias:203:=0
			[Alumnos_SintesisAnual:210]P04_Inasistencias_Dias:184:=0
			[Alumnos_SintesisAnual:210]P05_InasistenciasInjustif_Dias:233:=0
			[Alumnos_SintesisAnual:210]P05_InasistenciasJustif_Dias:232:=0
			[Alumnos_SintesisAnual:210]P05_Inasistencias_Dias:213:=0  //
			
			[Alumnos_SintesisAnual:210]HorasEfectivas:32:=0
			[Alumnos_SintesisAnual:210]Inasistencias_Horas:31:=0
			[Alumnos_SintesisAnual:210]P01_HorasEfectivas:99:=0
			[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98:=0
			[Alumnos_SintesisAnual:210]P02_HorasEfectivas:128:=0
			[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127:=0
			[Alumnos_SintesisAnual:210]P03_HorasEfectivas:157:=0
			[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156:=0
			[Alumnos_SintesisAnual:210]P04_HorasEfectivas:186:=0
			[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185:=0
			[Alumnos_SintesisAnual:210]P05_HorasEfectivas:215:=0
			[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214:=0
			
			[Alumnos_SintesisAnual:210]Atrasos_Jornada:40:=0
			[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41:=0
			[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51:=0
			[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45:=0
			[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46:=0
			[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107:=0
			[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108:=0
			[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112:=0
			[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoSesiones:113:=0
			[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136:=0
			[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137:=0
			[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141:=0
			[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoSesiones:142:=0
			[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165:=0
			[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166:=0
			[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170:=0
			[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoSesiones:171:=0
			[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194:=0
			[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195:=0
			[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoJornada:199:=0
			[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoSesiones:200:=0
			[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223:=0
			[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224:=0
			[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoJornada:228:=0
			[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoSesiones:229:=0
			
			$vr_mediaReal:=-10
			$vr_mediaNota:=-10
			$vr_mediaPuntos:=-10
			$vs_mediaSimbolos:=""
			$vs_mediaLiteralInterno:=""
			$vs_mediaLiteralOficial:=""
			
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92:=0
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Nota:93:=0
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Puntos:94:=0
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Simbolo:95:=""
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96:=""
			[Alumnos_SintesisAnual:210]P01_PromedioOficial_Real:237:=0
			[Alumnos_SintesisAnual:210]P01_PromedioOficial_Nota:238:=0
			[Alumnos_SintesisAnual:210]P01_PromedioOficial_Puntos:239:=0
			[Alumnos_SintesisAnual:210]P01_PromedioOficial_Simbolo:240:=""
			[Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241:=""
			
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Real:121:=0
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Nota:122:=0
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Puntos:123:=0
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Simbolo:124:=""
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125:=""
			[Alumnos_SintesisAnual:210]P02_PromedioOficial_Real:242:=0
			[Alumnos_SintesisAnual:210]P02_PromedioOficial_Nota:243:=0
			[Alumnos_SintesisAnual:210]P02_PromedioOficial_Puntos:244:=0
			[Alumnos_SintesisAnual:210]P02_PromedioOficial_Simbolo:245:=""
			[Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246:=""
			
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Real:150:=0
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Nota:151:=0
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Puntos:152:=0
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Simbolo:153:=""
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154:=""
			[Alumnos_SintesisAnual:210]P03_PromedioOficial_Real:247:=0
			[Alumnos_SintesisAnual:210]P03_PromedioOficial_Nota:248:=0
			[Alumnos_SintesisAnual:210]P03_PromedioOficial_Puntos:249:=0
			[Alumnos_SintesisAnual:210]P03_PromedioOficial_Simbolo:250:=""
			[Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251:=""
			
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Real:179:=0
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Nota:180:=0
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Puntos:181:=0
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Simbolo:182:=""
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183:=""
			[Alumnos_SintesisAnual:210]P04_PromedioOficial_Real:252:=0
			[Alumnos_SintesisAnual:210]P04_PromedioOficial_Nota:253:=0
			[Alumnos_SintesisAnual:210]P04_PromedioOficial_Puntos:254:=0
			[Alumnos_SintesisAnual:210]P04_PromedioOficial_Simbolo:255:=""
			[Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256:=""
			
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Real:208:=0
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Nota:209:=0
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Puntos:210:=0
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Simbolo:211:=""
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212:=""
			[Alumnos_SintesisAnual:210]P05_PromedioOficial_Real:257:=0
			[Alumnos_SintesisAnual:210]P05_PromedioOficial_Nota:258:=0
			[Alumnos_SintesisAnual:210]P05_PromedioOficial_Puntos:259:=0
			[Alumnos_SintesisAnual:210]P05_PromedioOficial_Simbolo:260:=""
			[Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261:=""
			
			  //promedio anual
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Real:15:=0
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Nota:16:=0
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Puntos:17:=0
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Simbolo:18:=""
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19:=""
			[Alumnos_SintesisAnual:210]PromedioAnualInterno_Real:10:=0
			[Alumnos_SintesisAnual:210]PromedioAnualInterno_Nota:11:=0
			[Alumnos_SintesisAnual:210]PromedioAnualInterno_Puntos:12:=0
			[Alumnos_SintesisAnual:210]PromedioAnualInterno_Simbolo:13:=""
			[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14:=""
			
			  //promedio final INTERNO
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20:=0
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Nota:21:=0
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Puntos:22:=0
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Simbolo:23:=""
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24:=""
			[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272:=0
			[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Nota:273:=0
			[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Puntos:274:=0
			[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Literal:275:=""
			
			  //promedio final OFICIAL
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25:=0
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26:=0
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Puntos:27:=0
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Simbolo:28:=""
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29:=""
			[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268:=0
			[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Nota:269:=0
			[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Puntos:270:=0
			[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Literal:271:=""
			
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			
			
			$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[xxSTR_Niveles:6]AttendanceMode:3)
			Case of 
				: ($modoRegistroAsistencia=1)
					READ ONLY:C145([Alumnos_Inasistencias:10])
					QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$id_alumno;*)
					QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1>=vdSTR_Periodos_InicioEjercicio;*)
					QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1<=vdSTR_Periodos_FinEjercicio)
					ARRAY LONGINT:C221($aRecNums;0)
					LONGINT ARRAY FROM SELECTION:C647([Alumnos_Inasistencias:10];$aRecNums;"")
					
					KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$recNumSintesis;True:C214)
					For ($i;1;Size of array:C274($aRecNums))
						GOTO RECORD:C242([Alumnos_Inasistencias:10];$aRecNums{$i})
						
						$devolverPeriodoMasCercano:=False:C215
						$periodo:=PERIODOS_PeriodosActuales ([Alumnos_Inasistencias:10]Fecha:1;$devolverPeriodoMasCercano)
						  //se incrementan los valores de los totales en los registros de sintesis
						If ($periodo>0)
							Case of 
								: ($periodo=1)
									$y_Injustificadas:=->[Alumnos_SintesisAnual:210]P01_InasistenciasInjustif_Dias:117
									$y_Justificadas:=->[Alumnos_SintesisAnual:210]P01_InasistenciasJustif_Dias:116
								: ($periodo=2)
									$y_Injustificadas:=->[Alumnos_SintesisAnual:210]P02_InasistenciasInjustif_Dias:146
									$y_Justificadas:=->[Alumnos_SintesisAnual:210]P02_InasistenciasJustif_Dias:145
								: ($periodo=3)
									$y_Injustificadas:=->[Alumnos_SintesisAnual:210]P03_InasistenciasInjustif_Dias:175
									$y_Justificadas:=->[Alumnos_SintesisAnual:210]P03_InasistenciasJustif_Dias:174
								: ($periodo=4)
									$y_Injustificadas:=->[Alumnos_SintesisAnual:210]P04_InasistenciasInjustif_Dias:204
									$y_Justificadas:=->[Alumnos_SintesisAnual:210]P04_InasistenciasJustif_Dias:203
								: ($periodo=5)
									$y_Injustificadas:=->[Alumnos_SintesisAnual:210]P05_InasistenciasInjustif_Dias:233
									$y_Justificadas:=->[Alumnos_SintesisAnual:210]P05_InasistenciasJustif_Dias:232
							End case 
							If ([Alumnos_Inasistencias:10]Justificación:2="")
								$y_Injustificadas->:=$y_Injustificadas->+1
							Else 
								$y_Justificadas->:=$y_Justificadas->+1
							End if 
						End if 
					End for 
					SAVE RECORD:C53([Alumnos_SintesisAnual:210])
					
					
				: (($modoRegistroAsistencia=2) | ($modoRegistroAsistencia=4))
					READ WRITE:C146([Alumnos_Inasistencias:10])
					QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$id_alumno;*)
					QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1>=vdSTR_Periodos_InicioEjercicio;*)
					QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1<=vdSTR_Periodos_FinEjercicio)
					KRL_DeleteSelection (->[Alumnos_Inasistencias:10])
					READ ONLY:C145([Alumnos_Inasistencias:10])
					
					PERIODOS_LoadData ([Alumnos_SintesisAnual:210]NumeroNivel:6)
					EV2_RegistrosDelAlumno ($id_Alumno;[Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Año:2)
					SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;$aIdAsignaturas)
					AT_ABSNumericArray (->$aIdAsignaturas)
					QRY_QueryWithArray (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->$aIdAsignaturas)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas:18]Incide_en_Asistencia:45=True:C214)
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					CREATE SET:C116([Asignaturas_RegistroSesiones:168];"Sesiones")
					
					
					  //  totalización de las horas de clases efectivamente impartidas en cada período
					KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$recNumSintesis;True:C214)
					$totalHorasEfectivas:=0
					For ($i_Periodos;1;Size of array:C274(aiSTR_Periodos_Numero))
						USE SET:C118("Sesiones")
						SET QUERY DESTINATION:C396(Into variable:K19:4;$horasEfectivas)
						QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=adSTR_Periodos_Desde{$i_Periodos};*)
						QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=adSTR_Periodos_Hasta{$i_Periodos})
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						$totalHorasEfectivas:=$totalHorasEfectivas+$horasEfectivas
						Case of 
							: (aiSTR_Periodos_Numero{$i_Periodos}=1)
								[Alumnos_SintesisAnual:210]P01_HorasEfectivas:99:=$horasEfectivas
							: (aiSTR_Periodos_Numero{$i_Periodos}=2)
								[Alumnos_SintesisAnual:210]P02_HorasEfectivas:128:=$horasEfectivas
							: (aiSTR_Periodos_Numero{$i_Periodos}=3)
								[Alumnos_SintesisAnual:210]P03_HorasEfectivas:157:=$horasEfectivas
							: (aiSTR_Periodos_Numero{$i_Periodos}=4)
								[Alumnos_SintesisAnual:210]P04_HorasEfectivas:186:=$horasEfectivas
							: (aiSTR_Periodos_Numero{$i_Periodos}=5)
								[Alumnos_SintesisAnual:210]P05_HorasEfectivas:215:=$horasEfectivas
						End case 
					End for 
					
					$totalHorasInasistencia:=0
					Case of 
						: ($modoRegistroAsistencia=2)
							For ($i_Periodos;1;Size of array:C274(aiSTR_Periodos_Numero))
								USE SET:C118("Sesiones")
								KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Sesión:1;->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;"")
								SET QUERY DESTINATION:C396(Into variable:K19:4;$horasInasistencia)
								QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=$id_Alumno;*)
								QUERY SELECTION:C341([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4>=adSTR_Periodos_Desde{$i_Periodos};*)
								QUERY SELECTION:C341([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=adSTR_Periodos_Hasta{$i_Periodos})
								SET QUERY DESTINATION:C396(Into current selection:K19:1)
								$totalHorasInasistencia:=$totalHorasInasistencia+$horasInasistencia
								Case of 
									: (aiSTR_Periodos_Numero{$i_Periodos}=1)
										[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98:=$horasInasistencia
									: (aiSTR_Periodos_Numero{$i_Periodos}=2)
										[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127:=$horasInasistencia
									: (aiSTR_Periodos_Numero{$i_Periodos}=3)
										[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156:=$horasInasistencia
									: (aiSTR_Periodos_Numero{$i_Periodos}=4)
										[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185:=$horasInasistencia
									: (aiSTR_Periodos_Numero{$i_Periodos}=5)
										[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214:=$horasInasistencia
								End case 
							End for 
							SAVE RECORD:C53([Alumnos_SintesisAnual:210])
							
						: ($modoRegistroAsistencia=4)
							EV2_RegistrosDelAlumno ($id_Alumno;[Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Año:2)
							SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;$aIdAsignaturas)
							AT_ABSNumericArray (->$aIdAsignaturas)
							QRY_QueryWithArray (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->$aIdAsignaturas)
							SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
							QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas:18]Incide_en_Asistencia:45=True:C214)
							SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
							CREATE SET:C116([Asignaturas_RegistroSesiones:168];"Sesiones")
							SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18;$aAusenciasP1;[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23;$aAusenciasP2;[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28;$aAusenciasP3;[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33;$aAusenciasP4;[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38;$aAusenciasP5)
							$inasistenciasP1:=AT_GetSumArray (->$aAusenciasP1)
							$inasistenciasP2:=AT_GetSumArray (->$aAusenciasP2)
							$inasistenciasP3:=AT_GetSumArray (->$aAusenciasP3)
							$inasistenciasP4:=AT_GetSumArray (->$aAusenciasP4)
							$inasistenciasP5:=AT_GetSumArray (->$aAusenciasP5)
							
							KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$recNumSintesis;True:C214)
							[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98:=$inasistenciasP1
							[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127:=$inasistenciasP2
							[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156:=$inasistenciasP3
							[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185:=$inasistenciasP4
							[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214:=$inasistenciasP5
					End case 
					SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			End case 
			
			
			
			  //TOTALIZACION DE ATRASOS
			KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$recNumSintesis;True:C214)
			PERIODOS_LoadData ([Alumnos_SintesisAnual:210]NumeroNivel:6)
			READ ONLY:C145([Alumnos_Atrasos:55])
			QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$id_Alumno;*)
			QUERY:C277([Alumnos_Atrasos:55]; & [Alumnos_Atrasos:55]Fecha:2>=vdSTR_Periodos_InicioEjercicio;*)
			QUERY:C277([Alumnos_Atrasos:55]; & [Alumnos_Atrasos:55]Fecha:2<=vdSTR_Periodos_FinEjercicio)
			ARRAY LONGINT:C221($aRecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([Alumnos_Atrasos:55];$aRecNums;"")
			For ($i;1;Size of array:C274($aRecNums))
				GOTO RECORD:C242([Alumnos_Atrasos:55];$aRecNums{$i})
				
				  //lectura del número de periodo y subperiodo correspondiente a la fecha del aatraso
				$devolverPeriodoMasCercano:=False:C215
				$periodo:=PERIODOS_PeriodosActuales ([Alumnos_Atrasos:55]Fecha:2;$devolverPeriodoMasCercano)
				
				  //se incrementan los valores de los totales en los registros de sintesis
				If ($periodo>0)
					Case of 
						: ($periodo=1)
							$y_TotalJornada:=->[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107
							$y_TotalSesiones:=->[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108
							$y_TotalFaltasJornada:=->[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112
							$y_TotalFaltasSesiones:=->[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoSesiones:113
						: ($periodo=2)
							$y_TotalJornada:=->[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136
							$y_TotalSesiones:=->[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137
							$y_TotalFaltasJornada:=->[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141
							$y_TotalFaltasSesiones:=->[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoSesiones:142
						: ($periodo=3)
							$y_TotalJornada:=->[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165
							$y_TotalSesiones:=->[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166
							$y_TotalFaltasJornada:=->[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170
							$y_TotalFaltasSesiones:=->[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoSesiones:171
						: ($periodo=4)
							$y_TotalJornada:=->[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194
							$y_TotalSesiones:=->[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195
							$y_TotalFaltasJornada:=->[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoJornada:199
							$y_TotalFaltasSesiones:=->[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoSesiones:200
						: ($periodo=5)
							$y_TotalJornada:=->[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223
							$y_TotalSesiones:=->[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224
							$y_TotalFaltasJornada:=->[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoJornada:228
							$y_TotalFaltasSesiones:=->[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoSesiones:229
					End case 
					
					
					If (OK=1)
						If ([Alumnos_Atrasos:55]EsAtrasoInterSesiones:4)
							$y_TotalSesiones->:=$y_TotalSesiones->+1
							$y_TotalFaltasSesiones->:=$y_TotalFaltasSesiones->+AL_RetornaValorFaltaPorRetardo ([Alumnos_Atrasos:55]MinutosAtraso:5)
						Else 
							$y_TotalJornada->:=$y_TotalJornada->+1
							$y_TotalFaltasJornada->:=$y_TotalFaltasJornada->+AL_RetornaValorFaltaPorRetardo ([Alumnos_Atrasos:55]MinutosAtraso:5)
						End if 
						[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51:=[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51+[Alumnos_Atrasos:55]MinutosAtraso:5
					End if 
				End if 
			End for 
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			
			
			
			
			
			
			  //PROMEDIOS FINALES DEL SEMESTRE CERRADO
			READ ONLY:C145([Asignaturas:18])
			KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$recNumSintesis;True:C214)
			
			EV2_InitArrays 
			ARRAY LONGINT:C221($idAsig;0)
			
			$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
			$estiloEvaluacionInterno:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[xxSTR_Niveles:6]EvStyle_interno:33)
			$modoPromedioInterno:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[xxSTR_Niveles:6]ModoPromedioGeneralInterno:47)
			$modoPromedioOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[xxSTR_Niveles:6]ModoPromedioGeneralOficial:48)
			
			
			$r:=EVS_ReadStyleData ($estiloEvaluacionInterno)  //lectura del estilo interno
			$modoImpresionInterno:=iPrintMode
			$minimoInterno:=vrNTA_MinimoEscalaReferencia
			If ($r=1)
				$estiloEvaluacionOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[xxSTR_Niveles:6]EvStyle_oficial:23)
				$r:=EVS_ReadStyleData ($estiloEvaluacionOficial)  //lectura del estilo oficial
				$modoImpresionOficial:=iPrintActa
				$minimoOficial:=vrNTA_MinimoEscalaReferencia
			End if 
			If ($r=0)
				  //no hay estilo oficial o interno asignado al nivel. No es posible calcular los promedios
			Else 
				READ ONLY:C145([Alumnos_Calificaciones:208])
				
				EV2_RegistrosDelAlumno (Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4);[Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Año:2)
				If ($minimoInterno=0)
					$modoCalculo:=3
				Else 
					$modoCalculo:=1
				End if 
				
				$evaluaciones:=Records in selection:C76([Alumnos_Calificaciones:208])
				If ($evaluaciones>0)
					CREATE SET:C116([Alumnos_Calificaciones:208];"Calificaciones")
					
					  //CALCULO DE PROMEDIOS INTERNOS
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]IncideEnPromedioInterno:64=True:C214)
					
					If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
						ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]ordenGeneral:105;>)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Real:112;$aReal1;[Alumnos_Calificaciones:208]P02_Final_Real:187;$aReal2;[Alumnos_Calificaciones:208]P03_Final_Real:262;$aReal3;[Alumnos_Calificaciones:208]P04_Final_Real:337;$aReal4;[Alumnos_Calificaciones:208]P05_Final_Real:412;$aReal5)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Nota:113;$aNota1;[Alumnos_Calificaciones:208]P02_Final_Nota:188;$aNota2;[Alumnos_Calificaciones:208]P03_Final_Nota:263;$aNota3;[Alumnos_Calificaciones:208]P04_Final_Nota:338;$aNota4;[Alumnos_Calificaciones:208]P05_Final_Nota:413;$aNota5)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Puntos:114;$aPuntos1;[Alumnos_Calificaciones:208]P02_Final_Puntos:189;$aPuntos2;[Alumnos_Calificaciones:208]P03_Final_Puntos:264;$aPuntos3;[Alumnos_Calificaciones:208]P04_Final_Puntos:339;$aPuntos4;[Alumnos_Calificaciones:208]P05_Final_Puntos:414;$aPuntos5)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Anual_Real:11;$aRealAnual;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;$aRealFinal;[Alumnos_Calificaciones:208]Anual_Nota:12;$aRealAnualNotas;[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;$aRealFinalNotas;[Alumnos_Calificaciones:208]Anual_Puntos:13;$aRealAnualPuntos;[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;$aRealFinalPuntos)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$aRealOficial;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;$aRealNotasOficial;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;$aRealPuntosOficial;[Asignaturas:18]Incide_en_promedio:27;$aIncidePromedioOficial;[Asignaturas:18]IncideEnPromedioInterno:64;$aIncidePromedioInterno;[Asignaturas:18]Horas_Semanales:51;$aHoras;[Asignaturas:18]PonderacionEnPromedioINT:110;$aFactorInterno;[Asignaturas:18]PonderacionEnPromedioOF:109;$aFactorOficial)
						SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
						
						KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$recNumSintesis;True:C214)
						
						  //periodo 1
						$aReal1{0}:=-10
						$hayNotas:=(AT_SearchArray (->$aReal1;">")>0)
						If ($hayNotas)
							Case of 
								: ($modoPromedioInterno=Ponderado por factor)
									$vr_mediaReal:=AL_PromedioPonderadoPorFactor (->$aReal1;->$aFactorInterno)
									$vr_mediaNota:=AL_PromedioPonderadoPorFactor (->$aNota1;->$aFactorInterno)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$aPuntos1;->$aFactorInterno)
									
								: ($modoPromedioInterno=Ponderado por Int Horaria)
									$vr_mediaReal:=AL_PromedioPonderadoPorHoras (->$aReal1;->$aHoras)
									$vr_mediaNota:=AL_PromedioPonderadoPorHoras (->$aNota1;->$aHoras)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$aPuntos1;->$aHoras)
									
								: ($modoPromedioInterno=Sin ponderaciones)
									$vr_mediaReal:=Round:C94(AT_Mean (->$aReal1;$modoCalculo);11)
									$vr_mediaNota:=Round:C94(AT_Mean (->$aNota1;$modoCalculo);11)
									$vr_mediaPuntos:=Round:C94(AT_Mean (->$aPuntos1;$modoCalculo);11)
							End case 
							
							$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
							$r:=$vr_mediaReal
							If (iPrintMode=Simbolos)
								$r:=$vr_mediaReal
								$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
								Case of 
									: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
									Else 
										$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionInterno)
								End case 
							Else 
								Case of 
									: (iPrintMode=Notas)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: (iPrintMode=Puntos)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
								End case 
							End if 
							$vs_mediaLiteralInterno:=NTA_PercentValue2StringValue ($vr_mediaReal;$modoImpresionInterno;$estiloEvaluacionInterno)
							[Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]P01_PromedioInterno_Nota:93:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]P01_PromedioInterno_Puntos:94:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]P01_PromedioInterno_Simbolo:95:=$vs_mediaSimbolos
							[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96:=$vs_mediaLiteralInterno
						End if 
						
						  //periodo 2
						$aReal2{0}:=-10
						$hayNotas:=(AT_SearchArray (->$aReal2;">")>0)
						If ($hayNotas)
							Case of 
								: ($modoPromedioInterno=Ponderado por factor)
									$vr_mediaReal:=AL_PromedioPonderadoPorFactor (->$aReal2;->$aFactorInterno)
									$vr_mediaNota:=AL_PromedioPonderadoPorFactor (->$aNota2;->$aFactorInterno)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$aPuntos2;->$aFactorInterno)
									
								: ($modoPromedioInterno=Ponderado por Int Horaria)
									$vr_mediaReal:=AL_PromedioPonderadoPorHoras (->$aReal2;->$aHoras)
									$vr_mediaNota:=AL_PromedioPonderadoPorHoras (->$aNota2;->$aHoras)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$aPuntos2;->$aHoras)
									
								: ($modoPromedioInterno=Sin ponderaciones)
									$vr_mediaReal:=Round:C94(AT_Mean (->$aReal2;$modoCalculo);11)
									$vr_mediaNota:=Round:C94(AT_Mean (->$aNota2;$modoCalculo);11)
									$vr_mediaPuntos:=Round:C94(AT_Mean (->$aPuntos2;$modoCalculo);11)
							End case 
							
							$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
							$r:=$vr_mediaReal
							If (iPrintMode=Simbolos)
								$r:=$vr_mediaReal
								$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
								Case of 
									: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
									Else 
										$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionInterno)
								End case 
							Else 
								Case of 
									: (iPrintMode=Notas)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: (iPrintMode=Puntos)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
								End case 
							End if 
							$vs_mediaLiteralInterno:=NTA_PercentValue2StringValue ($vr_mediaReal;$modoImpresionInterno;$estiloEvaluacionInterno)
							[Alumnos_SintesisAnual:210]P02_PromedioInterno_Real:121:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]P02_PromedioInterno_Nota:122:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]P02_PromedioInterno_Puntos:123:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]P02_PromedioInterno_Simbolo:124:=$vs_mediaSimbolos
							[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125:=$vs_mediaLiteralInterno
						End if 
						
						  //periodo 3 
						$aReal3{0}:=-10
						$hayNotas:=(AT_SearchArray (->$aReal3;">")>0)
						If ($hayNotas)
							Case of 
								: ($modoPromedioInterno=Ponderado por factor)
									$vr_mediaReal:=AL_PromedioPonderadoPorFactor (->$aReal3;->$aFactorInterno)
									$vr_mediaNota:=AL_PromedioPonderadoPorFactor (->$aNota3;->$aFactorInterno)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$aPuntos3;->$aFactorInterno)
									
								: ($modoPromedioInterno=Ponderado por Int Horaria)
									$vr_mediaReal:=AL_PromedioPonderadoPorHoras (->$aReal3;->$aHoras)
									$vr_mediaNota:=AL_PromedioPonderadoPorHoras (->$aNota3;->$aHoras)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$aPuntos3;->$aHoras)
									
								: ($modoPromedioInterno=Sin ponderaciones)
									$vr_mediaReal:=Round:C94(AT_Mean (->$aReal3;$modoCalculo);11)
									$vr_mediaNota:=Round:C94(AT_Mean (->$aNota3;$modoCalculo);11)
									$vr_mediaPuntos:=Round:C94(AT_Mean (->$aPuntos3;$modoCalculo);11)
							End case 
							
							$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
							$r:=$vr_mediaReal
							If (iPrintMode=Simbolos)
								$r:=$vr_mediaReal
								$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
								Case of 
									: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
									Else 
										$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionInterno)
								End case 
							Else 
								Case of 
									: (iPrintMode=Notas)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: (iPrintMode=Puntos)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
								End case 
							End if 
							$vs_mediaLiteralInterno:=NTA_PercentValue2StringValue ($vr_mediaReal;$modoImpresionInterno;$estiloEvaluacionInterno)
							[Alumnos_SintesisAnual:210]P03_PromedioInterno_Real:150:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]P03_PromedioInterno_Nota:151:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]P03_PromedioInterno_Puntos:152:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]P03_PromedioInterno_Simbolo:153:=$vs_mediaSimbolos
							[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154:=$vs_mediaLiteralInterno
						End if 
						
						  //periodo 4
						$aReal4{0}:=-10
						$hayNotas:=(AT_SearchArray (->$aReal4;">")>0)
						If ($hayNotas)
							Case of 
								: ($modoPromedioInterno=Ponderado por factor)
									$vr_mediaReal:=AL_PromedioPonderadoPorFactor (->$aReal4;->$aFactorInterno)
									$vr_mediaNota:=AL_PromedioPonderadoPorFactor (->$aNota4;->$aFactorInterno)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$aPuntos4;->$aFactorInterno)
									
								: ($modoPromedioInterno=Ponderado por Int Horaria)
									$vr_mediaReal:=AL_PromedioPonderadoPorHoras (->$aReal4;->$aHoras)
									$vr_mediaNota:=AL_PromedioPonderadoPorHoras (->$aNota4;->$aHoras)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$aPuntos4;->$aHoras)
									
								: ($modoPromedioInterno=Sin ponderaciones)
									$vr_mediaReal:=Round:C94(AT_Mean (->$aReal4;$modoCalculo);11)
									$vr_mediaNota:=Round:C94(AT_Mean (->$aNota4;$modoCalculo);11)
									$vr_mediaPuntos:=Round:C94(AT_Mean (->$aPuntos4;$modoCalculo);11)
							End case 
							
							$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
							$r:=$vr_mediaReal
							If (iPrintMode=Simbolos)
								$r:=$vr_mediaReal
								$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
								Case of 
									: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
									Else 
										$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionInterno)
								End case 
							Else 
								Case of 
									: (iPrintMode=Notas)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: (iPrintMode=Puntos)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
								End case 
							End if 
							$vs_mediaLiteralInterno:=NTA_PercentValue2StringValue ($vr_mediaReal;$modoImpresionInterno;$estiloEvaluacionInterno)
							[Alumnos_SintesisAnual:210]P04_PromedioInterno_Real:179:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]P04_PromedioInterno_Nota:180:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]P04_PromedioInterno_Puntos:181:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]P04_PromedioInterno_Simbolo:182:=$vs_mediaSimbolos
							[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183:=$vs_mediaLiteralInterno
						End if 
						
						  //periodo 5
						$aReal5{0}:=-10
						$hayNotas:=(AT_SearchArray (->$aReal5;">")>0)
						If ($hayNotas)
							Case of 
								: ($modoPromedioInterno=Ponderado por factor)
									$vr_mediaReal:=AL_PromedioPonderadoPorFactor (->$aReal5;->$aFactorInterno)
									$vr_mediaNota:=AL_PromedioPonderadoPorFactor (->$aNota5;->$aFactorInterno)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$aPuntos5;->$aFactorInterno)
									
								: ($modoPromedioInterno=Ponderado por Int Horaria)
									$vr_mediaReal:=AL_PromedioPonderadoPorHoras (->$aReal5;->$aHoras)
									$vr_mediaNota:=AL_PromedioPonderadoPorHoras (->$aNota5;->$aHoras)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$aPuntos5;->$aHoras)
									
								: ($modoPromedioInterno=Sin ponderaciones)
									$vr_mediaReal:=Round:C94(AT_Mean (->$aReal5;$modoCalculo);51)
									$vr_mediaNota:=Round:C94(AT_Mean (->$aNota5;$modoCalculo);11)
									$vr_mediaPuntos:=Round:C94(AT_Mean (->$aPuntos5;$modoCalculo);11)
							End case 
							
							$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
							$r:=$vr_mediaReal
							If (iPrintMode=Simbolos)
								$r:=$vr_mediaReal
								$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
								Case of 
									: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
									Else 
										$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionInterno)
								End case 
							Else 
								Case of 
									: (iPrintMode=Notas)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: (iPrintMode=Puntos)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
								End case 
							End if 
							$vs_mediaLiteralInterno:=NTA_PercentValue2StringValue ($vr_mediaReal;$modoImpresionInterno;$estiloEvaluacionInterno)
							[Alumnos_SintesisAnual:210]P05_PromedioInterno_Real:208:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]P05_PromedioInterno_Nota:209:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]P05_PromedioInterno_Puntos:210:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]P05_PromedioInterno_Simbolo:211:=$vs_mediaSimbolos
							[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212:=$vs_mediaLiteralInterno
						End if 
						
						  //promedio Anual INTERNO
						$aRealAnual{0}:=-10
						$hayNotas:=(AT_SearchArray (->$aRealAnual;">")>0)
						If ($hayNotas)
							Case of 
								: ($modoPromedioInterno=Ponderado por factor)
									$vr_mediaReal:=AL_PromedioPonderadoPorFactor (->$aRealAnual;->$aFactorInterno)
									$vr_mediaNota:=AL_PromedioPonderadoPorFactor (->$aRealAnualNotas;->$aFactorInterno)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$aRealAnualPuntos;->$aFactorInterno)
									
								: ($modoPromedioInterno=Ponderado por Int Horaria)
									$vr_mediaReal:=AL_PromedioPonderadoPorHoras (->$aRealAnual;->$aHoras)
									$vr_mediaNota:=AL_PromedioPonderadoPorHoras (->$aRealAnualNotas;->$aHoras)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$aRealAnualPuntos;->$aHoras)
									
								: ($modoPromedioInterno=Sin ponderaciones)
									$vr_mediaReal:=Round:C94(AT_Mean (->$aRealAnual;$modoCalculo);11)
									$vr_mediaNota:=Round:C94(AT_Mean (->$aRealAnualNotas;$modoCalculo);11)
									$vr_mediaPuntos:=Round:C94(AT_Mean (->$aRealAnualPuntos;$modoCalculo);11)
							End case 
							
							$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
							$r:=$vr_mediaReal
							If (iPrintMode=Simbolos)
								$r:=$vr_mediaReal
								$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
								Case of 
									: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPF)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPF)
									: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPF)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPF)
									Else 
										$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionInterno)
								End case 
							Else 
								Case of 
									: (iPrintMode=Notas)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPF)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPF)
									: (iPrintMode=Puntos)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPF)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPF)
								End case 
							End if 
							$vs_mediaLiteralInterno:=NTA_PercentValue2StringValue ($vr_mediaReal;$modoImpresionInterno;$estiloEvaluacionInterno)
							[Alumnos_SintesisAnual:210]PromedioAnualInterno_Real:10:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]PromedioAnualInterno_Nota:11:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]PromedioAnualInterno_Puntos:12:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]PromedioAnualInterno_Simbolo:13:=$vs_mediaSimbolos
							[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14:=$vs_mediaLiteralInterno
						End if 
						
						
						
						  //promedio final INTERNO
						$aRealFinal{0}:=-10
						$hayNotas:=(AT_SearchArray (->$aRealFinal;">")>0)
						If ($hayNotas)
							Case of 
								: ($modoPromedioInterno=Ponderado por factor)
									$vr_mediaReal:=AL_PromedioPonderadoPorFactor (->$aRealFinal;->$aFactorInterno)
									  //$vr_mediaNota:=AL_PromedioPonderadoPorFactor (->$aRealFinalNotas;->$aFactorInterno)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$aRealFinalPuntos;->$aFactorInterno)
									
								: ($modoPromedioInterno=Ponderado por Int Horaria)
									$vr_mediaReal:=AL_PromedioPonderadoPorHoras (->$aRealFinal;->$aHoras)
									  //$vr_mediaNota:=AL_PromedioPonderadoPorHoras (->$aRealFinalNotas;->$aHoras)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$aRealFinalPuntos;->$aHoras)
									
								: ($modoPromedioInterno=Sin ponderaciones)
									$vr_mediaReal:=Round:C94(AT_Mean (->$aRealFinal;$modoCalculo);11)
									  //$vr_mediaNota:=Round(AT_Mean (->$aRealFinalNotas;$modoCalculo);11)
									$vr_mediaPuntos:=Round:C94(AT_Mean (->$aRealFinalPuntos;$modoCalculo);11)
							End case 
							
							  //Calculo este promedio con el real ya que se dieron casos en que los arreglos de notas venían con escalas distintas (5.6  - 70 - 1.0 etc)
							$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;0;11)
							
							If ($vr_mediaReal>=vrNTA_MinimoEscalaReferencia)
								Case of 
									: (iEvaluationMode=Notas)
										$vt_MediaLiteral:=String:C10($vr_mediaNota)
									: (iEvaluationMode=Puntos)
										$vt_MediaLiteral:=String:C10($vr_mediaPuntos)
									: ((iEvaluationMode=Porcentaje) | (iEvaluationMode=Simbolos))
										$vt_MediaLiteral:=String:C10($vr_mediaReal)
								End case 
							End if 
							[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Nota:273:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Puntos:274:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Literal:275:=$vt_MediaLiteral
							
							$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
							$r:=$vr_mediaReal
							If (iPrintMode=Simbolos)
								$r:=$vr_mediaReal
								$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
								Case of 
									: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecNF)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecNF)
									: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecNF)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecNF)
									Else 
										$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionInterno)
								End case 
							Else 
								Case of 
									: (iPrintMode=Notas)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecNF)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecNF)
									: (iPrintMode=Puntos)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecNF)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecNF)
								End case 
							End if 
							$vs_mediaLiteralInterno:=NTA_PercentValue2StringValue ($vr_mediaReal;$modoImpresionInterno;$estiloEvaluacionInterno)
							[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]PromedioFinalInterno_Nota:21:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]PromedioFinalInterno_Puntos:22:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]PromedioFinalInterno_Simbolo:23:=$vs_mediaSimbolos
							[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24:=$vs_mediaLiteralInterno
						End if 
						AL_EscribeSintesisAnual   //llamada sin argumentos, se escribe en disco el registro en memoria
						
					End if 
					
					
					  //CALCULO DE PROMEDIOS OFICIALES
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					USE SET:C118("Calificaciones")
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incide_en_promedio:27=True:C214)
					
					If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
						ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]ordenGeneral:105;>)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Real:112;$aReal1;[Alumnos_Calificaciones:208]P02_Final_Real:187;$aReal2;[Alumnos_Calificaciones:208]P03_Final_Real:262;$aReal3;[Alumnos_Calificaciones:208]P04_Final_Real:337;$aReal4;[Alumnos_Calificaciones:208]P05_Final_Real:412;$aReal5)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Nota:113;$aNota1;[Alumnos_Calificaciones:208]P02_Final_Nota:188;$aNota2;[Alumnos_Calificaciones:208]P03_Final_Nota:263;$aNota3;[Alumnos_Calificaciones:208]P04_Final_Nota:338;$aNota4;[Alumnos_Calificaciones:208]P05_Final_Nota:413;$aNota5)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Puntos:114;$aPuntos1;[Alumnos_Calificaciones:208]P02_Final_Puntos:189;$aPuntos2;[Alumnos_Calificaciones:208]P03_Final_Puntos:264;$aPuntos3;[Alumnos_Calificaciones:208]P04_Final_Puntos:339;$aPuntos4;[Alumnos_Calificaciones:208]P05_Final_Puntos:414;$aPuntos5)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Anual_Real:11;$aRealAnual;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;$aRealFinal;[Alumnos_Calificaciones:208]Anual_Nota:12;$aRealAnualNotas;[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;$aRealFinalNotas;[Alumnos_Calificaciones:208]Anual_Puntos:13;$aRealAnualPuntos;[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;$aRealFinalPuntos)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$aRealOficial;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;$aRealNotasOficial;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;$aRealPuntosOficial;[Asignaturas:18]Incide_en_promedio:27;$aIncidePromedioOficial;[Asignaturas:18]IncideEnPromedioInterno:64;$aIncidePromedioInterno;[Asignaturas:18]Horas_Semanales:51;$aHoras;[Asignaturas:18]PonderacionEnPromedioOF:109;$aFactorOficial)
						SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
						
						
						If ($minimoOFICIAL=0)
							$modoCalculo:=3  //0 o mayor que 0
						Else 
							$modoCalculo:=1  //solo valores positivos
						End if 
						
						
						  //periodo 1
						$aReal1{0}:=-10
						$hayNotas:=(AT_SearchArray (->$aReal1;">")>0)
						If ($hayNotas)
							
							Case of 
								: ($modoPromedioInterno=Ponderado por factor)
									$vr_mediaReal:=AL_PromedioPonderadoPorFactor (->$aReal1;->$aFactorOficial)
									$vr_mediaNota:=AL_PromedioPonderadoPorFactor (->$aNota1;->$aFactorOficial)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$aPuntos1;->$aFactorOficial)
									
								: ($modoPromedioOficial=Ponderado por Int Horaria)
									$vr_mediaReal:=AL_PromedioPonderadoPorHoras (->$aReal1;->$aHoras)
									$vr_mediaNota:=AL_PromedioPonderadoPorHoras (->$aNota1;->$aHoras)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$aPuntos1;->$aHoras)
									
								: ($modoPromedioOficial=Sin ponderaciones)
									$vr_mediaReal:=Round:C94(AT_Mean (->$aReal1;$modoCalculo);11)
									$vr_mediaNota:=Round:C94(AT_Mean (->$aNota1;$modoCalculo);11)
									$vr_mediaPuntos:=Round:C94(AT_Mean (->$aPuntos1;$modoCalculo);11)
							End case 
							
							$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
							$r:=$vr_mediaReal
							If (iPrintMode=Simbolos)
								$r:=$vr_mediaReal
								$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
								Case of 
									: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
									Else 
										$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionInterno)
								End case 
							Else 
								Case of 
									: (iPrintMode=Notas)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: (iPrintMode=Puntos)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
								End case 
							End if 
							$vs_mediaLiteralOficial:=NTA_PercentValue2StringValue ($vr_mediaReal;$modoImpresionOficial;$estiloEvaluacionOficial)
							[Alumnos_SintesisAnual:210]P01_PromedioOficial_Real:237:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]P01_PromedioOficial_Nota:238:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]P01_PromedioOficial_Puntos:239:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]P01_PromedioOficial_Simbolo:240:=$vs_mediaSimbolos
							[Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241:=$vs_mediaLiteralOficial
						End if 
						
						  //periodo 2
						$aReal2{0}:=-10
						$hayNotas:=(AT_SearchArray (->$aReal2;">")>0)
						If ($hayNotas)
							
							Case of 
								: ($modoPromedioOficial=Ponderado por factor)
									$vr_mediaReal:=AL_PromedioPonderadoPorFactor (->$aReal2;->$aFactorOficial)
									$vr_mediaNota:=AL_PromedioPonderadoPorFactor (->$aNota2;->$aFactorOficial)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$aPuntos2;->$aFactorOficial)
									
								: ($modoPromedioOficial=Ponderado por Int Horaria)
									$vr_mediaReal:=AL_PromedioPonderadoPorHoras (->$aReal2;->$aHoras)
									$vr_mediaNota:=AL_PromedioPonderadoPorHoras (->$aNota2;->$aHoras)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$aPuntos2;->$aHoras)
									
								: ($modoPromedioOficial=Sin ponderaciones)
									$vr_mediaReal:=Round:C94(AT_Mean (->$aReal2;$modoCalculo);11)
									$vr_mediaNota:=Round:C94(AT_Mean (->$aNota2;$modoCalculo);11)
									$vr_mediaPuntos:=Round:C94(AT_Mean (->$aPuntos2;$modoCalculo);11)
							End case 
							
							$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
							$r:=$vr_mediaReal
							If (iPrintMode=Simbolos)
								$r:=$vr_mediaReal
								$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
								Case of 
									: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
									Else 
										$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionInterno)
								End case 
							Else 
								Case of 
									: (iPrintMode=Notas)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: (iPrintMode=Puntos)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
								End case 
							End if 
							$vs_mediaLiteralOficial:=NTA_PercentValue2StringValue ($vr_mediaReal;$modoImpresionOficial;$estiloEvaluacionOficial)
							[Alumnos_SintesisAnual:210]P02_PromedioOficial_Real:242:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]P02_PromedioOficial_Nota:243:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]P02_PromedioOficial_Puntos:244:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]P02_PromedioOficial_Simbolo:245:=$vs_mediaSimbolos
							[Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246:=$vs_mediaLiteralOficial
						End if 
						
						  //periodo 3
						$aReal3{0}:=-10
						$hayNotas:=(AT_SearchArray (->$aReal3;">")>0)
						If ($hayNotas)
							
							Case of 
								: ($modoPromedioOficial=Ponderado por factor)
									$vr_mediaReal:=AL_PromedioPonderadoPorFactor (->$aReal3;->$aFactorOficial)
									$vr_mediaNota:=AL_PromedioPonderadoPorFactor (->$aNota3;->$aFactorOficial)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$aPuntos3;->$aFactorOficial)
									
								: ($modoPromedioOficial=Ponderado por Int Horaria)
									$vr_mediaReal:=AL_PromedioPonderadoPorHoras (->$aReal3;->$aHoras)
									$vr_mediaNota:=AL_PromedioPonderadoPorHoras (->$aNota3;->$aHoras)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$aPuntos3;->$aHoras)
									
								: ($modoPromedioOficial=Sin ponderaciones)
									$vr_mediaReal:=Round:C94(AT_Mean (->$aReal3;$modoCalculo);11)
									$vr_mediaNota:=Round:C94(AT_Mean (->$aNota3;$modoCalculo);11)
									$vr_mediaPuntos:=Round:C94(AT_Mean (->$aPuntos3;$modoCalculo);11)
							End case 
							
							$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
							$r:=$vr_mediaReal
							If (iPrintMode=Simbolos)
								$r:=$vr_mediaReal
								$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
								Case of 
									: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
									Else 
										$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionInterno)
								End case 
							Else 
								Case of 
									: (iPrintMode=Notas)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal)
									: (iPrintMode=Puntos)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($r;$truncate)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
								End case 
							End if 
							$vs_mediaLiteralOficial:=NTA_PercentValue2StringValue ($vr_mediaReal;$modoImpresionOficial;$estiloEvaluacionOficial)
							[Alumnos_SintesisAnual:210]P03_PromedioOficial_Real:247:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]P03_PromedioOficial_Nota:248:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]P03_PromedioOficial_Puntos:249:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]P03_PromedioOficial_Simbolo:250:=$vs_mediaSimbolos
							[Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251:=$vs_mediaLiteralOficial
						End if 
						
						  //periodo 4
						$aReal4{0}:=-10
						$hayNotas:=(AT_SearchArray (->$aReal4;">")>0)
						If ($hayNotas)
							
							Case of 
								: ($modoPromedioOficial=Ponderado por factor)
									$vr_mediaReal:=AL_PromedioPonderadoPorFactor (->$aReal4;->$aFactorOficial)
									$vr_mediaNota:=AL_PromedioPonderadoPorFactor (->$aNota4;->$aFactorOficial)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$aPuntos4;->$aFactorOficial)
									
								: ($modoPromedioOficial=Ponderado por Int Horaria)
									$vr_mediaReal:=AL_PromedioPonderadoPorHoras (->$aReal4;->$aHoras)
									$vr_mediaNota:=AL_PromedioPonderadoPorHoras (->$aNota4;->$aHoras)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$aPuntos4;->$aHoras)
									
								: ($modoPromedioOficial=Sin ponderaciones)
									$vr_mediaReal:=Round:C94(AT_Mean (->$aReal4;$modoCalculo);11)
									$vr_mediaNota:=Round:C94(AT_Mean (->$aNota4;$modoCalculo);11)
									$vr_mediaPuntos:=Round:C94(AT_Mean (->$aPuntos4;$modoCalculo);11)
							End case 
							
							If (iPrintMode=Simbolos)
								$r:=$vr_mediaReal
								$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
								Case of 
									: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
									Else 
										$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionOficial)
								End case 
							Else 
								$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionOficial)
							End if 
							$vs_mediaLiteralOficial:=NTA_PercentValue2StringValue ($vr_mediaReal;$modoImpresionOficial;$estiloEvaluacionOficial)
							[Alumnos_SintesisAnual:210]P04_PromedioOficial_Real:252:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]P04_PromedioOficial_Nota:253:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]P04_PromedioOficial_Puntos:254:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]P04_PromedioOficial_Simbolo:255:=$vs_mediaSimbolos
							[Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256:=$vs_mediaLiteralOficial
						End if 
						
						  //periodo 5
						$aReal5{0}:=-10
						$hayNotas:=(AT_SearchArray (->$aReal5;">")>0)
						If ($hayNotas)
							
							Case of 
								: ($modoPromedioOficial=Ponderado por factor)
									$vr_mediaReal:=AL_PromedioPonderadoPorFactor (->$aReal5;->$aFactorOficial)
									$vr_mediaNota:=AL_PromedioPonderadoPorFactor (->$aNota5;->$aFactorOficial)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$aPuntos5;->$aFactorOficial)
									
								: ($modoPromedioOficial=Ponderado por Int Horaria)
									$vr_mediaReal:=AL_PromedioPonderadoPorHoras (->$aReal5;->$aHoras)
									$vr_mediaNota:=AL_PromedioPonderadoPorHoras (->$aNota5;->$aHoras)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$aPuntos5;->$aHoras)
									
								: ($modoPromedioOficial=Sin ponderaciones)
									$vr_mediaReal:=Round:C94(AT_Mean (->$aReal5;$modoCalculo);11)
									$vr_mediaNota:=Round:C94(AT_Mean (->$aNota5;$modoCalculo);11)
									$vr_mediaPuntos:=Round:C94(AT_Mean (->$aPuntos5;$modoCalculo);11)
							End case 
							
							$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
							$r:=$vr_mediaReal
							If (iPrintMode=Simbolos)
								$r:=$vr_mediaReal
								$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
								Case of 
									: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
									Else 
										$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionInterno)
								End case 
							Else 
								Case of 
									: (iPrintMode=Notas)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
									: (iPrintMode=Puntos)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPP)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPP)
								End case 
							End if 
							$vs_mediaLiteralOficial:=NTA_PercentValue2StringValue ($vr_mediaReal;$modoImpresionOficial;$estiloEvaluacionOficial)
							[Alumnos_SintesisAnual:210]P05_PromedioOficial_Real:257:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]P05_PromedioOficial_Nota:258:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]P05_PromedioOficial_Puntos:259:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]P05_PromedioOficial_Simbolo:260:=$vs_mediaSimbolos
							[Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261:=$vs_mediaLiteralOficial
						End if 
						
						  //promedio anual OFICIAL
						$aRealAnual{0}:=-10
						$hayNotas:=(AT_SearchArray (->$aRealAnual;">")>0)
						If ($hayNotas)
							
							Case of 
								: ($modoPromedioOficial=Ponderado por factor)
									$vr_mediaReal:=AL_PromedioPonderadoPorFactor (->$aRealAnual;->$aFactorOficial)
									$vr_mediaNota:=AL_PromedioPonderadoPorFactor (->$aRealAnualNotas;->$aFactorOficial)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$aRealAnualPuntos;->$aFactorOficial)
									
								: ($modoPromedioOficial=Ponderado por Int Horaria)
									$vr_mediaReal:=AL_PromedioPonderadoPorHoras (->$aRealAnual;->$aHoras)
									$vr_mediaNota:=AL_PromedioPonderadoPorHoras (->$aRealAnualNotas;->$aHoras)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$aRealPuntosOficial;->$aHoras)
									
								: ($modoPromedioOficial=Sin ponderaciones)
									$vr_mediaReal:=Round:C94(AT_Mean (->$aRealAnual;$modoCalculo);11)
									$vr_mediaNota:=Round:C94(AT_Mean (->$aRealAnualNotas;$modoCalculo);11)
									$vr_mediaPuntos:=Round:C94(AT_Mean (->$aRealAnualPuntos;$modoCalculo);11)
							End case 
							
							$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
							$r:=$vr_mediaReal
							If (iPrintMode=Simbolos)
								$r:=$vr_mediaReal
								$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
								Case of 
									: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPF)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPF)
									: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPF)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPF)
									Else 
										$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionInterno)
								End case 
							Else 
								Case of 
									: (iPrintMode=Notas)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPF)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPF)
									: (iPrintMode=Puntos)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecPF)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecPF)
								End case 
							End if 
							$vs_mediaLiteralOficial:=NTA_PercentValue2StringValue ($vr_mediaReal;$modoImpresionOficial;$estiloEvaluacionOficial)
							[Alumnos_SintesisAnual:210]PromedioAnualOficial_Real:15:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]PromedioAnualOficial_Nota:16:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]PromedioAnualOficial_Puntos:17:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]PromedioAnualOficial_Simbolo:18:=$vs_mediaSimbolos
							[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19:=$vs_mediaLiteralOficial
						End if 
						
						  //promedio final OFICIAL
						$aRealOficial{0}:=-10
						$hayNotas:=(AT_SearchArray (->$aRealOficial;">")>0)
						If ($hayNotas)
							$vr_mediaReal:=Round:C94(AT_Mean (->$aRealOficial;$modoCalculo);11)
							$vr_mediaNota:=Round:C94(AT_Mean (->$aRealNotasOficial;$modoCalculo);11)
							$vr_mediaPuntos:=Round:C94(AT_Mean (->$aRealPuntosOficial;$modoCalculo);11)
							
							Case of 
								: ($modoPromedioOficial=Ponderado por factor)
									$vr_mediaReal:=AL_PromedioPonderadoPorFactor (->$aRealFinal;->$aFactorOficial)
									$vr_mediaNota:=AL_PromedioPonderadoPorFactor (->$aRealFinalNotas;->$aFactorOficial)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorFactor (->$aRealFinalPuntos;->$aFactorOficial)
									
								: ($modoPromedioOficial=Ponderado por Int Horaria)
									$vr_mediaReal:=AL_PromedioPonderadoPorHoras (->$aRealOficial;->$aHoras)
									$vr_mediaNota:=AL_PromedioPonderadoPorHoras (->$aRealNotasOficial;->$aHoras)
									$vr_mediaPuntos:=AL_PromedioPonderadoPorHoras (->$aRealPuntosOficial;->$aHoras)
									
								: ($modoPromedioOficial=Sin ponderaciones)
									$vr_mediaReal:=Round:C94(AT_Mean (->$aRealOficial;$modoCalculo);11)
									$vr_mediaNota:=Round:C94(AT_Mean (->$aRealNotasOficial;$modoCalculo);11)
									$vr_mediaPuntos:=Round:C94(AT_Mean (->$aRealPuntosOficial;$modoCalculo);11)
							End case 
							
							If ($vr_mediaReal>=vrNTA_MinimoEscalaReferencia)
								Case of 
									: (iEvaluationMode=Notas)
										$vt_MediaLiteral:=String:C10($vr_mediaNota)
									: (iEvaluationMode=Puntos)
										$vt_MediaLiteral:=String:C10($vr_mediaPuntos)
									: ((iEvaluationMode=Porcentaje) | (iEvaluationMode=Simbolos))
										$vt_MediaLiteral:=String:C10($vr_mediaReal)
								End case 
							End if 
							[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Nota:269:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Puntos:270:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Literal:271:=$vt_MediaLiteral
							
							
							$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
							$r:=$vr_mediaReal
							If (iPrintMode=Simbolos)
								$r:=$vr_mediaReal
								$truncate:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
								Case of 
									: ((viEVS_EquMode=Notas) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecNO)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecNO)
									: ((viEVS_EquMode=Puntos) & (vi_ConvertSymbolicAverage=1))
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecNO)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecNO)
									Else 
										$vs_mediaSimbolos:=NTA_PercentValue2StringValue ($vr_mediaReal;Simbolos;$estiloEvaluacionInterno)
								End case 
							Else 
								Case of 
									: (iPrintMode=Notas)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecNO)
										$vr_mediaReal:=EV2_Nota_a_Real ($vr_mediaNota)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecNO)
									: (iPrintMode=Puntos)
										$vr_mediaPuntos:=EV2_Real_a_Puntos ($vr_mediaReal;$truncate;iPointsDecNO)
										$vr_mediaReal:=EV2_Puntos_a_Real ($vr_mediaPuntos)
										$vs_mediaSimbolos:=EV2_Real_a_Simbolo ($vr_mediaReal)
										$vr_mediaNota:=EV2_Real_a_Nota ($vr_mediaReal;$truncate;iGradesDecNO)
								End case 
							End if 
							$vs_mediaLiteralOficial:=NTA_PercentValue2StringValue ($vr_mediaReal;$modoImpresionOficial;$estiloEvaluacionOficial)
							[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25:=$vr_mediaReal
							[Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26:=$vr_mediaNota
							[Alumnos_SintesisAnual:210]PromedioFinalOficial_Puntos:27:=$vr_mediaPuntos
							[Alumnos_SintesisAnual:210]PromedioFinalOficial_Simbolo:28:=$vs_mediaSimbolos
							[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29:=$vs_mediaLiteralOficial
						End if 
						
						SAVE RECORD:C53([Alumnos_SintesisAnual:210])
						CLEAR SET:C117("Calificaciones")
					End if 
					
					
				End if 
				
				
				EV2_InitArrays 
			End if 
		End if 
	End for 
End if 



