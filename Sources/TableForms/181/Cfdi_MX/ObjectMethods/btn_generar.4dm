C_LONGINT:C283($vl_resultado)

If (at_proveedores>0)
	$vl_resultado:=Num:C11(ACTcfdi_OpcionesGenerales ("PathFileValidate"))
	If ($vl_resultado=1)
		ACTcfdi_OpcionesGenerales ("GuardaPaths";->vlACT_RSSel)
		
		READ ONLY:C145([ACT_Boletas:181])
		If ((vlACT_RSSel=0) | (vlACT_RSSel=-1))
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25=0;*)
			QUERY SELECTION:C341([ACT_Boletas:181]; | ;[ACT_Boletas:181]ID_RazonSocial:25=-1)
		Else 
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25=vlACT_RSSel)
		End if 
		If (Records in selection:C76([ACT_Boletas:181])>0)
			
			$vb_accept:=True:C214
			If (cs_generaOnServer=1)
				If (vtACT_rutaOnServer="")
					$vb_accept:=False:C215
					CD_Dlog (0;__ ("La opción ")+ST_Qte (__ ("Generar en el servidor"))+__ (" está marcada pero en la configuración no ha sido definida una ruta en el servidor para almacenar el archivo que se va a generar."))
				End if 
			End if 
			If ($vb_accept)
				ACCEPT:C269
			End if 
		Else 
			CD_Dlog (0;__ ("No hay documentos seleccionados para la razón social ")+atACTcfg_Razones{atACTcfg_Razones}+".")
			CANCEL:C270
		End if 
	Else 
		BEEP:C151
	End if 
Else 
	CD_Dlog (0;__ ("El proveedor no ha sido definido. Por favor seleccione uno antes de continuar (Archivo/Configuración/Documentos Tributarios/CFDI)."))
End if 