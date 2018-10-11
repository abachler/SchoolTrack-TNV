If (ACTdc_DocumentoNoBloq ("Protestar";->[ACT_Documentos_de_Pago:176]ID:1))
	If ((vdACT_FechaProtesto#!00-00-00!) & (vtACT_MotivoProtesto#""))
		$r:=CD_Dlog (0;__ ("Protestar un documento es una operación definitiva y no tiene vuelta atrás.\r\r¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
		If ($r=1)
			ACTdc_OpcionesGenerales ("ProtestaDocumento";->vdACT_FechaProtesto;->vtACT_MotivoProtesto)
			
			ACTdc_OpcionesGenerales ("CargaNuevoDocumento")
			
		Else 
			ACTdc_DocumentoNoBloq ("ProtestarLiberaRegistros")
			CANCEL:C270
		End if 
	End if 
Else 
	ACTdc_DocumentoNoBloq ("ProtestarMensaje")
	ACTdc_DocumentoNoBloq ("ProtestarLiberaRegistros")
	CANCEL:C270
End if 