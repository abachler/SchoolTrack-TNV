//%attributes = {}
  //TGR_AlumnosAtrasos

C_LONGINT:C283($periodo;$old_Periodo)
C_BOOLEAN:C305($executeTrigger)
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)

If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[Alumnos_Atrasos:55]ID:7:=SQ_SeqNumber (->[Alumnos_Atrasos:55]ID:7)
			If ([Alumnos_Atrasos:55]Año:6=0)
				[Alumnos_Atrasos:55]Año:6:=<>gYear
			End if 
			
			$id_alu:=Abs:C99([Alumnos_Atrasos:55]Alumno_numero:1)  //MONO 184433
			$l_nivelAlu:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alu;->[Alumnos:2]nivel_numero:29)  //MONO 184433
			If (([Alumnos_Atrasos:55]Año:6=<>gYear) & ([Alumnos_Atrasos:55]Nivel_Numero:8=$l_nivelAlu))  //MONO 184433
				$executeTrigger:=True:C214
				[Alumnos_Atrasos:55]Alumno_numero:1:=Abs:C99([Alumnos_Atrasos:55]Alumno_numero:1)
			Else 
				$executeTrigger:=False:C215
				[Alumnos_Atrasos:55]Alumno_numero:1:=-Abs:C99([Alumnos_Atrasos:55]Alumno_numero:1)
			End if 
			[Alumnos_Atrasos:55]LlavePrimaria:9:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Atrasos:55]Año:6)+"."+String:C10([Alumnos_Atrasos:55]Nivel_Numero:8)+"."+String:C10(Abs:C99([Alumnos_Atrasos:55]Alumno_numero:1))
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
			$id_alu:=Abs:C99([Alumnos_Atrasos:55]Alumno_numero:1)  //MONO 184433
			$l_nivelAlu:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alu;->[Alumnos:2]nivel_numero:29)  //MONO 184433
			If (([Alumnos_Atrasos:55]Año:6=<>gYear) & ([Alumnos_Atrasos:55]Nivel_Numero:8=$l_nivelAlu))  //MONO 184433
				[Alumnos_Atrasos:55]Alumno_numero:1:=Abs:C99([Alumnos_Atrasos:55]Alumno_numero:1)
			Else 
				[Alumnos_Atrasos:55]Alumno_numero:1:=-Abs:C99([Alumnos_Atrasos:55]Alumno_numero:1)
			End if 
			[Alumnos_Atrasos:55]LlavePrimaria:9:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Atrasos:55]Año:6)+"."+String:C10([Alumnos_Atrasos:55]Nivel_Numero:8)+"."+String:C10(Abs:C99([Alumnos_Atrasos:55]Alumno_numero:1))
			
			If (([Alumnos_Atrasos:55]Fecha:2#Old:C35([Alumnos_Atrasos:55]Fecha:2)) | ([Alumnos_Atrasos:55]MinutosAtraso:5#Old:C35([Alumnos_Atrasos:55]MinutosAtraso:5)) | ([Alumnos_Atrasos:55]EsAtrasoInterSesiones:4#Old:C35([Alumnos_Atrasos:55]EsAtrasoInterSesiones:4)))
				$executeTrigger:=True:C214
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			$executeTrigger:=True:C214
	End case 
	
	
	
	If ((Not:C34(<>vb_AvoidTriggerExecution)) & ($executeTrigger))
		RELATE ONE:C42([Alumnos_Atrasos:55]Alumno_numero:1)
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		
		$devolverPeriodoMasCercano:=False:C215
		$old_Periodo:=PERIODOS_PeriodosActuales (Old:C35([Alumnos_Atrasos:55]Fecha:2);$devolverPeriodoMasCercano)
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos_Atrasos:55]Alumno_numero:1)
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
		
		If (OK=1)
			
			  //PROCESAMIENTO DE LOS VALORES EXISTENTES ANTES DE LA MODIFICACION
			  //si el atraso existía previamente se decrementan los totales en los registros de sintesis
			If ($old_Periodo>0)
				If (Old:C35([Alumnos_Atrasos:55]EsAtrasoInterSesiones:4))
					Case of 
						: ($old_Periodo=1)
							[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108:=[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108-1
							[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoSesiones:113:=[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoSesiones:113-AL_RetornaValorFaltaPorRetardo (Old:C35([Alumnos_Atrasos:55]MinutosAtraso:5))
						: ($old_Periodo=2)
							[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137:=[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137-1
							[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoSesiones:142:=[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoSesiones:142-AL_RetornaValorFaltaPorRetardo (Old:C35([Alumnos_Atrasos:55]MinutosAtraso:5))
						: ($old_Periodo=3)
							[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166:=[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166-1
							[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoSesiones:171:=[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoSesiones:171-AL_RetornaValorFaltaPorRetardo (Old:C35([Alumnos_Atrasos:55]MinutosAtraso:5))
						: ($old_Periodo=4)
							[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195:=[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195-1
							[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoSesiones:200:=[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoSesiones:200-AL_RetornaValorFaltaPorRetardo (Old:C35([Alumnos_Atrasos:55]MinutosAtraso:5))
						: ($old_Periodo=5)
							[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224:=[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224-1
							[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoSesiones:229:=[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoSesiones:229-AL_RetornaValorFaltaPorRetardo (Old:C35([Alumnos_Atrasos:55]MinutosAtraso:5))
					End case 
				Else 
					Case of 
						: ($old_Periodo=1)
							[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107:=[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107-1
							[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112:=[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112-AL_RetornaValorFaltaPorRetardo (Old:C35([Alumnos_Atrasos:55]MinutosAtraso:5))
						: ($old_Periodo=2)
							[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136:=[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136-1
							[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141:=[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141-AL_RetornaValorFaltaPorRetardo (Old:C35([Alumnos_Atrasos:55]MinutosAtraso:5))
						: ($old_Periodo=3)
							[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165:=[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165-1
							[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170:=[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170-AL_RetornaValorFaltaPorRetardo (Old:C35([Alumnos_Atrasos:55]MinutosAtraso:5))
						: ($old_Periodo=4)
							[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194:=[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194-1
							[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoJornada:199:=[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoJornada:199-AL_RetornaValorFaltaPorRetardo (Old:C35([Alumnos_Atrasos:55]MinutosAtraso:5))
						: ($old_Periodo=5)
							[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223:=[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223-1
							[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoJornada:228:=[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoJornada:228-AL_RetornaValorFaltaPorRetardo (Old:C35([Alumnos_Atrasos:55]MinutosAtraso:5))
					End case 
				End if 
				[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51:=[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51-Old:C35([Alumnos_Atrasos:55]MinutosAtraso:5)
			End if 
			
			
			
			If ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
				  //PROCESAMIENTO DE LOS VALORES EXISTENTES DESPUES DE LA MODIFICACION
				  //se incrementan los valores de los totales en los registros de sintesis
				$devolverPeriodoMasCercano:=False:C215
				$periodo:=PERIODOS_PeriodosActuales ([Alumnos_Atrasos:55]Fecha:2;$devolverPeriodoMasCercano)
				If ($periodo>0)
					If ([Alumnos_Atrasos:55]EsAtrasoInterSesiones:4)
						Case of 
							: ($periodo=1)
								[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108:=[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108+1
								[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoSesiones:113:=[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoSesiones:113+AL_RetornaValorFaltaPorRetardo ([Alumnos_Atrasos:55]MinutosAtraso:5)
							: ($periodo=2)
								[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137:=[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137+1
								[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoSesiones:142:=[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoSesiones:142+AL_RetornaValorFaltaPorRetardo ([Alumnos_Atrasos:55]MinutosAtraso:5)
							: ($periodo=3)
								[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166:=[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166+1
								[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoSesiones:171:=[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoSesiones:171+AL_RetornaValorFaltaPorRetardo ([Alumnos_Atrasos:55]MinutosAtraso:5)
							: ($periodo=4)
								[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195:=[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195+1
								[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoSesiones:200:=[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoSesiones:200+AL_RetornaValorFaltaPorRetardo ([Alumnos_Atrasos:55]MinutosAtraso:5)
							: ($periodo=5)
								[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224:=[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224+1
								[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoSesiones:229:=[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoSesiones:229+AL_RetornaValorFaltaPorRetardo ([Alumnos_Atrasos:55]MinutosAtraso:5)
						End case 
					Else 
						Case of 
							: ($periodo=1)
								[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107:=[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107+1
								[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112:=[Alumnos_SintesisAnual:210]P01_Faltas_x_RetardoJornada:112+AL_RetornaValorFaltaPorRetardo ([Alumnos_Atrasos:55]MinutosAtraso:5)
							: ($periodo=2)
								[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136:=[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136+1
								[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141:=[Alumnos_SintesisAnual:210]P02_Faltas_x_RetardoJornada:141+AL_RetornaValorFaltaPorRetardo ([Alumnos_Atrasos:55]MinutosAtraso:5)
							: ($periodo=3)
								[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165:=[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165+1
								[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170:=[Alumnos_SintesisAnual:210]P03_Faltas_x_RetardoJornada:170+AL_RetornaValorFaltaPorRetardo ([Alumnos_Atrasos:55]MinutosAtraso:5)
							: ($periodo=4)
								[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194:=[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194+1
								[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoJornada:199:=[Alumnos_SintesisAnual:210]P04_Faltas_x_RetardoJornada:199+AL_RetornaValorFaltaPorRetardo ([Alumnos_Atrasos:55]MinutosAtraso:5)
							: ($periodo=5)
								[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223:=[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223+1
								[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoJornada:228:=[Alumnos_SintesisAnual:210]P05_Faltas_x_RetardoJornada:228+AL_RetornaValorFaltaPorRetardo ([Alumnos_Atrasos:55]MinutosAtraso:5)
						End case 
					End if 
					[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51:=[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51+[Alumnos_Atrasos:55]MinutosAtraso:5
				End if 
			End if 
			
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
			
		Else 
			If ([Alumnos_Atrasos:55]Alumno_numero:1>0)
				$0:=BM_CreateRequest ("Cuenta atrasos";String:C10([Alumnos_Atrasos:55]Alumno_numero:1);String:C10([Alumnos_Atrasos:55]Alumno_numero:1))
			End if 
		End if 
		
		SN3_MarcarRegistros (SN3_DTi_Conducta;SN3_SDTx_Atrasos)
	End if 
End if 