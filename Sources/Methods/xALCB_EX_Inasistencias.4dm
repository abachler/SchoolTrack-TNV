//%attributes = {}
  //xALCB_EX_Inasistencias

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
		End case 
		If (<>aCdtadate{vRow}#!00-00-00!)
			READ WRITE:C146([Alumnos_Inasistencias:10])
			GOTO RECORD:C242([Alumnos_Inasistencias:10];<>aCdtaRecNo{vrow})
			[Alumnos_Inasistencias:10]Observaciones:3:=<>aCdtaText2{vRow}
			SAVE RECORD:C53([Alumnos_Inasistencias:10])
			UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
			READ ONLY:C145([Alumnos_Inasistencias:10])
			POST KEY:C465(Character code:C91("=");256)
		End if 
	End if 
End if 