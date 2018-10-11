$line:=AL_GetLine (xALP_Glosas)
If ($line>0)
	AT_Delete ($line;1;->atACT_GlosasExtraGlosa;->atACT_GlosasExtraCta;->atACT_GlosasExtraCentro;->atACT_GlosasExtraCCta;->atACT_GlosasExtraCCentro;->abACT_ImputacionUnica;->apACT_ImputacUnicaPict)
	SORT ARRAY:C229(atACT_GlosasExtraGlosa;atACT_GlosasExtraCta;atACT_GlosasExtraCentro;atACT_GlosasExtraCCta;atACT_GlosasExtraCCentro;abACT_ImputacionUnica;apACT_ImputacUnicaPict;>)
	AL_UpdateArrays (xALP_Glosas;-2)
	AL_SetLine (xALP_Glosas;0)
	_O_DISABLE BUTTON:C193(bDelete)
	vbACT_ModGlosasExtra:=True:C214
End if 
