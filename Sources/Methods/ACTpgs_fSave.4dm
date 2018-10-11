//%attributes = {}
  //ACTpgs_fSave

If (modPago)
	C_DATE:C307($vd_oldFechaPago)
	$save:=1
	$vd_oldFechaPago:=Old:C35([ACT_Pagos:172]Fecha:2)
	
	
	  // 179864
	C_TEXT:C284($vt_fechaValida;$vt_msg)
	C_BOOLEAN:C305($vb_continuar)
	C_LONGINT:C283($vl_recNumPago)
	C_DATE:C307($vd_fechaIngreso)
	
	$vb_continuar:=True:C214
	$vl_recNumPago:=Record number:C243([ACT_Pagos:172])
	$vd_fechaIngreso:=[ACT_Pagos:172]Fecha:2
	
	If (cb_noPagosConFechasAnteriores=1)
		$vt_fechaValida:=ACTpgs_validaFechaPago ("ModificacionPagos";$vd_fechaIngreso;$vl_recNumPago)
		If ($vt_fechaValida#"ok")
			$vb_continuar:=False:C215
			CD_Dlog (0;__ ($vt_fechaValida))
			$save:=-1
		End if 
	End if 
	GOTO RECORD:C242([ACT_Pagos:172];$vl_recNumPago)
	  // 179864
	
	
	If ($vb_continuar)  // 179864
		
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))  //para los depositados
				[ACT_Pagos:172]Fecha:2:=[ACT_Documentos_de_Pago:176]FechaPago:4
				SAVE RECORD:C53([ACT_Pagos:172])
				  //SAVE RECORD([ACT_Documentos_de_Pago])
				ACTdp_fSave 
			: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-4)  //cheque
				If ([ACT_Documentos_de_Pago:176]NoSerie:12#"")
					  //20120330 RCH No se consideraba la cuenta para buscar duplicados.
					  //SET QUERY DESTINATION(Into variable;$duplicados)
					  //QUERY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]ID#[ACT_Documentos_de_Pago]ID;*)
					  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]Ch_BancoCodigo=[ACT_Documentos_de_Pago]Ch_BancoCodigo;*)
					  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]NoSerie=[ACT_Documentos_de_Pago]NoSerie;*)
					  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]Nulo=False)
					  //SET QUERY DESTINATION(Into current selection)
					  //If ($duplicados>1)
					  //CD_Dlog (0;__ ("Para este banco ya existe un cheque con ese número de serie."))
					  //[ACT_Documentos_de_Pago]NoSerie:=Old([ACT_Documentos_de_Pago]NoSerie)
					  //$save:=-1
					C_LONGINT:C283($vl_duplicados;$vl_tipoDoc)
					$vl_tipoDoc:=-2
					$vl_duplicados:=ACTdc_BuscaDuplicados ($vl_tipoDoc;[ACT_Documentos_de_Pago:176]NoSerie:12;[ACT_Documentos_de_Pago:176]Ch_Cuenta:11;[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8)
					If ($vl_duplicados>1)
						CD_Dlog (0;__ ("Para este banco y cuenta ya existe un cheque con ese número de serie."))
						[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8:=Old:C35([ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8)
						[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7:=Old:C35([ACT_Documentos_de_Pago:176]Ch_BancoNombre:7)
						[ACT_Documentos_de_Pago:176]Ch_Cuenta:11:=Old:C35([ACT_Documentos_de_Pago:176]Ch_Cuenta:11)
						[ACT_Documentos_de_Pago:176]NoSerie:12:=Old:C35([ACT_Documentos_de_Pago:176]NoSerie:12)
						$save:=-1
					Else 
						If (Not:C34([ACT_Documentos_de_Pago:176]Depositado:35))
							[ACT_Documentos_en_Cartera:182]Fecha_Doc:5:=[ACT_Documentos_de_Pago:176]Fecha:13
							[ACT_Documentos_en_Cartera:182]Numero_Doc:6:=[ACT_Documentos_de_Pago:176]NoSerie:12
							  //[ACT_Documentos_en_Cartera]Fecha_Vencimiento:=[ACT_Documentos_en_Cartera]Fecha_Doc+60
							Case of   //20140522 RCH Cambios según ticket 132961
								: (<>gCountryCode="ar")
									[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10:=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5+30
								: (<>gCountryCode="co")
									[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10:=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5+30
								Else 
									[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10:=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5+60
							End case 
							[ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12:=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5
							[ACT_Documentos_en_Cartera:182]Ch_Depositarhasta:13:=[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10-1
							SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
							LOG_RegisterEvt ("Modificación de datos de pago N° "+String:C10([ACT_Pagos:172]ID:1))
							[ACT_Pagos:172]Fecha:2:=[ACT_Documentos_de_Pago:176]FechaPago:4
							  //SAVE RECORD([ACT_Documentos_de_Pago])
							ACTdp_fSave 
							SAVE RECORD:C53([ACT_Pagos:172])
							$recNumCartera:=Record number:C243([ACT_Documentos_en_Cartera:182])
							$recNumDocPago:=Record number:C243([ACT_Documentos_de_Pago:176])
							$recNumPago:=Record number:C243([ACT_Pagos:172])
							ACTdc_EstadoCheque ($recNumCartera)
							READ WRITE:C146([ACT_Documentos_en_Cartera:182])
							READ WRITE:C146([ACT_Documentos_de_Pago:176])
							READ WRITE:C146([ACT_Pagos:172])
							If ($recNumCartera#-1)
								GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];$recNumCartera)
							End if 
							If ($recNumDocPago#-1)
								GOTO RECORD:C242([ACT_Documentos_de_Pago:176];$recNumDocPago)
							End if 
							If ($recNumPago#-1)
								GOTO RECORD:C242([ACT_Pagos:172];$recNumPago)
							End if 
						Else 
							LOG_RegisterEvt ("Modificación de datos de pago N° "+String:C10([ACT_Pagos:172]ID:1))
							[ACT_Pagos:172]Fecha:2:=[ACT_Documentos_de_Pago:176]FechaPago:4
							  //SAVE RECORD([ACT_Documentos_de_Pago])
							ACTdp_fSave 
							SAVE RECORD:C53([ACT_Pagos:172])
						End if 
					End if 
				Else 
					CD_Dlog (0;__ ("Debe ingresar un número de serie para este documento."))
					[ACT_Documentos_de_Pago:176]NoSerie:12:=Old:C35([ACT_Documentos_de_Pago:176]NoSerie:12)
					$save:=-1
				End if 
			: ([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-8)  //letra
				C_LONGINT:C283($vl_duplicados;$vl_tipoDoc)
				$vl_tipoDoc:=-5
				$vl_duplicados:=ACTdc_BuscaDuplicados ($vl_tipoDoc;[ACT_Documentos_de_Pago:176]NoSerie:12)
				If ($vl_duplicados>1)
					CD_Dlog (0;__ ("Ya existe una letra con este número."))
					[ACT_Documentos_de_Pago:176]NoSerie:12:=Old:C35([ACT_Documentos_de_Pago:176]NoSerie:12)
					$save:=-1
				Else 
					[ACT_Documentos_en_Cartera:182]Fecha_Doc:5:=[ACT_Documentos_de_Pago:176]Fecha:13
					[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10:=[ACT_Documentos_de_Pago:176]FechaVencimiento:27
					[ACT_Documentos_en_Cartera:182]Numero_Doc:6:=[ACT_Documentos_de_Pago:176]NoSerie:12
					SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
					LOG_RegisterEvt ("Modificación de datos de pago N° "+String:C10([ACT_Pagos:172]ID:1))
					[ACT_Pagos:172]Fecha:2:=[ACT_Documentos_de_Pago:176]FechaPago:4
					  //SAVE RECORD([ACT_Documentos_de_Pago])
					ACTdp_fSave 
					SAVE RECORD:C53([ACT_Pagos:172])
				End if 
				
			Else 
				LOG_RegisterEvt ("Modificación de datos de pago N° "+String:C10([ACT_Pagos:172]ID:1))
				[ACT_Pagos:172]Fecha:2:=[ACT_Documentos_de_Pago:176]FechaPago:4
				  //SAVE RECORD([ACT_Documentos_de_Pago])
				ACTdp_fSave 
				SAVE RECORD:C53([ACT_Pagos:172])
		End case 
		If ([ACT_Pagos:172]Fecha:2#$vd_oldFechaPago)
			$vb_done:=ACTpgs_ActualizaFechaTrans ([ACT_Pagos:172]ID:1)
			If (Not:C34($vb_done))
				BM_CreateRequest ("ACTpgs_ActualizaFechaTransacciones";String:C10([ACT_Pagos:172]ID:1);String:C10([ACT_Pagos:172]ID:1))
			End if 
		End if 
	End if 
	
	
Else 
	$save:=0
End if 
$0:=$save