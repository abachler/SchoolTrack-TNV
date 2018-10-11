If (Self:C308->>0)
	KRL_ReloadInReadWriteMode (->[Personas:7])
	[Personas:7]ACT_DocumentoTributario:45:=alACT_IDsCats{atACT_Categorias}
	vtACT_DocTrib:=atACT_Categorias{atACT_Categorias}
	SAVE RECORD:C53([Personas:7])
End if 



