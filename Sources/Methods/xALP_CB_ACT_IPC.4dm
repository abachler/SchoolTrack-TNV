//%attributes = {}
  //xALP_CB_ACT_IPC

C_LONGINT:C283(vRow;vCol)
C_LONGINT:C283($1;$2;$3)


If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_IPC)=1)
		$proc:=IT_UThermometer (1;0;__ ("Recalculando valores UF..."))
		AL_GetCurrCell (xALP_IPC;vCol;vRow)
		ACTcfg_RecalcUF 
		IT_UThermometer (-2;$proc)
	End if 
End if 