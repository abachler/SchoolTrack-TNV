Case of 
	: (Form event:C388=On Losing Focus:K2:8)
		  //20120303 RCH valores por defecto DTE
		C_TEXT:C284($vt_propiedad;vtACT_rutaClienteXDef)
		$vt_propiedad:="FILE|rutaAlmacenamientoArchivosCliente"
		vtACT_rutaClienteXDef:=ACTcfdi_OpcionesGenerales ("GetPropiedad";->$vt_propiedad)
		
End case 