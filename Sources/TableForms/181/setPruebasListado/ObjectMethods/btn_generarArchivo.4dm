  //If (vlACT_apoderadoID#0)
USE CHARACTER SET:C205("latin1";0)
C_LONGINT:C283($vl_col;$vl_line;$vl_inc)
C_POINTER:C301($vy_var)
C_REAL:C285($vr_descuento)
C_BOOLEAN:C305(bACT_setDePruebas)
C_LONGINT:C283($index)

bACT_setDePruebas:=True:C214

LISTBOX GET CELL POSITION:C971(lb_listadoSet;$vl_col;$vl_line;$vy_var)

ARRAY LONGINT:C221($DA_Return;0)
lb_listadoSet{0}:=True:C214
$l_numero:=AT_SearchArray (->lb_listadoSet;"=";->$DA_Return)
If ($l_numero=1)
	If ($vl_line>0)
		
		ACTcfg_LoadConfigData (8)  //20150807 RCH
		
		$vt_pref:=atACT_Text{$vl_line}
		ACTdte_setPruebasOpcionesGen ("DesarmaBlob";->$vt_pref)
		
		  //ARRAY TEXT($at_rut;0)
		  //APPEND TO ARRAY($at_rut;"222222222")
		  //APPEND TO ARRAY($at_rut;"333333333")
		  //APPEND TO ARRAY($at_rut;"444444444")
		  //APPEND TO ARRAY($at_rut;"555555555")
		  //APPEND TO ARRAY($at_rut;"666666666")
		  //APPEND TO ARRAY($at_rut;"777777777")
		  //APPEND TO ARRAY($at_rut;"888888888")
		  //APPEND TO ARRAY($at_rut;"999999999")
		  //Case of 
		  //: ((atACT_Caso{$vl_line}="108404-1") | (atACT_Caso{$vl_line}="108404-5") | (atACT_Caso{$vl_line}="108404-8"))
		  //$vl_inc:=1
		  //: ((atACT_Caso{$vl_line}="108404-2") | (atACT_Caso{$vl_line}="108404-6"))
		  //$vl_inc:=2
		  //: ((atACT_Caso{$vl_line}="108404-3") | (atACT_Caso{$vl_line}="108404-7"))
		  //$vl_inc:=3
		  //: (atACT_Caso{$vl_line}="108404-4")
		  //$vl_inc:=4
		  //Else 
		  //
		  //End case 
		
		  //KRL_FindAndLoadRecordByIndex (->[Personas]No;->vlACT_apoderadoID;True)
		  //[Personas]RUT:=$at_rut{$vl_inc}
		  //SAVE RECORD([Personas])
		  //KRL_UnloadReadOnly (->[Personas])
		
		If (vlACT_terceroID#0)
			$b_continuarDTE:=ACTbol_ValidaEmisionDTE ("idTercero";String:C10(vlACT_terceroID))
		Else 
			$b_continuarDTE:=ACTbol_ValidaEmisionDTE ("idApoderado";String:C10(vlACT_apoderadoID))
		End if 
		
		If ($b_continuarDTE)
			
			If ((vlACT_apoderadoID#0) | (vlACT_terceroID#0))
				READ WRITE:C146([ACT_Boletas:181])
				
				If (vlACT_idBoleta#0)
					QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=vlACT_idBoleta)
					If ([ACT_Boletas:181]Nula:15)
						vlACT_idBoleta:=0
					End if 
				End if 
				
				$b_continuar:=True:C214
				
				If (vlACT_idBoleta=0)
					CREATE RECORD:C68([ACT_Boletas:181])
					[ACT_Boletas:181]ID:1:=SQ_SeqNumber (->[ACT_Boletas:181]ID:1)
					[ACT_Boletas:181]EmitidoPor:17:=<>tUSR_CurrentUser
					[ACT_Boletas:181]ID_RazonSocial:25:=vlACT_RSSel
					
					[ACT_Boletas:181]codigo_SII:33:=ST_GetWord (at_tipoDocumento{at_tipoDocumento};1;":")
					Case of 
						: (([ACT_Boletas:181]codigo_SII:33="39") | ([ACT_Boletas:181]codigo_SII:33="41"))
							[ACT_Boletas:181]ID_Categoria:12:=-1
						: (([ACT_Boletas:181]codigo_SII:33="34") | ([ACT_Boletas:181]codigo_SII:33="33"))
							[ACT_Boletas:181]ID_Categoria:12:=-3
						: ([ACT_Boletas:181]codigo_SII:33="61")
							[ACT_Boletas:181]ID_Categoria:12:=-4
						: ([ACT_Boletas:181]codigo_SII:33="56")
							[ACT_Boletas:181]ID_Categoria:12:=-5
					End case 
					  //buscar CAF
					$Proxima:=Num:C11(ACTfol_OpcionesGenerales ("ObtieneProximoFolio";->$index))
					If ($Proxima>0)
						
						[ACT_Boletas:181]ID_CAF:43:=$Proxima
						
						vlACT_idBoleta:=[ACT_Boletas:181]ID:1
						$vt_pref:=atACT_Text{$vl_line}
						vbACT_editaCaso:=True:C214
						ACTdte_setPruebasOpcionesGen ("GuardaCaso")
						vbACT_editaCaso:=False:C215
						ACTdte_setPruebasOpcionesGen ("DesarmaBlob";->$vt_pref)
						
					Else 
						If ($Proxima=-2)
							If (vbACT_noHayCAF)
								CD_Dlog (0;"No hay código de autorización de folios para el documento a emitir.")
							End if 
						End if 
						$b_continuar:=False:C215
					End if 
				Else 
					QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=vlACT_idBoleta)
					If (Records in selection:C76([ACT_Boletas:181])=0)
						CREATE RECORD:C68([ACT_Boletas:181])
						[ACT_Boletas:181]ID:1:=SQ_SeqNumber (->[ACT_Boletas:181]ID:1)
						[ACT_Boletas:181]EmitidoPor:17:=<>tUSR_CurrentUser
						vlACT_idBoleta:=[ACT_Boletas:181]ID:1
						$vt_pref:=atACT_Text{$vl_line}
						vbACT_editaCaso:=True:C214
						ACTdte_setPruebasOpcionesGen ("GuardaCaso")
						vbACT_editaCaso:=False:C215
						ACTdte_setPruebasOpcionesGen ("DesarmaBlob";->$vt_pref)
					End if 
				End if 
				  //If ([ACT_Boletas]DTE_id_estado=4)
				
				If ($b_continuar=True:C214)
					If ([ACT_Boletas:181]DTE_estado_id:24 ?? 3)
						  // boleta ya generada y enviada a DTENET. Ya se recibio el FOLIO
						CD_Dlog (0;"Documento ya enviado.")
						TRACE:C157
						
						  //End if 
						  //  //If ([ACT_Boletas]DTE_id_estado#4)
						  //If ([ACT_Boletas]DTE_id_estado#4)
					Else 
						
						  //[ACT_Boletas]FechaEmision:=!01-12-2014!sw
						[ACT_Boletas:181]FechaEmision:3:=Current date:C33(*)
						[ACT_Boletas:181]AfectaIVA:9:=(vr_iva>0)
						[ACT_Boletas:181]Monto_Total:6:=vr_total
						If (vr_iva#0)
							$vb_value:=True:C214
							[ACT_Boletas:181]Monto_Afecto:4:=AT_GetSumArrayByArrayPos (->$vb_value;"=";->abACT_afecto;->arACT_total)
							If (vrACTdte_DescuentoAfecto#0)
								[ACT_Boletas:181]Monto_Afecto:4:=Round:C94([ACT_Boletas:181]Monto_Afecto:4+Round:C94([ACT_Boletas:181]Monto_Afecto:4*(vrACTdte_DescuentoAfecto/100);<>vlACT_Decimales);<>vlACT_Decimales)
							End if 
							[ACT_Boletas:181]Monto_IVA:5:=vr_iva
							[ACT_Boletas:181]TasaIVA:16:=<>vrACT_TasaIVA
						Else 
							[ACT_Boletas:181]Monto_Afecto:4:=0
							[ACT_Boletas:181]Monto_IVA:5:=0
							[ACT_Boletas:181]TasaIVA:16:=0
						End if 
						$vb_value:=False:C215
						[ACT_Boletas:181]Monto_Exento:30:=AT_GetSumArrayByArrayPos (->$vb_value;"=";->abACT_afecto;->arACT_total)
						If (vrACTdte_DescuentoExento#0)
							[ACT_Boletas:181]Monto_Exento:30:=Round:C94([ACT_Boletas:181]Monto_Exento:30+Round:C94([ACT_Boletas:181]Monto_Exento:30*(vrACTdte_DescuentoExento/100);<>vlACT_Decimales);<>vlACT_Decimales)
						End if 
						  //[ACT_Boletas]ID_Categoria:=0 //el id de categoria es asignado mas arriba
						
						[ACT_Boletas:181]ID_Documento:13:=0
						$vt_tipoDoc:=ST_GetWord (at_tipoDocumento{at_tipoDocumento};2;":")
						[ACT_Boletas:181]TipoDocumento:7:=Substring:C12($vt_tipoDoc;2;Length:C16($vt_tipoDoc))
						[ACT_Boletas:181]ID_Apoderado:14:=vlACT_apoderadoID
						[ACT_Boletas:181]ID_Tercero:21:=vlACT_terceroID
						  //[ACT_Boletas]Observacion:="DOCUMENTO DEL SET DE PRUEBAS"
						[ACT_Boletas:181]Emitido_desde:27:=3
						  //[ACT_Boletas]DTE_id_estado:=1  // para envio inmediato
						[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 0
						[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 1  //
						[ACT_Boletas:181]documento_electronico:29:=True:C214
						[ACT_Boletas:181]codigo_referencia:31:=atACT_referencia
						[ACT_Boletas:181]Referencia_Razon:40:=vt_razonReferencia
						[ACT_Boletas:181]Observacion:18:=vt_razonReferencia
						
						  //[ACT_Boletas]ID_DctoAsociado:=Num(PREF_fGet (0;"ACT_DTE_IDBOL_CASO_"+atACT_Caso2{atACT_Caso2};"0"))
						If (vt_referencia#"")
							[ACT_Boletas:181]ID_DctoAsociado:19:=Num:C11(PREF_fGet (0;"ACT_DTE_IDBOL_CASO_"+vt_referencia;"0"))
							If ([ACT_Boletas:181]ID_DctoAsociado:19=0)
								TRACE:C157
							End if 
						Else 
							[ACT_Boletas:181]ID_DctoAsociado:19:=0
						End if 
						$vl_idBoleta:=[ACT_Boletas:181]ID:1
						[ACT_Boletas:181]ID_Estado:20:=7
						[ACT_Boletas:181]Estado:2:=ACTbol_RetornaEstado ("RetornaEstadoTexto";->[ACT_Boletas:181]ID_Estado:20)
						  //ACTdte_GeneraArchivo ("LoadRS")
						ACTdte_GeneraArchivo ("LoadRS";->[ACT_Boletas:181]ID_RazonSocial:25)  //20151020 RCH
						[ACT_Boletas:181]CL_acteco:28:=[ACT_RazonesSociales:279]codigo_actividad_economica:6
						
						SAVE RECORD:C53([ACT_Boletas:181])
						
						  //ARRAY REAL(arACT_decuentos;0)
						  //ARRAY REAL(arACT_recargos;0)
						  //AT_RedimArrays(Size of array(atACT_item);->arACT_decuentos;->arACT_recargos)
						
						ARRAY REAL:C219($arACT_Descuento;0)
						AT_RedimArrays (Size of array:C274(arACT_total);->$arACT_Descuento)
						For ($i;Size of array:C274(arACT_descuento);1;-1)
							$vr_descto:=arACT_descuento{$i}
							$vb_afecto:=abACT_afecto{$i}
							If ($vr_descto#0)
								arACT_total{$i}:=Round:C94(arACT_cantidad{$i}*arACT_valorUnitario{$i};<>vlACT_Decimales)
								$vr_descuento:=Round:C94(arACT_total{$i}*(arACT_descuento{$i}/100);<>vlACT_Decimales)
								  //  //arACT_total{$i}:=Round(arACT_total{$i}-$vr_descuento;<>vlACT_Decimales)
								$arACT_Descuento{$i}:=$vr_descuento
								
								  //20151030 RCH Comento porque se estaban generando mal los dte con lines de detalle...
								  //$vl_pos:=$i+1
								  //AT_Insert ($vl_pos;1;->atACT_item;->abACT_afecto;->arACT_cantidad;->arACT_valorUnitario;->arACT_descuento;->arACT_total;->$arACT_Descuento;->atACT_unidadMedida)
								  //atACT_item{$vl_pos}:="Descuento"
								  //arACT_cantidad{$vl_pos}:=1
								  //arACT_valorUnitario{$vl_pos}:=$vr_descuento
								  //arACT_descuento{$vl_pos}:=0
								  //arACT_total{$vl_pos}:=Abs($vr_descuento)*-1
								  //abACT_afecto{$vl_pos}:=$vb_afecto
							End if 
						End for 
						$vrACTdte_dctoRecargo:=vrACTdte_dctoRecargo
						ARRAY LONGINT:C221($alACT_ids;Size of array:C274(atACT_item))
						ACTdte_GeneraArchivo ("LlenaVariablesDetalle";->atACT_item;->arACT_total;->arACT_cantidad;->arACT_valorUnitario;->abACT_afecto;->$arACT_Descuento;->$alACT_ids;->atACT_unidadMedida)
						vrACTdte_dctoRecargo:=$vrACTdte_dctoRecargo
						
						KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14)
						$vt_idTipoSII:=ST_GetWord (at_tipoDocumento{at_tipoDocumento};1;":")
						Case of 
							: (($vt_idTipoSII="33") | ($vt_idTipoSII="34") | ($vt_idTipoSII="52") | ($vt_idTipoSII="56") | ($vt_idTipoSII="61"))
								$vt_retorno:=ACTdte_GeneraArchivo ("GeneraDctoFactura";->$vt_idTipoSII)
								
							: (($vt_idTipoSII="39") | ($vt_idTipoSII="41"))
								$vt_retorno:=ACTdte_GeneraArchivo ("GeneraDctoBoleta";->$vt_idTipoSII)
								
						End case 
						
						  //$vt_retorno:=ACTdte_GeneraArchivo ("EscribePesoEnNombre";->$vt_retorno) //20140809 RCH DTE
						
						  //KRL_FindAndLoadRecordByIndex (->[ACT_Boletas]ID;->$vl_idBoleta;True)
						  //DELETE RECORD([ACT_Boletas])
						
						$vl_procesados:=ACTdte_EmiteDocumento ([ACT_Boletas:181]ID:1;$vt_retorno)
						
						If ($vl_procesados=0)
							CD_Dlog (0;"Documento no procesado")
						End if 
						
						
						KRL_UnloadReadOnly (->[ACT_Boletas:181])
						ACTdte_setPruebasOpcionesGen ("InitVars")
					End if 
					
					KRL_UnloadReadOnly (->[ACT_Boletas:181])
				End if 
				
				
			Else 
				CD_Dlog (0;"Antes de generar el archivo debe asociar un apoderado a cada documento.")
			End if 
			
		Else 
			CD_Dlog (0;__ ("Los apoderados y/o terceros asociados a los documentos a emitir, tienen datos de dirección, comuna y ciudad incompletos. No es posible emitir el documento tributario."))
		End if 
	End if 
Else 
	CD_Dlog (0;"Envíen uno a uno los documentos.")
End if 
USE CHARACTER SET:C205(*;0)

bACT_setDePruebas:=False:C215
  //Else 
  //CD_Dlog (0;"Antes de generar el archivo debe seleccionar a un apoderado para asociar los documentos a emitir.")
  //End if 