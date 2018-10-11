Case of 
	: (alProEvt=-5)
		AL_GetDrgArea (Self:C308->;$destinationArea)
		AL_GetDrgDstTyp (Self:C308->;$destinationType)
		AL_GetDrgSrcRow (Self:C308->;$selectedItemLine)
		AL_GetDrgDstRow (Self:C308->;$DestRow)
		
		If ($destinationArea=ALP_ItemsVentaRapida)
			AL_UpdateArrays (ALP_ItemsVentaRapida;0)
			$yaExiste:=Find in array:C230(alACT_IDVVR;alACT_IDVR{$selectedItemLine})
			If ($yaExiste=-1)
				  //20130626 RCH NF CANTIDAD
				AT_Insert (0;1;->arACT_CantidadVVR;->atACT_GlosaVVR;->arACT_TotalVVR;->alACT_IDVVR;->abACT_AfectoIVAVVR;->arACT_DescuentoVVR;->apACT_AfectoIVAVVR)
				arACT_CantidadVVR{Size of array:C274(arACT_CantidadVVR)}:=1
				atACT_GlosaVVR{Size of array:C274(atACT_GlosaVVR)}:=atACT_GlosaVR{$selectedItemLine}
				arACT_TotalVVR{Size of array:C274(arACT_TotalVVR)}:=arACT_CantidadVVR{Size of array:C274(arACT_CantidadVVR)}*arACT_MontoPesosVR{$selectedItemLine}
				alACT_IDVVR{Size of array:C274(alACT_IDVVR)}:=alACT_IDVR{$selectedItemLine}
				abACT_AfectoIVAVVR{Size of array:C274(abACT_AfectoIVAVVR)}:=abACT_AfectoIVAVR{$selectedItemLine}
				If (abACT_AfectoIVAVVR{Size of array:C274(abACT_AfectoIVAVVR)})
					GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_AfectoIVAVVR{Size of array:C274(apACT_AfectoIVAVVR)})
				Else 
					GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_AfectoIVAVVR{Size of array:C274(apACT_AfectoIVAVVR)})
				End if 
			Else 
				arACT_CantidadVVR{$yaExiste}:=arACT_CantidadVVR{$yaExiste}+1
				arACT_TotalVVR{$yaExiste}:=arACT_CantidadVVR{$yaExiste}*arACT_MontoPesosVR{$selectedItemLine}
			End if 
			AL_UpdateArrays (ALP_ItemsVentaRapida;-2)
			ACTvr_RecalcularVenta 
		End if 
End case 