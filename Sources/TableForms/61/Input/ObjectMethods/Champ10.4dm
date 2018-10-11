IT_ClairvoyanceOnFields_Value (Self:C308;->[BBL_Items:61]Primer_editor:8)
If (Form event:C388=On Data Change:K2:15)
	BBLitm_NormalizaEditores 
	BBLitm_ActualizaFichasCatalogo 
	BBLmarc_UpdateMARCField (->[BBL_Items:61]Primer_editor:8)
End if 