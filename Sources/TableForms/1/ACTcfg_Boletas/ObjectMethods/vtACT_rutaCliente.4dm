Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		C_TEXT:C284($vtACT_rutaCliente)
		$vtACT_rutaCliente:=xfGetDirName (__ ("Seleccione el directorio..."))
		If (ok=1)
			vtACT_rutaCliente:=$vtACT_rutaCliente
			$vt_propiedad:="FILE|rutaAlmacenamientoArchivosIngresoPago"
			vtACT_rutaCliente:=ACTcfdi_OpcionesGenerales ("ValidaPropiedad";->$vt_propiedad;->vtACT_rutaCliente)
			ACTcfdi_OpcionesGenerales ("SetPropiedad";->$vt_propiedad;->vtACT_rutaCliente)
		End if 
	: (Form event:C388=On Losing Focus:K2:8)
		$vt_propiedad:="FILE|rutaAlmacenamientoArchivosIngresoPago"
		If (vtACT_rutaCliente#"")
			vtACT_rutaCliente:=ACTcfdi_OpcionesGenerales ("ValidaPropiedad";->$vt_propiedad;->vtACT_rutaCliente)
		End if 
		ACTcfdi_OpcionesGenerales ("SetPropiedad";->$vt_propiedad;->vtACT_rutaCliente)
		
End case 