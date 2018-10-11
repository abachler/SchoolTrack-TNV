C_TEXT:C284($vt_msg)
C_LONGINT:C283($vl_registros;$vl_proc)

If (ACTdc_DocumentoNoBloq ("Protestar";->[ACT_Documentos_de_Pago:176]ID:1))
	If ((vdACT_FechaProtesto#!00-00-00!) & (vtACT_MotivoProtesto#""))
		  //20120524 RCH Se centraliza codigo
		$vt_msg:=__ ("Protestar un documento es una operación definitiva y no tiene vuelta atrás.")+"\r\r"
		If (cs_aplicaraTodos=1)
			$vl_registros:=Size of array:C274(alACT_RecNumsDocs)-i_Doc
			$vl_registros:=$vl_registros+1
			$vt_msg:=$vt_msg+__ ("Se aplicará el motivo de protesto ")+ST_Qte (vtACT_MotivoProtesto)+" a "+String:C10($vl_registros)+__ (" registro(s) seleccionado(s).")+"\r\r"
		End if 
		$vt_msg:=$vt_msg+__ ("¿Desea continuar?")
		$r:=CD_Dlog (0;$vt_msg;__ ("");__ ("Si");__ ("No"))
		If ($r=1)
			If (cs_aplicaraTodos=0)
				ACTdc_OpcionesGenerales ("ProtestaDocumento";->vdACT_FechaProtesto;->vtACT_MotivoProtesto)
			Else 
				C_LONGINT:C283($i_Doc)
				C_DATE:C307($vdACT_FechaProtesto)
				C_TEXT:C284($vtACT_MotivoProtesto)
				$i_Doc:=i_Doc
				$vdACT_FechaProtesto:=vdACT_FechaProtesto
				$vtACT_MotivoProtesto:=vtACT_MotivoProtesto
				
				If (cs_ImprimirComprobante=1)
					  // si imprime solo aparecera el print setting la primera vez..
					FORM SET OUTPUT:C54([ACT_Documentos_de_Pago:176];"ComprobanteProtesto")
					PRINT SETTINGS:C106
					If (ok=1)
						$vl_proc:=IT_UThermometer (1;0;__ ("Imprimiento comprobante de protesto..."))
						For ($i;i_Doc;Size of array:C274(alACT_RecNumsDocs))
							vdACT_FechaProtesto:=$vdACT_FechaProtesto
							vtACT_MotivoProtesto:=$vtACT_MotivoProtesto
							PRINT RECORD:C71([ACT_Documentos_de_Pago:176];>)
							ACTdc_OpcionesGenerales ("CargaNuevoDocumento")
						End for 
						IT_UThermometer (-2;$vl_proc)
					End if 
					i_Doc:=($i_Doc-1)
					ACTdc_OpcionesGenerales ("CargaNuevoDocumento")
					
					  //para asegurarnos de no volver a imprimir
					cs_ImprimirComprobante:=0
				End if 
				
				$vl_proc:=IT_UThermometer (1;0;__ ("Protestando documentos..."))
				For ($i;i_Doc;Size of array:C274(alACT_RecNumsDocs))
					vdACT_FechaProtesto:=$vdACT_FechaProtesto
					vtACT_MotivoProtesto:=$vtACT_MotivoProtesto
					ACTdc_OpcionesGenerales ("ProtestaDocumento";->vdACT_FechaProtesto;->vtACT_MotivoProtesto)
					ACTdc_OpcionesGenerales ("CargaNuevoDocumento")
				End for 
				IT_UThermometer (-2;$vl_proc)
				
			End if 
		End if 
		CANCEL:C270
	Else 
		CD_Dlog (0;__ ("Faltan datos para completar el protesto."))
	End if 
Else 
	ACTdc_DocumentoNoBloq ("ProtestarMensaje")
	CANCEL:C270
End if 
ACTdc_DocumentoNoBloq ("ProtestarLiberaRegistros")