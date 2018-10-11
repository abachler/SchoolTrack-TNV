//%attributes = {}
  // TGR_AlumnosSintesisAnual()
  // Por: Alberto Bachler K.: 14-05-14, 12:41:59
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_enModoSoloLectura)
C_LONGINT:C283($l_diashastaHoy;$l_diasPeriodo;$l_estiloEvaluacionInterno;$l_idCursoHistorico;$l_modoRegistroAsistencia;$l_nivel;$modoRegistroAtrasos)
C_TEXT:C284($t_curso;$t_llaveRegistro)


  // Alberto Bachler K.: 14-05-14, 11:53:50
  // Dejo registro en el log de actividades si el numero nivel del registro es igua a 0
  // ---------------------------------------------

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If (Not:C34(<>vb_ImportHistoricos_STX))
	
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[Alumnos_SintesisAnual:210]ID:267:=SQ_SeqNumber (->[Alumnos_SintesisAnual:210]ID:267)
			
			$id_alu:=Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)  //MONO 184433
			$l_nivelAlu:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alu;->[Alumnos:2]nivel_numero:29)  //MONO 184433
			
			If (([Alumnos_SintesisAnual:210]Año:2=<>gYear) & ([Alumnos_SintesisAnual:210]NumeroNivel:6=$l_nivelAlu))  //MONO 184433
				[Alumnos_SintesisAnual:210]ID_Alumno:4:=Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
				[Alumnos_SintesisAnual:210]LlavePrincipal:5:=String:C10([Alumnos_SintesisAnual:210]ID_Institucion:1)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10([Alumnos_SintesisAnual:210]ID_Alumno:4)
				AL_CalculaPorcentajeAsistencia 
			Else 
				[Alumnos_SintesisAnual:210]ID_Alumno:4:=-Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
				[Alumnos_SintesisAnual:210]LlavePrincipal:5:=String:C10([Alumnos_SintesisAnual:210]ID_Institucion:1)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10(Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4))
			End if 
			
			[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33:=100
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92:=-10
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Nota:93:=-10
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Puntos:94:=-10
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Simbolo:95:=""
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96:=""
			
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Real:121:=-10
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Nota:122:=-10
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Puntos:123:=-10
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Simbolo:124:=""
			[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125:=""
			
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Real:150:=-10
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Nota:151:=-10
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Puntos:152:=-10
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Simbolo:153:=""
			[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154:=""
			
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Real:179:=-10
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Nota:180:=-10
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Puntos:181:=-10
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Simbolo:182:=""
			[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183:=""
			
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Real:208:=-10
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Nota:209:=-10
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Puntos:210:=-10
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Simbolo:211:=""
			[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212:=""
			
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Real:15:=-10
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Nota:16:=-10
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Puntos:17:=-10
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Simbolo:18:=""
			[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19:=""
			
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20:=-10
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Nota:21:=-10
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Puntos:22:=-10
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Simbolo:23:=""
			[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24:=""
			
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25:=-10
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26:=-10
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Puntos:27:=-10
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Simbolo:28:=""
			[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29:=""
			
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92:=-10
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Nota:93:=-10
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Puntos:94:=-10
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Simbolo:95:=""
			[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96:=""
			
			[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Literal:271:=""
			[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268:=-10
			[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Nota:269:=-10
			[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Puntos:270:=-10
			
			[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Literal:275:=""
			[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272:=-10
			[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Nota:273:=-10
			[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Puntos:274:=-10
			
			If ([Alumnos_SintesisAnual:210]NumeroNivel:6=0)
				LOG_RegisterEvt ("Registro síntesis anual dañado: Numero de nivel 0. Llave: "+[Alumnos_SintesisAnual:210]LlavePrincipal:5)
			End if 
			
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
			$id_alu:=Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)  //MONO 184433
			$l_nivelAlu:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alu;->[Alumnos:2]nivel_numero:29)  //MONO 184433
			
			If (([Alumnos_SintesisAnual:210]Año:2=<>gYear) & ([Alumnos_SintesisAnual:210]NumeroNivel:6=$l_nivelAlu))  //MONO 184433
				[Alumnos_SintesisAnual:210]ID_Alumno:4:=Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
				[Alumnos_SintesisAnual:210]LlavePrincipal:5:=String:C10([Alumnos_SintesisAnual:210]ID_Institucion:1)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10(Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4))
				
				$modoRegistroAtrasos:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[xxSTR_Niveles:6]Lates_Mode:16)
				$l_estiloEvaluacionInterno:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[xxSTR_Niveles:6]EvStyle_interno:33)
				
				Case of 
					: (<>vs_AppDecimalSeparator=",")
						[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96:=Replace string:C233([Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96;".";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125:=Replace string:C233([Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125;".";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154:=Replace string:C233([Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154;".";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183:=Replace string:C233([Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183;".";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212:=Replace string:C233([Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212;".";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241:=Replace string:C233([Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241;".";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246:=Replace string:C233([Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246;".";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251:=Replace string:C233([Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251;".";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256:=Replace string:C233([Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256;".";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261:=Replace string:C233([Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261;".";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19:=Replace string:C233([Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19;".";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14:=Replace string:C233([Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14;".";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24:=Replace string:C233([Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24;".";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29:=Replace string:C233([Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29;".";<>vs_AppDecimalSeparator)
						
					: (<>vs_AppDecimalSeparator=".")
						[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96:=Replace string:C233([Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96;",";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125:=Replace string:C233([Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125;",";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154:=Replace string:C233([Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154;",";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183:=Replace string:C233([Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183;",";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212:=Replace string:C233([Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212;",";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241:=Replace string:C233([Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241;",";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246:=Replace string:C233([Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246;",";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251:=Replace string:C233([Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251;",";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256:=Replace string:C233([Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256;",";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261:=Replace string:C233([Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261;",";<>vs_AppDecimalSeparator)
						
						[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19:=Replace string:C233([Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19;",";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14:=Replace string:C233([Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14;",";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24:=Replace string:C233([Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24;",";<>vs_AppDecimalSeparator)
						[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29:=Replace string:C233([Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29;",";<>vs_AppDecimalSeparator)
				End case 
				
				[Alumnos_SintesisAnual:210]Anotaciones_Negativas:36:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Negativas:103+[Alumnos_SintesisAnual:210]P02_Anotaciones_Negativas:132+[Alumnos_SintesisAnual:210]P03_Anotaciones_Negativas:161+[Alumnos_SintesisAnual:210]P04_Anotaciones_Negativas:190+[Alumnos_SintesisAnual:210]P05_Anotaciones_Negativas:219
				[Alumnos_SintesisAnual:210]Anotaciones_Neutras:35:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Neutras:102+[Alumnos_SintesisAnual:210]P02_Anotaciones_Neutras:131+[Alumnos_SintesisAnual:210]P03_Anotaciones_Neutras:160+[Alumnos_SintesisAnual:210]P04_Anotaciones_Neutras:189+[Alumnos_SintesisAnual:210]P05_Anotaciones_Neutras:218
				[Alumnos_SintesisAnual:210]Anotaciones_Positivas:34:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Positivas:101+[Alumnos_SintesisAnual:210]P02_Anotaciones_Positivas:130+[Alumnos_SintesisAnual:210]P03_Anotaciones_Positivas:159+[Alumnos_SintesisAnual:210]P04_Anotaciones_Positivas:188+[Alumnos_SintesisAnual:210]P05_Anotaciones_Positivas:217
				If ($modoRegistroAtrasos=1)
					[Alumnos_SintesisAnual:210]Atrasos_Jornada:40:=[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107+[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136+[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165+[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194+[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223
					[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41:=[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108+[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137+[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166+[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195+[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224
				End if 
				[Alumnos_SintesisAnual:210]Castigos:43:=[Alumnos_SintesisAnual:210]P01_Castigos:110+[Alumnos_SintesisAnual:210]P02_Castigos:139+[Alumnos_SintesisAnual:210]P03_Castigos:168+[Alumnos_SintesisAnual:210]P04_Castigos:197+[Alumnos_SintesisAnual:210]P05_Castigos:226
				[Alumnos_SintesisAnual:210]Premios:42:=[Alumnos_SintesisAnual:210]P01_Premios:109+[Alumnos_SintesisAnual:210]P02_Premios:138+[Alumnos_SintesisAnual:210]P03_Premios:167+[Alumnos_SintesisAnual:210]P04_Premios:196+[Alumnos_SintesisAnual:210]P05_Premios:225
				[Alumnos_SintesisAnual:210]Suspensiones:44:=[Alumnos_SintesisAnual:210]P01_Suspensiones:111+[Alumnos_SintesisAnual:210]P02_Suspensiones:140+[Alumnos_SintesisAnual:210]P03_Suspensiones:169+[Alumnos_SintesisAnual:210]P04_Suspensiones:198+[Alumnos_SintesisAnual:210]P05_Suspensiones:227
				[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45:=[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112+[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141+[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170+[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoJornada:199+[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoJornada:228
				[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46:=[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoSesiones:113+[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoSesiones:142+[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoSesiones:171+[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoSesiones:200+[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoSesiones:229
				[Alumnos_SintesisAnual:210]PuntajeConductual_Positivo:37:=[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Positivo:104+[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Positivo:133+[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Positivo:162+[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Positivo:191+[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Positivo:220
				[Alumnos_SintesisAnual:210]PuntajeConductual_Negativo:38:=[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Negativo:105+[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Negativo:134+[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Negativo:163+[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Negativo:192+[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Negativo:221
				[Alumnos_SintesisAnual:210]PuntajeConductual_Balance:39:=[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Balance:106+[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Balance:135+[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Balance:164+[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Balance:193+[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Balance:222
				
				If (Not:C34(<>vb_BloquearModifSituacionFinal))
					AL_CalculaPorcentajeAsistencia 
				End if 
				
				  //registro en [Alumnos_Conducta] de la información consolidada (hasta que no se decida abandonar el registro en esa tabla
				KRL_FindAndLoadRecordByIndex (->[Alumnos_Conducta:8]Número_de_Alumno:1;->[Alumnos_SintesisAnual:210]ID_Alumno:4;True:C214)
				[Alumnos_Conducta:8]Total_Inasistencias:2:=[Alumnos_SintesisAnual:210]Inasistencias_Dias:30
				[Alumnos_Conducta:8]Total_Horas_inasistencia:44:=[Alumnos_SintesisAnual:210]Inasistencias_Horas:31
				[Alumnos_Conducta:8]Total_anotaciones_negativas:4:=[Alumnos_SintesisAnual:210]Anotaciones_Negativas:36
				[Alumnos_Conducta:8]Total_anotaciones_positivas:3:=[Alumnos_SintesisAnual:210]Anotaciones_Positivas:34
				[Alumnos_Conducta:8]Total_atrasos:6:=[Alumnos_SintesisAnual:210]Atrasos_Jornada:40
				[Alumnos_Conducta:8]Total_AtrasosInterSesiones:77:=[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41
				[Alumnos_Conducta:8]Total_castigos:5:=[Alumnos_SintesisAnual:210]Castigos:43
				[Alumnos_Conducta:8]Total_ConstanciasObservaciones:60:=[Alumnos_SintesisAnual:210]Anotaciones_Neutras:35
				[Alumnos_Conducta:8]Total_FaltasRetardo:90:=[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45
				[Alumnos_Conducta:8]Total_FaltasRetardoHora:91:=[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46
				[Alumnos_Conducta:8]Total_RetardoAcumulado:92:=[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51
				[Alumnos_Conducta:8]Total_suspensiones:34:=[Alumnos_SintesisAnual:210]Suspensiones:44
				[Alumnos_Conducta:8]PuntosNegativos_Total:65:=[Alumnos_SintesisAnual:210]PuntajeConductual_Negativo:38
				[Alumnos_Conducta:8]PuntosPositivos_Total:71:=[Alumnos_SintesisAnual:210]PuntajeConductual_Positivo:37
				[Alumnos_Conducta:8]PuntosNegativos_Acumulado:66:=[Alumnos_SintesisAnual:210]PuntajeNegativoAcumulado:52
				[Alumnos_Conducta:8]PuntosPositivos_Acumulado:72:=[Alumnos_SintesisAnual:210]PuntajePositivoAcumulado:53
				[Alumnos_Conducta:8]Porcentaje_de_asistencia:36:=[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33
				[Alumnos_Conducta:8]Condicional:7:=[Alumnos_SintesisAnual:210]Condicionalidad_Activada:57
				[Alumnos_Conducta:8]Motivo_de_condicionalidad:9:=[Alumnos_SintesisAnual:210]Condicionalidad_Motivo:59
				[Alumnos_Conducta:8]Termino_de_condicionalidad:8:=[Alumnos_SintesisAnual:210]Condicionalidad_Hasta:58
				[Alumnos_Conducta:8]Total_castigos:5:=[Alumnos_SintesisAnual:210]Castigos:43
				SAVE RECORD:C53([Alumnos_Conducta:8])
				KRL_UnloadReadOnly (->[Alumnos_Conducta:8])
				
				EVS_ReadStyleData ($l_estiloEvaluacionInterno)
				$b_enModoSoloLectura:=Read only state:C362([Alumnos:2])
				KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[Alumnos_SintesisAnual:210]ID_Alumno:4;True:C214)
				[Alumnos:2]Porcentaje_asistencia:56:=[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33
				[Alumnos:2]Observaciones_en_Acta:58:=[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9
				[Alumnos:2]Situacion_final:33:=[Alumnos_SintesisAnual:210]SituacionFinal:8
				[Alumnos:2]Comentario_Situacion_Final:31:=[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62
				[Alumnos:2]Observaciones_finales:47:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
				[Alumnos:2]Observaciones_Periodo1:44:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
				[Alumnos:2]Observaciones_Periodo2:45:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
				[Alumnos:2]Observaciones_Periodo3:46:=[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
				[Alumnos:2]Observaciones_Periodo4:55:=[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
				[Alumnos:2]Observaciones_Periodo5:106:=[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230
				[Alumnos:2]Promedio_Anual:63:=[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14
				[Alumnos:2]Promedio_General_Interno:88:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24
				[Alumnos:2]Promedio_General_Oficial:32:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29
				[Alumnos:2]Promedio_Periodo1:59:=[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96
				[Alumnos:2]Promedio_Periodo2:60:=[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125
				[Alumnos:2]Promedio_Periodo3:61:=[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154
				[Alumnos:2]Promedio_Periodo4:62:=[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183
				[Alumnos:2]Promedio_Periodo5:107:=[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212
				
				[Alumnos:2]Promedio_Periodo1:59:=Replace string:C233([Alumnos:2]Promedio_Periodo1:59;<>tXS_RS_DecimalSeparator;<>vs_AppDecimalSeparator)
				[Alumnos:2]Promedio_Periodo2:60:=Replace string:C233([Alumnos:2]Promedio_Periodo2:60;<>tXS_RS_DecimalSeparator;<>vs_AppDecimalSeparator)
				[Alumnos:2]Promedio_Periodo3:61:=Replace string:C233([Alumnos:2]Promedio_Periodo3:61;<>tXS_RS_DecimalSeparator;<>vs_AppDecimalSeparator)
				[Alumnos:2]Promedio_Periodo4:62:=Replace string:C233([Alumnos:2]Promedio_Periodo4:62;<>tXS_RS_DecimalSeparator;<>vs_AppDecimalSeparator)
				[Alumnos:2]Promedio_Anual:63:=Replace string:C233([Alumnos:2]Promedio_Anual:63;<>tXS_RS_DecimalSeparator;<>vs_AppDecimalSeparator)
				[Alumnos:2]Promedio_General_Interno:88:=Replace string:C233([Alumnos:2]Promedio_General_Interno:88;<>tXS_RS_DecimalSeparator;<>vs_AppDecimalSeparator)
				[Alumnos:2]Promedio_General_Oficial:32:=Replace string:C233([Alumnos:2]Promedio_General_Oficial:32;<>tXS_RS_DecimalSeparator;<>vs_AppDecimalSeparator)
				SAVE RECORD:C53([Alumnos:2])
				KRL_ReloadAsReadOnly (->[Alumnos:2])
				
			Else 
				[Alumnos_SintesisAnual:210]ID_Alumno:4:=-Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
				[Alumnos_SintesisAnual:210]LlavePrincipal:5:=String:C10([Alumnos_SintesisAnual:210]ID_Institucion:1)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10(Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4))
				
				[Alumnos_Historico:25]Situacion_final:19:=[Alumnos_SintesisAnual:210]SituacionFinal:8
				SAVE RECORD:C53([Alumnos_Historico:25])
				
				If ([Alumnos_Historico:25]Situacion_final:19="R")
					[Alumnos:2]Es_Repitente:77:=True:C214
				Else 
					[Alumnos:2]Es_Repitente:77:=False:C215
				End if 
				SAVE RECORD:C53([Alumnos:2])
				
				If (([Alumnos_SintesisAnual:210]Curso:7="") | ([Alumnos_SintesisAnual:210]NumeroNivel:6=0))
					  //20101217 RCH v562 Cuando se ejecuta en Cliente servidor no esta cargado alumnos historico y se asignaba [Alumnos_Histórico]Nivel a [Alumnos_SintesisAnual]NumeroNivel. Se agrega abs del id del alumno
					  //$t_llaveRegistro:=String(Abs([Alumnos_SintesisAnual]ID_Alumno))+"."+String([Alumnos_Histórico]Año)
					  //201309012 ASM ticket 124982 . En C/S el registro de alumnos_historicos no se encontraba cargado. Cambié la llave por el año de la sintesis, ya que es el año que se está modificando.
					$t_llaveRegistro:=String:C10(Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4))+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)
					$t_curso:=KRL_GetTextFieldData (->[Alumnos_Historico:25]Llave:42;->$t_llaveRegistro;->[Alumnos_Historico:25]Curso:3)
					$l_nivel:=KRL_GetNumericFieldData (->[Alumnos_Historico:25]Llave:42;->$t_llaveRegistro;->[Alumnos_Historico:25]Nivel:11)
					$l_idCursoHistorico:=KRL_GetNumericFieldData (->[Alumnos_Historico:25]Llave:42;->$t_llaveRegistro;->[Alumnos_Historico:25]ID_Curso:34)
					[Alumnos_SintesisAnual:210]Curso:7:=$t_curso
					[Alumnos_SintesisAnual:210]NumeroNivel:6:=$l_nivel
					[Alumnos_SintesisAnual:210]ID_Curso:90:=$l_idCursoHistorico
					
				End if 
				
			End if 
			
			If ([Alumnos_SintesisAnual:210]NumeroNivel:6=0)
				LOG_RegisterEvt ("Registro síntesis anual dañado: Numero de nivel 0. Llave: "+[Alumnos_SintesisAnual:210]LlavePrincipal:5)
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			
	End case 
	If ([Alumnos_SintesisAnual:210]Año:2=<>gYear)
		If (Trigger event:C369#On Deleting Record Event:K3:3)
			$uuidAlumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]auto_uuid:72)
			Sync_RegistraModificacion (->[Alumnos_SintesisAnual:210]Auto_UUID:276;$uuidAlumno)
		End if 
		SN3_MarcarRegistros (SN3_DTi_Alumnos;-1;[Alumnos_SintesisAnual:210]ID_Alumno:4)
		SN3_MarcarRegistros (SN3_DTi_Conducta;SN3_SDTx_Condicionalidad)
		SN3_MarcarRegistros (SN3_DTi_Observaciones;SN3_SDTx_ProfesorJefe)
		SN3_MarcarRegistros (SN3_DTi_Conducta;-9)  //FALTAS POR ATRASOS  //MONO TICKET 209421
	End if 
End if 