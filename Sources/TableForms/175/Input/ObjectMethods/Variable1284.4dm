$line:=AL_GetLine (xALP_Observaciones)
If ($line>0)
	$vl_idRegistro:=alACT_IDObs{$line}
	$resp:=ACTobs_OpcionesObservaciones ("Elimina";->$vl_idRegistro)
	If ($resp="0")
		AL_ExitCell (xALP_Observaciones)
		AL_UpdateArrays (xALP_Observaciones;0)
		ACTcc_LoadObs 
		AL_UpdateArrays (xALP_Observaciones;-2)
		Case of 
			: (Size of array:C274(alACT_IDObs)=0)
				AL_SetLine (xALP_Observaciones;0)
			: (Size of array:C274(alACT_IDObs)=1)
				AL_SetLine (xALP_Observaciones;1)
			: (Size of array:C274(alACT_IDObs)>=$obs)
				AL_SetLine (xALP_Observaciones;$obs)
			: (Size of array:C274(alACT_IDObs)<$obs)
				AL_SetLine (xALP_Observaciones;Size of array:C274(alACT_IDObs))
		End case 
		$line:=AL_GetLine (xALP_Observaciones)
		IT_SetButtonState (($line#0);->bDelObs)
	Else 
		CD_Dlog (0;"La observación está siendo consultada por otro usuario. No puede ser eliminada en"+" este momento.")
	End if 
End if 