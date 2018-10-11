//%attributes = {}
  //xALCB_EX_EvaluacionActividades

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
If (False:C215)
	<>v443_UD:=True:C214
End if 

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_ActividadesExtra)=1)
		AL_GetCurrCell (xALP_ActividadesExtra;vCol;vRow)
		modXCR:=True:C214
		Case of 
			: ((vCol>2) & (vCol<9))
				$pointer:=Get pointer:C304("aAExEv"+String:C10(vCol-2))
				$value:=ST_Uppercase (Substring:C12($pointer->{vRow};1;5))
				$pointer->{vRow}:=$value
				AL_UpdateArrays (xALP_ActividadesExtra;-1)
				
				
			: (vCol=9)
				$value:=ST_Uppercase (Substring:C12(aExEvF{vRow};1;5))
				aExEvF{vRow}:=$value
				AL_UpdateArrays (xALP_ActividadesExtra;-1)
		End case 
	End if 
End if 
