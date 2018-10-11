IT_ClairvoyanceOnFields_Value (Self:C308;->[BBL_Items:61]Primer_título:4)

Case of 
	: ((Form event:C388=On Data Change:K2:15) & (Modified:C32(Self:C308->)))
		If ([BBL_Items:61]Titulos:5#"")
			BBLitm_NormalizaTitulos 
			BBLitm_ActualizaFichasCatalogo 
			If (KRL_RecordExists (->[BBL_Items:61]Primer_título:4))
				$r:=CD_Dlog (0;__ ("Ya existe otro documento con el mismo título\r¿ Desea Ud. realmente repetir el título ?");__ ("");__ ("No");__ ("Si"))
				If ($r=1)
					[BBL_Items:61]Titulos:5:=""
					[BBL_Items:61]Primer_título:4:=""
					GOTO OBJECT:C206([BBL_Items:61]Titulos:5)
				End if 
			End if 
			SET WINDOW TITLE:C213(__ ("Item: ")+[BBL_Items:61]Primer_título:4)
		End if 
		BBLmarc_UpdateMARCField (->[BBL_Items:61]Primer_título:4)
End case 