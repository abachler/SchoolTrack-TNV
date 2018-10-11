//%attributes = {}
  //TGR_AlumnosAnotaciones

C_LONGINT:C283($periodo;$old_Periodo)
C_POINTER:C301($fieldPointer;$oldFieldPointer;$oldPuntosFieldPointer;$puntosFieldPointer)
C_BOOLEAN:C305($executeTrigger)
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)

If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			
			[Alumnos_Anotaciones:11]ID:12:=SQ_SeqNumber (->[Alumnos_Anotaciones:11]ID:12)
			If ([Alumnos_Anotaciones:11]Año:11=0)
				[Alumnos_Anotaciones:11]Año:11:=<>gYear
			End if 
			
			$id_alu:=Abs:C99([Alumnos_Anotaciones:11]Alumno_Numero:6)  //MONO 184433
			$l_nivelAlu:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alu;->[Alumnos:2]nivel_numero:29)  //MONO 184433
			
			If (([Alumnos_Anotaciones:11]Año:11=<>gYear) & ([Alumnos_Anotaciones:11]Nivel_Numero:13=$l_nivelAlu))  //MONO 184433
				$executeTrigger:=True:C214
				[Alumnos_Anotaciones:11]Alumno_Numero:6:=Abs:C99([Alumnos_Anotaciones:11]Alumno_Numero:6)
			Else 
				$executeTrigger:=False:C215
				[Alumnos_Anotaciones:11]Alumno_Numero:6:=-Abs:C99([Alumnos_Anotaciones:11]Alumno_Numero:6)
			End if 
			[Alumnos_Anotaciones:11]LlavePrimaria:14:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Anotaciones:11]Año:11)+"."+String:C10([Alumnos_Anotaciones:11]Nivel_Numero:13)+"."+String:C10(Abs:C99([Alumnos_Anotaciones:11]Alumno_Numero:6))
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			$id_alu:=Abs:C99([Alumnos_Anotaciones:11]Alumno_Numero:6)  //MONO 184433
			$l_nivelAlu:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alu;->[Alumnos:2]nivel_numero:29)  //MONO 184433
			
			If (([Alumnos_Anotaciones:11]Año:11=<>gYear) & ([Alumnos_Anotaciones:11]Nivel_Numero:13=$l_nivelAlu))  //MONO 184433
				[Alumnos_Anotaciones:11]Alumno_Numero:6:=Abs:C99([Alumnos_Anotaciones:11]Alumno_Numero:6)
			Else 
				[Alumnos_Anotaciones:11]Alumno_Numero:6:=-Abs:C99([Alumnos_Anotaciones:11]Alumno_Numero:6)
			End if 
			[Alumnos_Anotaciones:11]LlavePrimaria:14:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Anotaciones:11]Año:11)+"."+String:C10([Alumnos_Anotaciones:11]Nivel_Numero:13)+"."+String:C10(Abs:C99([Alumnos_Anotaciones:11]Alumno_Numero:6))
			If (([Alumnos_Anotaciones:11]Puntos:9#Old:C35([Alumnos_Anotaciones:11]Puntos:9)) | ([Alumnos_Anotaciones:11]Fecha:1#Old:C35([Alumnos_Anotaciones:11]Fecha:1)) | ([Alumnos_Anotaciones:11]Motivo:3#Old:C35([Alumnos_Anotaciones:11]Motivo:3)) | ([Alumnos_Anotaciones:11]Categoria:8#Old:C35([Alumnos_Anotaciones:11]Categoria:8)) | ([Alumnos_Anotaciones:11]Signo:7#Old:C35([Alumnos_Anotaciones:11]Signo:7)))
				$executeTrigger:=True:C214
			End if 
			
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			$executeTrigger:=True:C214
	End case 
	
	
	
	
	
	$crearTareaBatch:=False:C215
	
	If ((Not:C34(<>vb_AvoidTriggerExecution)) & ($executeTrigger))
		RELATE ONE:C42([Alumnos_Anotaciones:11]Alumno_Numero:6)
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		
		$devolverPeriodoMasCercano:=False:C215
		$old_Periodo:=PERIODOS_PeriodosActuales (Old:C35([Alumnos_Anotaciones:11]Fecha:1);$devolverPeriodoMasCercano)
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos_Anotaciones:11]Alumno_Numero:6)
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
		
		If (OK=1)
			  //PROCESAMIENTO DE LOS VALORES EXISTENTES ANTES DE LA MODIFICACION
			  //si la anotación existía previamente se decrementan los totales en los registros de sintesis
			If ($old_Periodo>0)
				Case of 
					: (Old:C35([Alumnos_Anotaciones:11]Signo:7)="-")
						Case of 
							: ($old_Periodo=1)
								[Alumnos_SintesisAnual:210]P01_Anotaciones_Negativas:103:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Negativas:103-1
								[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Negativo:105:=[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Negativo:105-Old:C35([Alumnos_Anotaciones:11]Puntos:9)
							: ($old_Periodo=2)
								[Alumnos_SintesisAnual:210]P02_Anotaciones_Negativas:132:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Negativas:132-1
								[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Negativo:134:=[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Negativo:134-Old:C35([Alumnos_Anotaciones:11]Puntos:9)
							: ($old_Periodo=3)
								[Alumnos_SintesisAnual:210]P03_Anotaciones_Negativas:161:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Negativas:161-1
								[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Negativo:163:=[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Negativo:134-Old:C35([Alumnos_Anotaciones:11]Puntos:9)
							: ($old_Periodo=4)
								[Alumnos_SintesisAnual:210]P04_Anotaciones_Negativas:190:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Negativas:190-1
								[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Negativo:192:=[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Negativo:192-Old:C35([Alumnos_Anotaciones:11]Puntos:9)
							: ($old_Periodo=5)
								[Alumnos_SintesisAnual:210]P05_Anotaciones_Negativas:219:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Negativas:219-1
								[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Negativo:221:=[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Negativo:221-Old:C35([Alumnos_Anotaciones:11]Puntos:9)
						End case 
						
					: (Old:C35([Alumnos_Anotaciones:11]Signo:7)="=")
						Case of 
							: ($old_Periodo=1)
								[Alumnos_SintesisAnual:210]P01_Anotaciones_Neutras:102:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Neutras:102-1
							: ($old_Periodo=2)
								[Alumnos_SintesisAnual:210]P02_Anotaciones_Neutras:131:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Neutras:131-1
							: ($old_Periodo=3)
								[Alumnos_SintesisAnual:210]P03_Anotaciones_Neutras:160:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Neutras:160-1
							: ($old_Periodo=4)
								[Alumnos_SintesisAnual:210]P04_Anotaciones_Neutras:189:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Neutras:189-1
							: ($old_Periodo=5)
								[Alumnos_SintesisAnual:210]P05_Anotaciones_Neutras:218:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Neutras:218-1
						End case 
						
						
					: (Old:C35([Alumnos_Anotaciones:11]Signo:7)="+")
						Case of 
							: ($old_Periodo=1)
								[Alumnos_SintesisAnual:210]P01_Anotaciones_Positivas:101:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Positivas:101-1
								[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Positivo:104:=[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Positivo:104-Old:C35([Alumnos_Anotaciones:11]Puntos:9)
							: ($old_Periodo=2)
								[Alumnos_SintesisAnual:210]P02_Anotaciones_Positivas:130:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Positivas:130-1
								[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Positivo:133:=[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Positivo:133-Old:C35([Alumnos_Anotaciones:11]Puntos:9)
							: ($old_Periodo=3)
								[Alumnos_SintesisAnual:210]P03_Anotaciones_Positivas:159:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Positivas:159-1
								[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Positivo:162:=[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Positivo:162-Old:C35([Alumnos_Anotaciones:11]Puntos:9)
							: ($old_Periodo=4)
								[Alumnos_SintesisAnual:210]P04_Anotaciones_Positivas:188:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Positivas:188-1
								[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Positivo:191:=[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Positivo:191-Old:C35([Alumnos_Anotaciones:11]Puntos:9)
							: ($old_Periodo=5)
								[Alumnos_SintesisAnual:210]P05_Anotaciones_Positivas:217:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Positivas:217-1
								[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Positivo:220:=[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Positivo:220-Old:C35([Alumnos_Anotaciones:11]Puntos:9)
						End case 
				End case 
			End if 
			
			
			
			If ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
				  //PROCESAMIENTO DE LOS VALORES DEL REGISTRO DESPUES DE LA MODIFICACION
				  //se incrementan los valores de los totales en los registros de sintesis
				$devolverPeriodoMasCercano:=False:C215
				$periodo:=PERIODOS_PeriodosActuales ([Alumnos_Anotaciones:11]Fecha:1;$devolverPeriodoMasCercano)
				
				If ($periodo>0)
					Case of 
						: ([Alumnos_Anotaciones:11]Signo:7="-")
							Case of 
								: ($periodo=1)
									[Alumnos_SintesisAnual:210]P01_Anotaciones_Negativas:103:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Negativas:103+1
									[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Negativo:105:=[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Negativo:105+[Alumnos_Anotaciones:11]Puntos:9
								: ($periodo=2)
									[Alumnos_SintesisAnual:210]P02_Anotaciones_Negativas:132:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Negativas:132+1
									[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Negativo:134:=[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Negativo:134+[Alumnos_Anotaciones:11]Puntos:9
								: ($periodo=3)
									[Alumnos_SintesisAnual:210]P03_Anotaciones_Negativas:161:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Negativas:161+1
									[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Negativo:163:=[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Negativo:163+[Alumnos_Anotaciones:11]Puntos:9
								: ($periodo=4)
									[Alumnos_SintesisAnual:210]P04_Anotaciones_Negativas:190:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Negativas:190+1
									[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Negativo:192:=[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Negativo:192+[Alumnos_Anotaciones:11]Puntos:9
								: ($periodo=5)
									[Alumnos_SintesisAnual:210]P05_Anotaciones_Negativas:219:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Negativas:219+1
									[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Negativo:221:=[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Negativo:221+[Alumnos_Anotaciones:11]Puntos:9
							End case 
							
						: ([Alumnos_Anotaciones:11]Signo:7="=")
							Case of 
								: ($periodo=1)
									[Alumnos_SintesisAnual:210]P01_Anotaciones_Neutras:102:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Neutras:102+1
								: ($periodo=2)
									[Alumnos_SintesisAnual:210]P02_Anotaciones_Neutras:131:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Neutras:131+1
								: ($periodo=3)
									[Alumnos_SintesisAnual:210]P03_Anotaciones_Neutras:160:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Neutras:160+1
								: ($periodo=4)
									[Alumnos_SintesisAnual:210]P04_Anotaciones_Neutras:189:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Neutras:189+1
								: ($periodo=5)
									[Alumnos_SintesisAnual:210]P05_Anotaciones_Neutras:218:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Neutras:218+1
							End case 
							
							
						: ([Alumnos_Anotaciones:11]Signo:7="+")
							Case of 
								: ($periodo=1)
									[Alumnos_SintesisAnual:210]P01_Anotaciones_Positivas:101:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Positivas:101+1
									[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Positivo:104:=[Alumnos_SintesisAnual:210]P01_PuntajeConductual_Positivo:104+[Alumnos_Anotaciones:11]Puntos:9
								: ($periodo=2)
									[Alumnos_SintesisAnual:210]P02_Anotaciones_Positivas:130:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Positivas:130+1
									[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Positivo:133:=[Alumnos_SintesisAnual:210]P02_PuntajeConductual_Positivo:133+[Alumnos_Anotaciones:11]Puntos:9
								: ($periodo=3)
									[Alumnos_SintesisAnual:210]P03_Anotaciones_Positivas:159:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Positivas:159+1
									[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Positivo:162:=[Alumnos_SintesisAnual:210]P03_PuntajeConductual_Positivo:162+[Alumnos_Anotaciones:11]Puntos:9
								: ($periodo=4)
									[Alumnos_SintesisAnual:210]P04_Anotaciones_Positivas:188:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Positivas:188+1
									[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Positivo:191:=[Alumnos_SintesisAnual:210]P04_PuntajeConductual_Positivo:191+[Alumnos_Anotaciones:11]Puntos:9
								: ($periodo=5)
									[Alumnos_SintesisAnual:210]P05_Anotaciones_Positivas:217:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Positivas:217+1
									[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Positivo:220:=[Alumnos_SintesisAnual:210]P05_PuntajeConductual_Positivo:220+[Alumnos_Anotaciones:11]Puntos:9
							End case 
					End case 
					
				End if 
			End if 
			
			[Alumnos_SintesisAnual:210]PuntajeConductual_Balance:39:=[Alumnos_SintesisAnual:210]PuntajeConductual_Positivo:37-[Alumnos_SintesisAnual:210]PuntajeConductual_Negativo:38
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
			
		Else 
			$0:=BM_CreateRequest ("Cuenta anotaciones";String:C10([Alumnos_Anotaciones:11]Alumno_Numero:6);String:C10([Alumnos_Anotaciones:11]Alumno_Numero:6))
		End if 
		
		
		
	End if 
	
	SN3_MarcarRegistros (SN3_DTi_Conducta;SN3_SDTx_Anotaciones)
End if 