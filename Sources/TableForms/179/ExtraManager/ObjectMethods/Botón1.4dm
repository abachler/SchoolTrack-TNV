$new:=CD_Request (__ ("Ingrese la nueva glosa extraordinaria");__ ("OK");__ ("Cancelar"))
If (OK=1)
	If ($new#"")
		AT_Insert (1;1;->atACT_GlosasExtraGlosa;->atACT_GlosasExtraCta;->atACT_GlosasExtraCentro;->atACT_GlosasExtraCCta;->atACT_GlosasExtraCCentro;->apACT_ImputacUnicaPict;->abACT_ImputacionUnica)
		atACT_GlosasExtraGlosa{1}:=$new
		abACT_ImputacionUnica{1}:=True:C214
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_ImputacUnicaPict{1})
		SORT ARRAY:C229(atACT_GlosasExtraGlosa;atACT_GlosasExtraCta;atACT_GlosasExtraCentro;atACT_GlosasExtraCCta;atACT_GlosasExtraCCentro;apACT_ImputacUnicaPict;abACT_ImputacionUnica;>)
		AL_UpdateArrays (xALP_Glosas;-2)
		$line:=Find in array:C230(atACT_GlosasExtraGlosa;$new)
		If ($line#-1)
			AL_SetLine (xALP_Glosas;$line)
			_O_ENABLE BUTTON:C192(bDelete)
			AL_SetScroll (xALP_Glosas;$line;1)
		Else 
			AL_SetLine (xALP_Glosas;0)
			_O_DISABLE BUTTON:C193(bDelete)
			AL_SetScroll (xALP_Glosas;1;1)
		End if 
		vbACT_ModGlosasExtra:=True:C214
	End if 
End if 