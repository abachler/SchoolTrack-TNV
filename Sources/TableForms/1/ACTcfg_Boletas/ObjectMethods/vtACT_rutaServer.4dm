Case of 
	: (Form event:C388=On Data Change:K2:15)
		C_TEXT:C284($vt_propiedad)
		$vt_propiedad:="FILE|rutaAlmacenamientoArchivosIngresoPagoServer"
		If (vtACT_rutaServer#"")
			vtACT_rutaServer:=ACTcfdi_OpcionesGenerales ("ValidaPropiedad";->$vt_propiedad;->vtACT_rutaServer)
		End if 
		ACTcfdi_OpcionesGenerales ("SetPropiedad";->$vt_propiedad;->vtACT_rutaServer)
End case 