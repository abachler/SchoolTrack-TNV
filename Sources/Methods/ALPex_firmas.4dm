//%attributes = {}
  //ALPex_firmas

C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)
C_LONGINT:C283(vCol;vRow)


If (AL_GetCellMod (xALP_Firmas)=1)
	modFirmas:=True:C214
	AL_GetCurrCell (xALP_Firmas;vCol;vRow)
	AL_GetCellHigh (xALP_Firmas;vStart;vEnd)
	If (vCol=2)
		POST KEY:C465(Character code:C91("-");256)
	End if 
End if 