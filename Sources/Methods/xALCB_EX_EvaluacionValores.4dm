//%attributes = {}
  //xALCB_EX_EvaluacionValores

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283(vCol;vRow)
_O_C_STRING:C293(5;$value)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_EvaluacionPersonal)=1)
		AL_GetCurrCell (xALP_EvaluacionPersonal;vCol;vRow)
		If (((vCol-2)>0) & (vRow>0))
			CUv_mEvVal:=True:C214
			$value:=ST_Uppercase (Substring:C12(aNtaArrPtr{vCol-2}->{vRow};1;5))
			If ((Find in array:C230(<>aEscalaV;$value)=-1) & (<>cb_EvalLibre=0))
				aNtaArrPtr{vCol-2}->{vRow}:=""
				AL_UpdateArrays (xALP_EvaluacionPersonal;-2)
				CD_Dlog (0;__ ("Indicador no definido."))
				AL_GotoCell (xALP_EvaluacionPersonal;vCol;vRow)
			Else 
				aNtaArrPtr{vCol-2}->{vRow}:=$value
			End if 
		End if 
	End if 
End if 