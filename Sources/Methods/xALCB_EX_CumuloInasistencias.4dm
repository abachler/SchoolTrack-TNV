//%attributes = {}
  //xALCB_EX_CumuloInasistencias

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283(vCol;vRow)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_Conducta_y_asistencia)=1)
		AL_GetCurrCell (xALP_Conducta_y_asistencia;vCol;vRow)
		Case of 
			: ((vCol=3) & (vRow>0))
				modCdt:=True:C214
				Case of 
					: (Current date:C33(*)>vdSTR_Periodos_FinEjercicio)
						aPctAsist{vRow}:=Round:C94((viSTR_Periodos_DiasAgno-aInasist{vRow})/viSTR_Periodos_DiasAgno*100;1)
					: (Current date:C33(*)<=vdSTR_Periodos_FinEjercicio)
						If (viSTR_Periodos_DiasAgno<viSTR_Calendario_DiasAHoy)
							aPctAsist{vRow}:=Round:C94((viSTR_Periodos_DiasAgno-aInasist{vRow})/viSTR_Periodos_DiasAgno*100;1)
						Else 
							aPctAsist{vRow}:=Round:C94((viSTR_Calendario_DiasAHoy-aInasist{vRow})/viSTR_Calendario_DiasAHoy*100;1)
						End if 
					Else 
						aPctAsist{vRow}:=Round:C94((viSTR_Periodos_DiasAgno-aInasist{vRow})/viSTR_Periodos_DiasAgno*100;1)
				End case 
				AL_UpdateArrays (xALP_Conducta_y_asistencia;-1)
			: ((vCol=5) & (vRow>0))
				modCdt:=True:C214
		End case 
	End if 
End if 



