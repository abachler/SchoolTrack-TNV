//%attributes = {}
  //xALCB_EX_ContextTranslator

C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_Translator;$vCol;$vRow)
	If (AL_GetCellMod (xALP_Translator)=1)
		If (atXS_IntText{$vRow}="")
			BEEP:C151
			atXS_IntText{$vRow}:=atXS_IntText{0}
		Else 
			modTrans:=True:C214
			_O_ENABLE BUTTON:C192(bConfirm)
		End if 
	End if 
End if 