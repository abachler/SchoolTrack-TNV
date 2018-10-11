$FormadePago:=FORM Get current page:C276

Case of 
	: ($FormadePago=2)
		vtACT_BancoTitular:=vtACT_NombreApoderado
	: ($FormadePago=3)
		vtACT_TCTitular:=vtACT_NombreApoderado
		ACTpp_CRYPTTC ("onLoadPagos";->vtACT_TCNumero)
	: ($FormadePago=5)
		vtACT_LTitular:=vtACT_NombreApoderado
End case 