//%attributes = {}
  //xALCB_EX_Licencias


C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283(vCol;vRow)


If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_ConductaAlumnos)=1)
		AL_GetCurrCell (xALP_ConductaAlumnos;vCol;vRow)
		READ WRITE:C146([Alumnos_Licencias:73])
		GOTO RECORD:C242([Alumnos_Licencias:73];<>aCdtaRecNo{vrow})
		[Alumnos_Licencias:73]Observaciones:5:=<>aCdtaText2{vRow}
		SAVE RECORD:C53([Alumnos_Licencias:73])
		UNLOAD RECORD:C212([Alumnos_Licencias:73])
		READ ONLY:C145([Alumnos_Licencias:73])
		POST KEY:C465(Character code:C91("=");256)
	End if 
End if 