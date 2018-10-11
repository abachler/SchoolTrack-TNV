//%attributes = {}

  //trace 
Case of 
	: (lastCdcta=5)
		$textPtr:=->atSTRal_NombreProfesorAnot
		$idProfPtr:=->alSTRal_NoProfesorAnot
	: (lastCdcta=7)
		$textPtr:=-><>aCdtaText3
		$idProfPtr:=-><>aCdtaLong1
	: (lastCdcta=8)
		$textPtr:=-><>aCdtaText3
		$idProfPtr:=-><>aCdtaLong1
End case 

If ($TextPtr->{vrow}#"")
	READ ONLY:C145([Profesores:4])
	QUERY:C277([Profesores:4];[Profesores:4]Apellido_paterno:3=($textPtr->{vrow}+"@");*)
	QUERY:C277([Profesores:4]; & ;[Profesores:4]Inactivo:62=False:C215)
	Case of 
		: (Records in selection:C76([Profesores:4])=0)
			CD_Dlog (0;__ ("Profesor inexistente."))
			$textPtr->{vrow}:=""
			$IdProfPtr->{vrow}:=0
			AL_GotoCell (xALP_ConductaAlumnos;vCol;vrow)
		: (Records in selection:C76([Profesores:4])=1)
			$textPtr->{vrow}:=[Profesores:4]Nombre_comun:21
			$IdProfPtr->{vrow}:=[Profesores:4]Numero:1
			
		: (Records in selection:C76([Profesores:4])>1)
			SELECTION TO ARRAY:C260([Profesores:4]Nombre_comun:21;<>aGenNme;[Profesores:4]Numero:1;<>aGenId)
			ARRAY POINTER:C280(<>aChoicePtrs;2)
			<>aChoicePtrs{1}:=-><>aGenNme
			<>aChoicePtrs{2}:=-><>aGenID
			TBL_ShowChoiceList (1)
			If ((ok=1) & (choiceIdx>0))
				$textPtr->{vrow}:=<>aChoicePtrs{1}->{choiceIdx}
				$idProfPtr->{vrow}:=<>aChoicePtrs{2}->{choiceIdx}
				AL_UpdateArrays (xALP_ConductaAlumnos;-1)
				AL_GotoCell (xALP_ConductaAlumnos;vCol+1;vrow)
				AL_SetCellHigh (xALP_ConductaAlumnos;1;80)
			Else 
				$textPtr->{vrow}:=""
				$idProfPtr->{vrow}:=0
				AL_UpdateArrays (xALP_ConductaAlumnos;-1)
				AL_GotoCell (xALP_ConductaAlumnos;vCol;vrow)
				AL_SetCellHigh (xALP_ConductaAlumnos;1;1)
			End if 
	End case 
	Case of 
		: (lastCdcta=5)
			If ((adSTRal_FechaAnotacion{vRow}#!00-00-00!) & (atSTRal_MotivoAnotacion{vRow}#"") & (alSTRal_NoProfesorAnot{vRow}#0))
				READ WRITE:C146([Alumnos_Anotaciones:11])
				GOTO RECORD:C242([Alumnos_Anotaciones:11];<>aCdtaRecNo{vrow})
				[Alumnos_Anotaciones:11]Fecha:1:=adSTRal_FechaAnotacion{vRow}
				[Alumnos_Anotaciones:11]Motivo:3:=atSTRal_MotivoAnotacion{vRow}
				[Alumnos_Anotaciones:11]Observaciones:4:=atSTRal_NotasAnotacion{vRow}
				[Alumnos_Anotaciones:11]Profesor_Numero:5:=alSTRal_NoProfesorAnot{vRow}
				SAVE RECORD:C53([Alumnos_Anotaciones:11])
				UNLOAD RECORD:C212([Alumnos_Anotaciones:11])
				READ ONLY:C145([Alumnos_Anotaciones:11])
			End if 
		: (lastCdcta=7)
			If ((<>aCdtaDate{vRow}#!00-00-00!) & (<>aCdtaText1{vRow}#"") & (<>aCdtaLong1{vRow}#0) & (<>aCdtaNum1{vRow}>0))
				READ WRITE:C146([Alumnos_Castigos:9])
				GOTO RECORD:C242([Alumnos_Castigos:9];<>aCdtaRecNo{vrow})
				[Alumnos_Castigos:9]Fecha:9:=<>aCdtaDate{vRow}
				[Alumnos_Castigos:9]Motivo:2:=<>aCdtaText1{vRow}
				[Alumnos_Castigos:9]Observaciones:3:=<>aCdtaText2{vRow}
				[Alumnos_Castigos:9]Profesor_Numero:6:=<>aCdtaLong1{vRow}
				[Alumnos_Castigos:9]Horas_de_castigo:7:=<>aCdtaNum1{vRow}
				[Alumnos_Castigos:9]Castigo_cumplido:4:=<>aCdtaBool{vRow}
				SAVE RECORD:C53([Alumnos_Castigos:9])
				UNLOAD RECORD:C212([Alumnos_Castigos:9])
				READ ONLY:C145([Alumnos_Castigos:9])
			End if 
		: (lastCdcta=8)
			TRACE:C157
			If ((<>aCdtaDate{vRow}#!00-00-00!) & (<>aCdtaDate2{vRow}#!00-00-00!) & (<>aCdtaText1{vRow}#"") & (<>aCdtaLong1{vRow}#0))
				READ WRITE:C146([Alumnos_Suspensiones:12])
				GOTO RECORD:C242([Alumnos_Suspensiones:12];<>aCdtaRecNo{vrow})
				[Alumnos_Suspensiones:12]Desde:5:=<>aCdtaDate{vRow}
				[Alumnos_Suspensiones:12]Hasta:6:=<>aCdtaDate2{vRow}
				[Alumnos_Suspensiones:12]Motivo:2:=<>aCdtaText1{vRow}
				[Alumnos_Suspensiones:12]Observaciones:8:=<>aCdtaText2{vRow}
				[Alumnos_Suspensiones:12]Profesor_Numero:4:=<>aCdtaLong1{vRow}
				[Alumnos_Suspensiones:12]Días_de_suspensión:3:=[Alumnos_Suspensiones:12]Hasta:6-[Alumnos_Suspensiones:12]Desde:5+1
				SAVE RECORD:C53([Alumnos_Suspensiones:12])
				UNLOAD RECORD:C212([Alumnos_Suspensiones:12])
				READ ONLY:C145([Alumnos_Suspensiones:12])
			End if 
	End case 
End if 