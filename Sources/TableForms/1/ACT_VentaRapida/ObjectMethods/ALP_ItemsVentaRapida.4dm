Case of 
	: (alProEvt=-5)
		AL_GetDrgArea (Self:C308->;$destinationArea)
		AL_GetDrgDstTyp (Self:C308->;$destinationType)
		AL_GetDrgSrcRow (Self:C308->;$selectedItemLine)
		AL_GetDrgDstRow (Self:C308->;$DestRow)
		
		If ($destinationArea=ALP_ItemsRapidos)
			AL_UpdateArrays (ALP_ItemsVentaRapida;0)
			  //20130626 RCH NF CANTIDAD
			AT_Delete ($selectedItemLine;1;->arACT_CantidadVVR;->atACT_GlosaVVR;->arACT_TotalVVR;->alACT_IDVVR;->abACT_AfectoIVAVVR;->arACT_DescuentoVVR;->apACT_AfectoIVAVVR)
			AL_UpdateArrays (ALP_ItemsVentaRapida;-2)
			ACTvr_RecalcularVenta 
		End if 
End case 