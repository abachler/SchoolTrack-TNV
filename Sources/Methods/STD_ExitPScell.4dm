//%attributes = {}
  //STD_ExitPScell

C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)
C_LONGINT:C283(vCol;vRow)
If (AL_GetCellMod (alProblemas)=1)
	modPblSalud:=True:C214
	AL_GetCurrCell (alProblemas;vCol;vRow)
	Case of 
		: (vCol=1)
			If ((aProblema{0}#"") & (aProblema{vRow}=""))
				aPblObs{vRow}:=""
				AL_UpdateArrays (alProblemas;-1)
			Else 
				AL_GotoCell (alProblemas;2;vRow)
			End if 
	End case 
End if 