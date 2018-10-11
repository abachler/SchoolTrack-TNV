//%attributes = {}
C_TEXT:C284(vtACT_ErrorString;vtACT_rutaCliente;$vt_propiedad;$vt_rutaCliente)
C_LONGINT:C283($vl_cuantos;$i;$vl_proc)

READ ONLY:C145([ACT_Boletas:181])

If ((<>gCountryCode="mx") | (<>gCountryCode="cl"))
	ACTcfg_OpcionesRazonesSociales ("LeePreferencias")
	atACTcfg_Razones:=1
	vlACT_RSSel:=alACTcfg_Razones{atACTcfg_Razones}
	ACTcfdi_OpcionesGenerales ("OnLoadConf";->vlACT_RSSel)
	If (cs_emitirCFDI=1)
		$vl_cuantos:=BWR_SearchRecords 
		If ($vl_cuantos>0)
			WDW_OpenFormWindow (->[ACT_Boletas:181];"Cfdi_MX";-1;4;__ ("Generación CFDI"))
			DIALOG:C40([ACT_Boletas:181];"Cfdi_MX")
			CLOSE WINDOW:C154
			If (ok=1)
				  // filtra por razon social seleccionada.
				If (vlACT_RSSel<=0)
					QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25=-1;*)
					QUERY SELECTION:C341([ACT_Boletas:181]; | ;[ACT_Boletas:181]ID_RazonSocial:25=0)
				Else 
					QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25=vlACT_RSSel)
				End if 
				
				ARRAY LONGINT:C221($alACT_ids;0)
				SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;$alACT_ids)
				
				ACTcfdi_OpcionesGenerales ("GeneraArchivoEnCliente";->$alACT_ids)
				
				If (vtACT_ErrorString#"")
					CD_Dlog (0;__ ("Error. Proceso interrumpido.")+"\r\r"+vtACT_ErrorString)
				End if 
				
				ARRAY TEXT:C222($atACT_archivos;0)
				ARRAY TEXT:C222($atACT_archivos1;0)
				ARRAY TEXT:C222($atACT_archivosHoras;0)
				
				DOCUMENT LIST:C474(vtACT_rutaCliente;$atACT_archivos1)
				For ($i;1;Size of array:C274($atACT_archivos1))
					GET DOCUMENT PROPERTIES:C477(vtACT_rutaCliente+$atACT_archivos1{$i};$locked;$invisible;$creadoel;$creadoalas;$modificadoel;$modificadoalas)
					If ($modificadoel=Current date:C33)
						APPEND TO ARRAY:C911($atACT_archivos;$atACT_archivos1{$i})
						APPEND TO ARRAY:C911($atACT_archivosHoras;String:C10($modificadoalas))
					End if 
				End for 
				SORT ARRAY:C229($atACT_archivosHoras;$atACT_archivos;<)
				If (Size of array:C274($atACT_archivos)>0)
					ACTcd_DlogWithShowOnDisk (vtACT_rutaCliente+$atACT_archivos{1};0;__ ("Archivo(s) generado(s)."))
				Else 
					CD_Dlog (0;__ ("Ningún archivo fue generado."))
				End if 
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("El sistema no ha sido configurado para generar los archivos."))
	End if 
End if 