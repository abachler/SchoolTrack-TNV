//%attributes = {}
  //TGR_AlumnosCastigos


C_LONGINT:C283($periodo;$old_Periodo)
C_BOOLEAN:C305($executeTrigger)
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)

If (Not:C34(<>vb_ImportHistoricos_STX))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[Alumnos_Castigos:9]ID:10:=SQ_SeqNumber (->[Alumnos_Castigos:9]ID:10)
			If ([Alumnos_Castigos:9]Año:5=0)
				[Alumnos_Castigos:9]Año:5:=<>gYear
			End if 
			
			$id_alu:=Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8)  //MONO 184433
			$l_nivelAlu:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alu;->[Alumnos:2]nivel_numero:29)  //MONO 184433
			If ([Alumnos_Castigos:9]Año:5=<>gYear) & ([Alumnos_Castigos:9]Nivel_Numero:11=$l_nivelAlu)  //MONO 184433
				$executeTrigger:=True:C214
				[Alumnos_Castigos:9]Alumno_Numero:8:=Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8)
			Else 
				$executeTrigger:=False:C215
				[Alumnos_Castigos:9]Alumno_Numero:8:=-Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8)
			End if 
			[Alumnos_Castigos:9]LlavePrimaria:1:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Castigos:9]Año:5)+"."+String:C10([Alumnos_Castigos:9]Nivel_Numero:11)+"."+String:C10(Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8))
			
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			
			$id_alu:=Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8)  //MONO 184433
			$l_nivelAlu:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$id_alu;->[Alumnos:2]nivel_numero:29)  //MONO 184433
			If ([Alumnos_Castigos:9]Año:5=<>gYear) & ([Alumnos_Castigos:9]Nivel_Numero:11=$l_nivelAlu)  //MONO 184433
				[Alumnos_Castigos:9]Alumno_Numero:8:=Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8)
			Else 
				[Alumnos_Castigos:9]Alumno_Numero:8:=-Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8)
			End if 
			[Alumnos_Castigos:9]LlavePrimaria:1:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_Castigos:9]Año:5)+"."+String:C10([Alumnos_Castigos:9]Nivel_Numero:11)+"."+String:C10(Abs:C99([Alumnos_Castigos:9]Alumno_Numero:8))
			
			If (([Alumnos_Castigos:9]Fecha:9#Old:C35([Alumnos_Castigos:9]Fecha:9)) | ([Alumnos_Castigos:9]Motivo:2#Old:C35([Alumnos_Castigos:9]Motivo:2)))
				$executeTrigger:=True:C214
			End if 
			
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			$executeTrigger:=True:C214
	End case 
	
	
	$crearTareaBatch:=False:C215
	
	If ((Not:C34(<>vb_AvoidTriggerExecution)) & ($executeTrigger))
		RELATE ONE:C42([Alumnos_Castigos:9]Alumno_Numero:8)
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		
		$devolverPeriodoMasCercano:=False:C215
		$old_Periodo:=PERIODOS_PeriodosActuales (Old:C35([Alumnos_Castigos:9]Fecha:9);$devolverPeriodoMasCercano)
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos_Castigos:9]Alumno_Numero:8)
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;True:C214)
		
		If (OK=1)
			  //si el atraso existía previamente se decrementan los totales en los registros de sintesis
			If ($old_Periodo>0)
				  //actualización del registro del período
				Case of 
					: ($old_Periodo=1)
						[Alumnos_SintesisAnual:210]P01_Castigos:110:=[Alumnos_SintesisAnual:210]P01_Castigos:110-1
					: ($old_Periodo=2)
						[Alumnos_SintesisAnual:210]P02_Castigos:139:=[Alumnos_SintesisAnual:210]P02_Castigos:139-1
					: ($old_Periodo=3)
						[Alumnos_SintesisAnual:210]P03_Castigos:168:=[Alumnos_SintesisAnual:210]P03_Castigos:168-1
					: ($old_Periodo=4)
						[Alumnos_SintesisAnual:210]P04_Castigos:197:=[Alumnos_SintesisAnual:210]P04_Castigos:197-1
					: ($old_Periodo=5)
						[Alumnos_SintesisAnual:210]P05_Castigos:226:=[Alumnos_SintesisAnual:210]P05_Castigos:226-1
				End case 
				SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			End if 
			
			
			
			If ((Trigger event:C369=On Saving New Record Event:K3:1) | (Trigger event:C369=On Saving Existing Record Event:K3:2))
				  //se incrementan los valores de los totales en los registros de sintesis
				$devolverPeriodoMasCercano:=False:C215
				$periodo:=PERIODOS_PeriodosActuales ([Alumnos_Castigos:9]Fecha:9;$devolverPeriodoMasCercano)
				If ($periodo>0)
					Case of 
						: ($periodo=1)
							[Alumnos_SintesisAnual:210]P01_Castigos:110:=[Alumnos_SintesisAnual:210]P01_Castigos:110+1
						: ($periodo=2)
							[Alumnos_SintesisAnual:210]P02_Castigos:139:=[Alumnos_SintesisAnual:210]P02_Castigos:139+1
						: ($periodo=3)
							[Alumnos_SintesisAnual:210]P03_Castigos:168:=[Alumnos_SintesisAnual:210]P03_Castigos:168+1
						: ($periodo=4)
							[Alumnos_SintesisAnual:210]P04_Castigos:197:=[Alumnos_SintesisAnual:210]P04_Castigos:197+1
						: ($periodo=5)
							[Alumnos_SintesisAnual:210]P05_Castigos:226:=[Alumnos_SintesisAnual:210]P05_Castigos:226+1
					End case 
				End if 
			End if 
			
			
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
			
		Else 
			$0:=BM_CreateRequest ("Cuenta Castigos";String:C10([Alumnos_Castigos:9]Alumno_Numero:8);String:C10([Alumnos_Castigos:9]Alumno_Numero:8))
		End if 
		
	End if 
	SN3_MarcarRegistros (SN3_DTi_Conducta;SN3_SDTx_Castigos)
	  //LIMPIEZA
End if 