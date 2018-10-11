//%attributes = {}
  //xALP_ACT_CB_ItemsVenta

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (ALP_ItemsVentaRapida;vCol;vRow)
	
	If (AL_GetCellMod (ALP_ItemsVentaRapida)=1)
		Case of 
			: (vCol=1)
				TRACE:C157
				  //revisar si se debe cambiar arreglo
				  //20130626 RCH NF CANTIDAD
				arACT_CantidadVVR{vRow}:=Round:C94(arACT_CantidadVVR{vRow};1)
				$MontoDef:=Find in array:C230(alACT_IDVR;alACT_IDVVR{vRow})
				If ($MontoDef#-1)
					If (arACT_MontoPesosVR{$MontoDef}>0)
						arACT_TotalVVR{vRow}:=(arACT_CantidadVVR{vRow}*arACT_MontoPesosVR{$MontoDef})-arACT_DescuentoVVR{vRow}
					End if 
				End if 
			: (vCol=3)
				If ((arACT_DescuentoVVR{vRow}>=0) & (arACT_TotalVVR{vRow}>arACT_DescuentoVVR{vRow}))
					$MontoDef:=Find in array:C230(alACT_IDVR;alACT_IDVVR{vRow})
					If ($MontoDef#-1)
						If (arACT_MontoPesosVR{$MontoDef}>0)
							arACT_TotalVVR{vRow}:=Round:C94((arACT_CantidadVVR{vRow}*arACT_MontoPesosVR{$MontoDef})-arACT_DescuentoVVR{vRow};0)
						Else 
							arACT_TotalVVR{vRow}:=arACT_TotalVVR{vRow}-arACT_DescuentoVVR{vRow}
						End if 
					End if 
				Else 
					BEEP:C151
					arACT_DescuentoVVR{vRow}:=arACT_DescuentoVVR{0}
				End if 
			: (vCol=4)
				arACT_DescuentoVVR{vRow}:=0
		End case 
		ACTvr_RecalcularVenta 
		REDRAW WINDOW:C456
	End if 
End if 