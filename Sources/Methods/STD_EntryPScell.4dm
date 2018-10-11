//%attributes = {}
  //STD_EntryPScell

C_LONGINT:C283($1;$2)
C_LONGINT:C283(vCol;vRow)
AL_GetCurrCell (alProblemas;vCol;vRow)
If (vCol=2)
	If (aProblema{vRow}="")
		AL_GotoCell (alProblemas;1;vRow)
		AL_SetCellHigh (alProblemas;1;10)
	End if 
End if 
