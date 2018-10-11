  //REGISTRO DE CAMBIOS
  //20080418 RCH A partir de ahora los cargos a pagar se ordenan según el orden de los avisos en un método.
C_BOOLEAN:C305($pagar)
$Validado:=True:C214
$continuar:=True:C214
$SerieDuplicada:=False:C215
$fechaIncorrecta:=False:C215
ARRAY LONGINT:C221(aIDPagosDocumentar;0)
If ((vrACT_MontoAPagarApdo>0) & ((Size of array:C274(arACT_LCFolio)>0) | (Size of array:C274(atACT_BancoNombre)>0)))
	$mesAbierto:=ACTcm_IsMonthOpenFromDate (vdACT_FechaPago)
	If (Not:C34($mesAbierto))
		CD_Dlog (0;__ ("Los pagos no pueden ser registrados con esta fecha ya que corresponde a un mes cerrado."))
	Else 
		Case of 
			: (rCheques=1)
				$pagar:=ACTpgs_ValidaDocumentos (True:C214)
				
			: (rLetras=1)
				C_TEXT:C284($msg)
				arACT_LCFolio{0}:=0
				atACT_LCRut{0}:=""
				atACT_LCAceptante{0}:=""
				adACT_LCEmision{0}:=!00-00-00!
				adACT_LCVencimiento{0}:=!00-00-00!
				arACT_LCMonto{0}:=0
				
				ARRAY LONGINT:C221(alACT_ResultadoBusqueda;0)
				AT_SearchArray (->arACT_LCFolio;"=";->alACT_ResultadoBusqueda)
				If (Size of array:C274(alACT_ResultadoBusqueda)>0)
					$Validado:=False:C215
					$msg:=$msg+" - "+"Hay números de folio con número 0."+"\r"
				End if 
				ARRAY LONGINT:C221(alACT_ResultadoBusqueda;0)
				AT_SearchArray (->atACT_LCRut;"=";->alACT_ResultadoBusqueda)
				If (Size of array:C274(alACT_ResultadoBusqueda)>0)
					$Validado:=False:C215
					$msg:=$msg+" - "+"Hay líneas sin RUT."+"\r"
				End if 
				ARRAY LONGINT:C221(alACT_ResultadoBusqueda;0)
				AT_SearchArray (->atACT_LCAceptante;"=";->alACT_ResultadoBusqueda)
				If (Size of array:C274(alACT_ResultadoBusqueda)>0)
					$Validado:=False:C215
					$msg:=$msg+" - "+"Hay líneas sin aceptante."+"\r"
				End if 
				ARRAY LONGINT:C221(alACT_ResultadoBusqueda;0)
				AT_SearchArray (->adACT_LCEmision;"=";->alACT_ResultadoBusqueda)
				If (Size of array:C274(alACT_ResultadoBusqueda)>0)
					$Validado:=False:C215
					$msg:=$msg+" - "+"Existen líneas con fecha de emisión inválida."+"\r"
				End if 
				ARRAY LONGINT:C221(alACT_ResultadoBusqueda;0)
				AT_SearchArray (->adACT_LCVencimiento;"=";->alACT_ResultadoBusqueda)
				If (Size of array:C274(alACT_ResultadoBusqueda)>0)
					$Validado:=False:C215
					$msg:=$msg+" - "+"Existen líneas con fecha de vencimiento inválida."+"\r"
				End if 
				ARRAY LONGINT:C221(alACT_ResultadoBusqueda;0)
				AT_SearchArray (->arACT_LCMonto;"=";->alACT_ResultadoBusqueda)
				If (Size of array:C274(alACT_ResultadoBusqueda)>0)
					$Validado:=False:C215
					$msg:=$msg+" - "+"Hay líneas de monto en 0."+"\r"
				End if 
				ARRAY LONGINT:C221(alACT_ResultadoBusqueda;0)
				
				If (cambioLC)
					$Validado:=False:C215
					$msg:=$msg+" - "+"Se produjeron cambios en los datos de la primera letra después de generar los Doc"+"umentos. "
					$msg:=$msg+"Para continuar debe presionar nuevamente el botón Generar documentos y posteriorm"+"ente Ingresar."+"\r"
				End if 
				
				If ($Validado)
					For ($i;1;Size of array:C274(arACT_LCFolio))
						$Duplicados:=ACTdc_BuscaDuplicados (5;String:C10(arACT_LCFolio{$i}))
						If ($Duplicados>0)
							$i:=Size of array:C274(arACT_LCFolio)
							$continuar:=False:C215
							CD_Dlog (0;__ ("Ya existe una letra con este número de folio.(^0)";String:C10(arACT_LCFolio{$i})))
						End if 
					End for 
					
					If ($continuar)
						$format:="|Despliegue_ACT"
						If (cbMultaXCaja=1)
							$r:=CD_Dlog (0;__ ("¿Está seguro de querer ingresar ")+String:C10(vlACT_Cuotas)+__ (" letras por un monto total de ")+String:C10(vrACT_MontoAPagarApdo;$format)+__ (" para pagar una deuda de ")+String:C10(vrACT_MontoSeleccionado;$format)+__ (" y una multa de ")+String:C10(vrACT_MontoMulta;$format)+"?";"";__ ("Si");__ ("No"))
						Else 
							$r:=CD_Dlog (0;__ ("¿Está seguro de querer ingresar ")+String:C10(vlACT_Cuotas)+__ (" letras por un monto total de ")+String:C10(vrACT_MontoAPagarApdo;$format)+"?";"";__ ("Si");__ ("No"))
						End if 
						If ($r=1)
							$pagar:=True:C214
						End if 
					End if 
				Else 
					If ($msg#"")
						CD_Dlog (0;$msg)
					End if 
				End if 
		End case 
		If ($pagar)
			  //20140328 RCH no se estaba re calculando el saldo del apoderado
			ARRAY LONGINT:C221($alACT_RecNumsAvisos;0)
			ARRAY LONGINT:C221($aIDPagosDocumentar;0)
			
			COPY ARRAY:C226(alACT_RecNumsAvisos;$alACT_RecNumsAvisos)
			$unaXTotal:=fUnaBoleta
			$cbImprimirRecPago:=cbImprimirRecPago
			$cbImprimirBoletas:=cbImprimirBoletas
			$vl_indexLC:=vl_indexLC
			$vl_idApdo:=[Personas:7]No:1
			$vl_idTer:=[ACT_Terceros:138]Id:1
			AL_UpdateArrays (xALP_Documentar;0)
			AL_UpdateArrays (xALP_DocumentarLC;0)
			ACTpgs_IngresarDocumentos 
			COPY ARRAY:C226(aIDPagosDocumentar;$aIDPagosDocumentar)  //20160729 JVP se crea arreglo local para imprimir recibo
			ACTmnu_RecalcularSaldosAvisos (->$alACT_RecNumsAvisos;Current date:C33(*);False:C215;True:C214)
			If (rLetras=1)
				$r:=CD_Dlog (0;__ ("¿Desea imprimir las letras ahora?");"";__ ("Si");__ ("No"))
				If ($r=1)
					READ ONLY:C145([ACT_Documentos_de_Pago:176])
					ARRAY TEXT:C222(atACTlc_Folio;Size of array:C274(arACT_LCFolio))
					For ($i;1;Size of array:C274(arACT_LCFolio))
						atACTlc_Folio{$i}:=String:C10(arACT_LCFolio{$i})
					End for 
					$vl_idFormaDePago:=-8
					QUERY WITH ARRAY:C644([ACT_Documentos_de_Pago:176]NoSerie:12;atACTlc_Folio)
					QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=$vl_idFormaDePago)
					
					  //20120224 RCH Se sacan posibles documentos nulos...
					$vl_idEstadoNulo:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoNulo";->$vl_idFormaDePago))
					QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_estado:53#$vl_idEstadoNulo)
					
					  //ORDER BY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]NoSerie;>) //20120223 RCH se ordena en ACTlc_PrintLetras
					CREATE SET:C116([ACT_Documentos_de_Pago:176];"setDoc")
					If ((Records in set:C195("setDoc")>0) & ($vl_indexLC>0))
						ACTlc_PrintLetras ("setDoc";alACT_IDDT{$vl_indexLC})
					End if 
					CLEAR SET:C117("setDoc")
					AT_Initialize (->atACTlc_Folio)
				End if 
			End if 
			cbImprimirRecPago:=$cbImprimirRecPago
			cbImprimirBoletas:=$cbImprimirBoletas
			If (vbACTpgs_PagoXTercero)
				$vl_vacio:=0
				GOTO RECORD:C242([ACT_Terceros:138];vlACTpgs_recNumTercero)
				ACTpgs_EmitirBoletasDocumentar (->aIDPagosDocumentar;->$vl_vacio;[ACT_Terceros:138]Id:1)
			Else 
				If ($unaXTotal=1)
					GOTO RECORD:C242([Personas:7];vlACTpgs_recNumApdo)
					ACTpgs_EmitirBoletasDocumentar (->aIDPagosDocumentar;->[Personas:7]No:1;0)
				End if 
			End if 
			  //ticket 161946 JVP 20160527
			If (cbImprimirRecPago=1)
				$b_mostrarAlerta:=True:C214
				QUERY WITH ARRAY:C644([ACT_Pagos:172]ID:1;$aIDPagosDocumentar)
				SET QUERY LIMIT:C395(1)  //20151005 RCH Hay bases que tienen duplicado el reporte...
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=Table:C252(->[ACT_Pagos:172]);*)
				QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26=atACT_Recibos{atACT_Recibos})
				SET QUERY LIMIT:C395(0)
				If (Records in selection:C76([xShell_Reports:54])=1)
					If ($b_mostrarAlerta)
						$r:=CD_Dlog (0;__ ("Por favor haga clic en el botón Lista cuando la impresora esté lista para imprimir ")+atACT_Recibos{atACT_Recibos}+".";"";__ ("Lista");__ ("Terminar sin imprimir"))
						If ($r=1)
							  //COPY NAMED SELECTION([ACT_Pagos];"◊Editions")
							CUT NAMED SELECTION:C334([ACT_Pagos:172];"◊Editions")  //20170315 RCH La selección se crea con CUT
							QR_ImprimeInformeSRP (Record number:C243([xShell_Reports:54]))
						End if 
					End if 
				Else 
					If ($b_mostrarAlerta)
						CD_Dlog (0;__ ("El modelo seleccionado ha sido eliminado por otro usuario. Intente la impresión más tarde."))
					End if 
				End if 
			End if 
			
			
			cbImprimirRecPago:=0
			cbImprimirBoletas:=0
			ACTpgs_ClearDlogVars 
			vsACT_RUTApoderado:=""
			vsACT_RUTTercero:=""
			vlACT_Cuotas:=10
			If (btn_tercero=1)
				GOTO OBJECT:C206(vsACT_RUTTercero)
			Else 
				GOTO OBJECT:C206(vsACT_RUTApoderado)
			End if 
			FLUSH CACHE:C297
			KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
			ACTpp_OpcionesCalculoMontos ("CalculaDesdeArreglosIdsApdoTerceros";->$vl_idApdo;->$vl_idTer)
			CANCEL:C270
			If (Process number:C372("Explorador AccountTrack")>0)
				<>vb_Refresh:=True:C214
			End if 
		End if 
	End if 
Else 
	BEEP:C151
End if 