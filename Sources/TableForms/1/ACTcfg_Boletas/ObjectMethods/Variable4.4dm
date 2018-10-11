$row:=AL_GetLine (ALP_TiposdeDoc)
If ($row>0)
	If (alACT_IDCat{$row}=0)
		AT_Delete ($row;1;->atACT_Cats;->atACT_NombreDoc;->alACT_Proxima;->atACT_Tipo;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->apACT_Afecta;->abACT_Afecta;->abACT_DocPorDefecto;->apACT_DocPorDefecto;->abACT_DocComplete;->aiACT_Tipo;->atACT_idNumeracion;->atACT_RazonSocial;->alACT_RazonSocial;->alACT_IdDTSinc;->atACT_DTSinc)
		AL_UpdateArrays (ALP_TiposdeDoc;-2)
		ACTcfg_SetDocRowsColor 
		AL_SetLine (ALP_TiposdeDoc;0)
		_O_DISABLE BUTTON:C193(Self:C308->)
	Else 
		If (abACT_DocPorDefecto{$row})
			CD_Dlog (0;__ ("No puede eliminar un documento por defecto de una categoría."))
		Else 
			SET QUERY LIMIT:C395(1)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$boletas)
			QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Documento:13=alACT_IDDT{$row})
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			SET QUERY LIMIT:C395(0)
			If ($boletas=0)
				AT_Delete ($row;1;->atACT_Cats;->atACT_NombreDoc;->alACT_Proxima;->atACT_Tipo;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->apACT_Afecta;->abACT_Afecta;->abACT_DocPorDefecto;->apACT_DocPorDefecto;->abACT_DocComplete;->aiACT_Tipo;->atACT_idNumeracion;->atACT_RazonSocial;->alACT_RazonSocial;->alACT_IdDTSinc;->atACT_DTSinc)
				AL_UpdateArrays (ALP_TiposdeDoc;-2)
				ACTcfg_SetDocRowsColor 
				AL_SetLine (ALP_TiposdeDoc;0)
				_O_DISABLE BUTTON:C193(Self:C308->)
			Else 
				CD_Dlog (0;__ ("Existen documentos tributarios emitidos usando este documento. El documento no puede ser eliminado."))
			End if 
		End if 
	End if 
End if 