//%attributes = {}
  //CU_CommentsAreaExit

C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)
C_LONGINT:C283(vCol;vRow)
If (AL_GetCellMod (xALP_COMMENT)=1)
	AL_GetCurrCell (xALP_COMMENT;vcol;vRow)
	READ WRITE:C146([Alumnos:2])
	GOTO RECORD:C242([Alumnos:2];aLong1{vRow})
	LOAD RECORD:C52([Alumnos:2])
	Case of 
		: (vCol=2)
			[Alumnos:2]Observaciones_finales:47:=ST_clearUnNecessaryCR (ST_ClrWildChars (aText2{vRow}))
		: (vCol=3)
			[Alumnos:2]Observaciones_Periodo1:44:=ST_clearUnNecessaryCR (ST_ClrWildChars (aText3{vRow}))
		: (vCol=4)
			[Alumnos:2]Observaciones_Periodo2:45:=ST_clearUnNecessaryCR (ST_ClrWildChars (aText4{vRow}))
		: (vCol=5)
			[Alumnos:2]Observaciones_Periodo3:46:=ST_clearUnNecessaryCR (ST_ClrWildChars (aText5{vRow}))
		: (vCol=6)
			[Alumnos:2]Observaciones_Periodo4:55:=ST_clearUnNecessaryCR (ST_ClrWildChars (aText6{vRow}))
		: (vCol=7)
			[Alumnos:2]Observaciones_Periodo5:106:=ST_clearUnNecessaryCR (ST_ClrWildChars (aText6{vRow}))
	End case 
	SAVE RECORD:C53([Alumnos:2])
	UNLOAD RECORD:C212([Alumnos:2])
	READ ONLY:C145([Alumnos:2])
End if 