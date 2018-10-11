Case of 
	: (vbACT_PagoXCuenta)
		vtACT_CtaoApdo:="Cuenta Corriente:"
		vtACT_NombreCtaoApdo:=vsACT_NomApellidoCta
	: (vbACT_PagoXApdo)
		vtACT_CtaoApdo:="Apoderado:"
		vtACT_NombreCtaoApdo:=vsACT_NomApellido
	: (vbACTpgs_PagoXTercero)
		vtACT_CtaoApdo:="Tercero:"
		vtACT_NombreCtaoApdo:=vsACT_NomApellido
End case 
Case of 
	: (rLetras=1)
		vdACT_FechaPago:=vdACT_LCFechaEDocumento
End case 
READ ONLY:C145([xxSTR_Constants:1])
ALL RECORDS:C47([xxSTR_Constants:1])
ONE RECORD SELECT:C189([xxSTR_Constants:1])
FORM SET OUTPUT:C54([xxSTR_Constants:1];"ACTpgs_PrintDocList")
PRINT SELECTION:C60([xxSTR_Constants:1])
FORM SET OUTPUT:C54([xxSTR_Constants:1];"Output")