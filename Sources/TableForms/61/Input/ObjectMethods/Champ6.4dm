IT_ClairvoyanceOnFields_Value (Self:C308;->[BBL_Items:61]Primer_autor:6)

Case of 
		  //: ((Form event=On Losing Focus ) & (Modified(Self->)))
	: ((Form event:C388=On Data Change:K2:15) & (Modified:C32(Self:C308->)))
		If (<>gAutoFormat)
			Self:C308->:=ST_Format (Self:C308)
		End if 
		Self:C308->:=ST_ClearSpaces (Self:C308->)
		BBLitm_NormalizaAutores 
		BBLitm_ActualizaFichasCatalogo 
		BBLmarc_UpdateMARCField (->[BBL_Items:61]Primer_autor:6)
End case 