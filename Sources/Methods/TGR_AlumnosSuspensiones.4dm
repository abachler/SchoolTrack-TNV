//%attributes = {}
  //TGR_AlumnosSuspensiones


C_LONGINT:C283($periodo;$old_Periodo)
C_BOOLEAN:C305($executeTrigger)
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)

If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[Alumnos_Suspensiones:12]ID:9:=SQ_SeqNumber (->[Alumnos_Suspensiones:12]ID:9)
			If ([Alumnos_Suspensiones:12]Año:1=0)
				[Alumnos_Suspensiones:12]Año:1:=<>gYear
			End if 
			
			$id_alu:=Abs:C99([Alumnos_Suspensiones:12]Alumno_Numero:7)  //MONO 184433
			$l_nivelAlu:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alu;->[Alumnos:2]nivel_numero:29)  //MONO 184433
			
			If (([Alumnos_Suspensiones:12]Año:1=<>gYear) & ([Alumnos_Suspensiones:12]Nivel_Numero:10=$l_nivelAlu))  //MONO 184433
				$executeTrigger:=True:C214
				[Alumnos_Suspensiones:12]Alumno_Numero:7:=Abs:C99([Alumnos_Suspensiones:12]Alumno_Numero:7)
			Else 
				$executeTrigger:=False:C215
				[Alumnos_Suspensiones:12]Alumno_Numero:7:=-Abs:C99([Alumnos_Suspensiones:12]Alumno_Numero:7)
			End if 
			[Alumnos_Suspensiones:12]LlavePrimaria:11:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Suspensiones:12]Año:1)+"."+String:C10([Alumnos_Suspensiones:12]Nivel_Numero:10)+"."+String:C10(Abs:C99([Alumnos_Suspensiones:12]Alumno_Numero:7))
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
			$id_alu:=Abs:C99([Alumnos_Suspensiones:12]Alumno_Numero:7)  //MONO 184433
			$l_nivelAlu:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alu;->[Alumnos:2]nivel_numero:29)  //MONO 184433
			If (([Alumnos_Suspensiones:12]Año:1=<>gYear) & ([Alumnos_Suspensiones:12]Nivel_Numero:10=$l_nivelAlu))  //MONO 184433
				[Alumnos_Suspensiones:12]Alumno_Numero:7:=Abs:C99([Alumnos_Suspensiones:12]Alumno_Numero:7)
			Else 
				[Alumnos_Suspensiones:12]Alumno_Numero:7:=-Abs:C99([Alumnos_Suspensiones:12]Alumno_Numero:7)
			End if 
			[Alumnos_Suspensiones:12]LlavePrimaria:11:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Castigos:9]Año:5)+"."+String:C10([Alumnos_Castigos:9]Nivel_Numero:11)+"."+String:C10(Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8))
			If (([Alumnos_Suspensiones:12]Desde:5#Old:C35([Alumnos_Suspensiones:12]Desde:5)) | ([Alumnos_Suspensiones:12]Motivo:2#Old:C35([Alumnos_Suspensiones:12]Motivo:2)))
				$executeTrigger:=True:C214
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			$executeTrigger:=True:C214
	End case 
	
	
	$crearTareaBatch:=False:C215
	
	If ((Not:C34(<>vb_AvoidTriggerExecution)) & ($executeTrigger))
		RELATE ONE:C42([Alumnos_Suspensiones:12]Alumno_Numero:7)
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		
		$devolverPeriodoMasCercano:=False:C215
		$old_Periodo:=PERIODOS_PeriodosActuales (Old:C35([Alumnos_Suspensiones:12]Desde:5);$devolverPeriodoMasCercano)
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos_Suspensiones:12]Alumno_Numero:7)
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
		
		If (OK=1)
			  //si el atraso existía previamente se decrementan los totales en los registros de sintesis
			If ($old_Periodo>0)
				  //actualización del registro del período
				Case of 
					: ($old_Periodo=1)
						[Alumnos_SintesisAnual:210]P01_Suspensiones:111:=[Alumnos_SintesisAnual:210]P01_Suspensiones:111-1
					: ($old_Periodo=2)
						[Alumnos_SintesisAnual:210]P02_Suspensiones:140:=[Alumnos_SintesisAnual:210]P02_Suspensiones:140-1
					: ($old_Periodo=3)
						[Alumnos_SintesisAnual:210]P03_Suspensiones:169:=[Alumnos_SintesisAnual:210]P03_Suspensiones:169-1
					: ($old_Periodo=4)
						[Alumnos_SintesisAnual:210]P04_Suspensiones:198:=[Alumnos_SintesisAnual:210]P04_Suspensiones:198-1
					: ($old_Periodo=5)
						[Alumnos_SintesisAnual:210]P05_Suspensiones:227:=[Alumnos_SintesisAnual:210]P05_Suspensiones:227-1
				End case 
				SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			End if 
			
			
			
			If ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
				  //se incrementan los valores de los totales en los registros de sintesis
				$devolverPeriodoMasCercano:=False:C215
				$periodo:=PERIODOS_PeriodosActuales ([Alumnos_Suspensiones:12]Desde:5;$devolverPeriodoMasCercano)
				If ($periodo>0)
					Case of 
						: ($periodo=1)
							[Alumnos_SintesisAnual:210]P01_Suspensiones:111:=[Alumnos_SintesisAnual:210]P01_Suspensiones:111+1
						: ($periodo=2)
							[Alumnos_SintesisAnual:210]P02_Suspensiones:140:=[Alumnos_SintesisAnual:210]P02_Suspensiones:140+1
						: ($periodo=3)
							[Alumnos_SintesisAnual:210]P03_Suspensiones:169:=[Alumnos_SintesisAnual:210]P03_Suspensiones:169+1
						: ($periodo=4)
							[Alumnos_SintesisAnual:210]P04_Suspensiones:198:=[Alumnos_SintesisAnual:210]P04_Suspensiones:198+1
						: ($periodo=5)
							[Alumnos_SintesisAnual:210]P05_Suspensiones:227:=[Alumnos_SintesisAnual:210]P05_Suspensiones:227+1
					End case 
				End if 
			End if 
			
			
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
			
		Else 
			$0:=BM_CreateRequest ("Cuenta suspensiones";String:C10([Alumnos_Suspensiones:12]Alumno_Numero:7);String:C10([Alumnos_Suspensiones:12]Alumno_Numero:7))
		End if 
		
	End if 
	SN3_MarcarRegistros (SN3_DTi_Conducta;SN3_SDTx_Suspensiones)
	
	  //LIMPIEZA
End if 
