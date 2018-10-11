C_TEXT:C284($t_ruta;$t_rutEmisor;$t_tipoDocumento;$t_tipo;$t_ruta)
C_BOOLEAN:C305($b_cedible3)
C_DATE:C307($d_fechaE)
C_REAL:C285($r_folio)
C_LONGINT:C283($l_idBoleta)

If (Not:C34([ACT_Boletas:181]Nula:15))
	
	$b_readOnly:=Read only state:C362([ACT_Boletas:181])
	$l_idBoleta:=[ACT_Boletas:181]ID:1
	If (<>gCountryCode="cl")
		
		IT_MODIFIERS   //20170503 RCH Para probar cuando hay problemas en la firma del documento.
		
		  //20150812 RCH lee pref para ver si quiere la copia cedible
		ACTdte_OpcionesManeja ("LeeBlob")
		
		  //20151003 RCH Si no se ha emitido, se intenta emitir si es que tiene permisos
		If (ACTdte_EsEmisorColegium ([ACT_Boletas:181]ID_RazonSocial:25))  // si el contribuyente es emisor CLG
			If ([ACT_Boletas:181]Numero:11=0)  //si no se encuentra el documento
				If ([ACT_Boletas:181]documento_electronico:29)  //si el documento es electrónico
					If ([ACT_Boletas:181]DTE_estado_id:24 ?? 0)  //si es emisor CLG
						If (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 2))  //Si no ha sido enviado
							
							If (USR_GetMethodAcces ("ACTdte_MarcaDocumentosMasivos"))  //tiene permiso para marcar.
								If (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 1))
									[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 1
									SAVE RECORD:C53([ACT_Boletas:181])
								End if 
								
								If (USR_GetMethodAcces ("ACTdte_EnviaDocumentosMasivos"))  //tiene permiso para enviar dte
									$vl_procesados:=ACTdte_EmiteDocumento ($l_idBoleta)
									KRL_ResetPreviousRWMode (->[ACT_Boletas:181];$b_readOnly)
									KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta)
									If (Records in selection:C76([ACT_Boletas:181])=1)  // si no hay error recarga area
										ACTbol_OnRecordLoad 
									End if 
								End if 
								
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
		
		If (Records in selection:C76([ACT_Boletas:181])=1)  //si hay error la boleta puede eliminarse 
			$t_rutEmisor:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->[ACT_Boletas:181]ID_RazonSocial:25;->[ACT_RazonesSociales:279]RUT:3)
			$t_tipoDocumento:="PDF"
			$b_cedible3:=(r_obtieneCopiaCedible=1)
			$d_fechaE:=[ACT_Boletas:181]FechaEmision:3
			$t_tipo:=[ACT_Boletas:181]codigo_SII:33+":"+[ACT_Boletas:181]TipoDocumento:7
			$r_folio:=[ACT_Boletas:181]Numero:11
			$t_ruta:=ACTdteEmi_Generales ("ObtieneRUTADocumentos";->$t_rutEmisor;->$t_tipoDocumento;->$b_cedible3;->$d_fechaE;->$t_tipo;->$r_folio)
			
			  //20150710 RCH Si no se ha obtenido el PDF, se intenta obtener
			If (Test path name:C476($t_ruta)#Is a document:K24:1)
				If (ACTdte_EsEmisorColegium ([ACT_Boletas:181]ID_RazonSocial:25))
					If (USR_GetMethodAcces ("ACTdte_ObtienePDF"))  //tiene permiso para obtener PDF
						ACTdte_ObtienePDFDT ([ACT_Boletas:181]ID:1)
					End if 
				End if 
			End if 
			
			
			If (Test path name:C476($t_ruta)=Is a document:K24:1)
				OPEN URL:C673($t_ruta;*)
			Else 
				CD_Dlog (0;__ ("No se ha generado un archivo PDF para este documento o el archivo no puede ser localizado."))
			End if 
		Else 
			BWR_AfterDeleteOnLoading 
		End if 
	End if 
End if 