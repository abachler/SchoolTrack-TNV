//%attributes = {}
  //xALCB_EX_Periodos

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_Periodos;$vCol;$vRow)
	If (($vCol>=3) & ($vCol<=4))
		aiSTR_Periodos_Dias{$vRow}:=DT_GetWorkingDays (adSTR_Periodos_Desde{$vRow};adSTR_Periodos_Hasta{$vRow})
		vdSTR_Periodos_InicioEjercicio:=adSTR_Periodos_Desde{1}
		vdSTR_Periodos_FinEjercicio:=adSTR_Periodos_Hasta{Size of array:C274(aiSTR_Periodos_Numero)}
		viSTR_Periodos_DiasAgno:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
		If (Current date:C33(*)>=vdSTR_Periodos_InicioEjercicio)
			If (Current date:C33(*)<vdSTR_Periodos_FinEjercicio)
				viSTR_Calendario_DiasAHoy:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;Current date:C33(*))
			Else 
				viSTR_Calendario_DiasAHoy:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
			End if 
		End if 
		REDRAW WINDOW:C456
		AL_UpdateArrays (xALP_Periodos;-1)
	End if 
End if 