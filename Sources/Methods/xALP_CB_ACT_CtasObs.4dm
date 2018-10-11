//%attributes = {}
  //xALP_CB_ACT_CtasObs

C_LONGINT:C283($1;$2;$3)
C_BOOLEAN:C305($0)

If ($2=8)
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_Observaciones;vCol;vRow)
	If (vRow#0)
		$vl_idRegistro:=alACT_IDObs{vRow}
		$vt_obs:=atACT_Observacion{vRow}
		$vd_fecha:=adACT_FechaObs{vRow}
		ACTobs_OpcionesObservaciones ("Actualiza";->$vl_idRegistro;->$vt_obs;->$vd_fecha)
	End if 
End if 