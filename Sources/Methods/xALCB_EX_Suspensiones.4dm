//%attributes = {}
  //xALCB_EX_Suspensiones

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283(vCol;vRow)


If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	
	If (AL_GetCellMod (xALP_ConductaAlumnos)=1)
		AL_GetCurrCell (xALP_ConductaAlumnos;vCol;vRow)
		Case of 
			: ((vCol=1) & (<>aCdtadate{vRow}#<>aCdtadate{0}))
				<>aCdtadate{vRow}:=AL_isNotAbsent (<>aCdtadate{vRow})
				If (<>aCdtadate{vRow}=!00-00-00!)
					<>aCdtadate{vRow}:=<>aCdtadate{0}
					AL_GotoCell (xALP_ConductaAlumnos;1;vRow)
				End if 
			: (vCol=2)
				Case of 
					: (Not:C34(DateIsValid (<>aCdtaDate2{vRow})))
						<>aCdtadate2{vRow}:=!00-00-00!
						CD_Dlog (0;__ ("Fecha incorrecta."))
						AL_GotoCell (xALP_ConductaAlumnos;2;vRow)
					: (<>aCdtaDate{vRow}><>aCdtaDate2{vRow})
						<>aCdtaDate2{vRow}:=!00-00-00!
						CD_Dlog (0;__ ("La fecha de término de la suspensión no puede ser inferior a la fecha de inicio."))
						AL_GotoCell (xALP_ConductaAlumnos;2;vRow)
					Else 
						AL_GotoCell (xALP_ConductaAlumnos;3;vRow)
				End case 
			: (vCol=3)
				Case of 
					: (<>aCdtatext1{vRow}="")
						CD_Dlog (0;__ ("Ingrese el motivo de la suspensión."))
						AL_GotoCell (xALP_ConductaAlumnos;3;vRow)
					: (Position:C15("[+]";<>aCdtaText1{vRow})>0)
						CD_Dlog (0;__ ("Una suspensión no puede originarse en un comportamiento positivo."))
						<>aCdtaText1{vRow}:=""
						AL_GotoCell (xALP_ConductaAlumnos;3;vRow)
					Else 
						AL_GotoCell (xALP_ConductaAlumnos;4;vRow)
				End case 
			: (vCol=4)
				AL_GotoCell (xALP_ConductaAlumnos;5;vRow)
			: (vCol=5)
				AL_GotoCell (xALP_ConductaAlumnos;vCol;vRow)
				POST KEY:C465(Character code:C91("-");256)
		End case 
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
	End if 
End if 