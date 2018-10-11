//%attributes = {}
  //ACTpgs_EmitirBoletasDocumentar

C_POINTER:C301($ptr_idCatdDocTrib)
C_TEXT:C284($vt_observacion)
  //En $1 hay un puntero sobre un arreglo con los IDs de los pagos a boletear.
  //En $2 hay un puntero sobre el ID de la persona
  // según el número de elementos del arreglo con los ids de pagos serán las boletas que se emitirán

C_LONGINT:C283($IdApdo;$IdTercero)
C_POINTER:C301($1;$aIDsPago)
C_BOOLEAN:C305($5;$b_mostrarAlerta)
C_BLOB:C604($xBlob)
ARRAY LONGINT:C221($al_idCtaSeleccionada;0)

$b_mostrarAlerta:=True:C214
$montoAfectoTotal:=0
$montoNoAfectoTotal:=0
ARRAY LONGINT:C221($aTransaccionesAfectas;0)
ARRAY LONGINT:C221($aTransaccionesExentas;0)
$aIDsPago:=$1
$IdApdo:=$2->
$IdTercero:=$3
If (Count parameters:C259>=4)
	$vt_observacion:=$4
End if 
If (Count parameters:C259>=5)
	$b_mostrarAlerta:=$5
End if 
C_BOOLEAN:C305($b_noAbrirDTE)
If (Count parameters:C259>=6)
	$b_noAbrirDTE:=$6
End if 

ACTcfg_LoadConfigData (8)

ACTbol_CargaDiasVencimiento   //20161007 RCH

If ($IdTercero#0)
	$CatApdo:=ACTbol_GetDocTribFromTercero ($IdTercero)
	$ptr_id:=->[ACT_Terceros:138]Id:1
	$ptr_idCatdDocTrib:=->[ACT_Terceros:138]id_CatDocTrib:55
	$vl_idApoderado:=0
	$vl_idTercero:=$IdTercero
	
	$b_continuarDTE:=ACTbol_ValidaEmisionDTE ("idTercero";String:C10($vl_idTercero))
Else 
	$CatApdo:=ACTbol_GetDocTribFromPersona ($IdApdo)
	$ptr_id:=->[Personas:7]No:1
	$ptr_idCatdDocTrib:=->[Personas:7]ACT_DocumentoTributario:45
	$vl_idApoderado:=$IdApdo
	$vl_idTercero:=0
	
	$b_continuarDTE:=ACTbol_ValidaEmisionDTE ("idApoderado";String:C10($vl_idApoderado))
End if 
  //$allow:=ACTcfg_SearchCatDocs ($CatApdo)
  //$allow:=ACTbol_ValidaInicioEmision (1;$CatApdo)  //20150626 RCH Valida que se pueda iniciar la emisión
$allow:=ACTbol_ValidaInicioEmision (1;$CatApdo;(cbImprimirBoletas=1))  //20150706 RCH
$ID_modeloRecibo:=vlACT_ModRecibo

ARRAY REAL:C219($aMontosAfectosTotales;0)
ARRAY REAL:C219($aMontosNoAfectosTotales;0)
ARRAY TEXT:C222($at_transaccionesAfectas;0)
ARRAY TEXT:C222($at_transaccionesExentas;0)
  //ARRAY LONGINT($al_idCtasCtes;0)
ARRAY TEXT:C222($at_idCtasCtes;0)
ARRAY LONGINT:C221($al_idRazonSocial;0)

ARRAY LONGINT:C221($alACT_idsBoletas;0)

If (cbImprimirBoletas=1)
	If ($allow)
		
		If ([Personas:7]ACT_ReceptorDT_Tipo:112<3)  //20150323 RCH
			
			If ($b_continuarDTE)
				
				For ($s;1;Size of array:C274($aIDsPago->))
					AT_Initialize (->$al_idCtaSeleccionada;->$al_idRazonSocial)
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$aIDsPago->{$s})
					KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
					ARRAY LONGINT:C221($aRecNumCargos;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRecNumCargos;"")
					If (cb_EmiteXCuenta=1)
						AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_idCtaSeleccionada)
					Else 
						APPEND TO ARRAY:C911($al_idCtaSeleccionada;0)
					End if 
					If (cs_MultiRazones=1)
						ACTcfg_OpcionesRazonesSociales ("Selection2Array";->[ACT_Cargos:173]ID_RazonSocial:57;->$al_idRazonSocial)
					Else 
						APPEND TO ARRAY:C911($al_idRazonSocial;0)
					End if 
					For ($k;1;Size of array:C274($al_idRazonSocial))
						
						  //  //20130903 RCH
						  //ACTcfg_opcionesDTE ("EsEmisorElectronico";->$al_idRazonSocial{$k})
						ACTcfg_LeeConfRS ($al_idRazonSocial{$k})  //20161105 RCH
						
						For ($x;1;Size of array:C274($al_idCtaSeleccionada))
							
							If (cb_EmiteXCuenta=1)
								$id_cta:=$al_idCtaSeleccionada{$x}
							Else 
								$id_cta:=0
							End if 
							
							ACTbol_FiltraItemsCategoria ("ingresoPagos";"";$id_cta;$al_idRazonSocial{$k};$aIDsPago->{$s})
							
							
							
							For ($v;1;Size of array:C274(alACT_idsCategorias))
								alACT_idsCategorias{0}:=alACT_idsCategorias{$v}
								
								ACTbol_FiltraItemsMoneda ("ingresoPagos";"";$id_cta;$al_idRazonSocial{$k};$aIDsPago->{$s})
								
								For ($l_indiceMonedas;1;Size of array:C274(atACT_Monedas))
									atACT_Monedas{0}:=atACT_Monedas{$l_indiceMonedas}
									
									ACTbol_FiltraItemsResponsable ("ingresoPagos";"";$id_cta;$al_idRazonSocial{$k};$aIDsPago->{$s})
									
									For ($l_responsables;1;Size of array:C274(alACT_Responsables))  //20170712 RCH
										alACT_Responsables{0}:=alACT_Responsables{$l_responsables}
										
										$montoAfectoTotal:=0
										$montoNoAfectoTotal:=0
										ARRAY LONGINT:C221($aTransaccionesAfectas;0)
										ARRAY LONGINT:C221($aTransaccionesExentas;0)
										
										ACTbol_MontosFromPagos ($aIDsPago->{$s};->$aRecNumCargos;$id_cta;->$montoAfectoTotal;->$montoNoAfectoTotal;->$aTransaccionesAfectas;->$aTransaccionesExentas;$al_idRazonSocial{$k};(cb_EmiteXCuenta=1))
										UNLOAD RECORD:C212([ACT_Cargos:173])
										  //$vt_idcuentas:=String($al_idRazonSocial{$k})+";"+String($al_idCtaSeleccionada{$x})+";"+String(alACT_idsCategorias{$v})+";"+atACT_Monedas{$l_indiceMonedas}
										$vt_idcuentas:=String:C10($al_idRazonSocial{$k})+";"+String:C10($al_idCtaSeleccionada{$x})+";"+String:C10(alACT_idsCategorias{$v})+";"+atACT_Monedas{$l_indiceMonedas}+";"+String:C10(alACT_Responsables{$l_responsables})  //20170712 RCH
										  // JVP 20160907 167633 
										  //$el:=Find in array($at_idCtasCtes;String($al_idRazonSocial{$k})+";"+String($al_idCtaSeleccionada{$x}))
										$el:=Find in array:C230($at_idCtasCtes;$vt_idcuentas)
										If ($el=-1)
											APPEND TO ARRAY:C911($at_idCtasCtes;$vt_idcuentas)
											  // JVP 20160907 167633 
											  //APPEND TO ARRAY($at_idCtasCtes;String($al_idRazonSocial{$k})+";"+String($al_idCtaSeleccionada{$x})+";"+String(alACT_idsCategorias{$v}))
											APPEND TO ARRAY:C911($aMontosAfectosTotales;$montoAfectoTotal)
											APPEND TO ARRAY:C911($aMontosNoAfectosTotales;$montoNoAfectoTotal)
											APPEND TO ARRAY:C911($at_transaccionesAfectas;AT_array2text (->$aTransaccionesAfectas;";";"#########"))
											APPEND TO ARRAY:C911($at_transaccionesExentas;AT_array2text (->$aTransaccionesExentas;";";"#########"))
										Else 
											$aMontosAfectosTotales{$el}:=$aMontosAfectosTotales{$el}+$montoAfectoTotal
											$aMontosNoAfectosTotales{$el}:=$aMontosNoAfectosTotales{$el}+$montoNoAfectoTotal
											$at_transaccionesAfectas{$el}:=$at_transaccionesAfectas{$el}+";"+AT_array2text (->$aTransaccionesAfectas;";";"#########")
											$at_transaccionesExentas{$el}:=$at_transaccionesExentas{$el}+";"+AT_array2text (->$aTransaccionesExentas;";";"#########")
										End if 
									End for 
								End for 
							End for 
						End for 
					End for 
					
				End for 
				For ($i;1;Size of array:C274($at_idCtasCtes))
					ARRAY LONGINT:C221($aTransaccionesAfectas;0)
					ARRAY LONGINT:C221($aTransaccionesExentas;0)
					AT_Text2Array (->$aTransaccionesAfectas;$at_transaccionesAfectas{$i})
					AT_Text2Array (->$aTransaccionesExentas;$at_transaccionesExentas{$i})
					$aTransaccionesAfectas{0}:=0
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->$aTransaccionesAfectas;"=";->$DA_Return)
					For ($j;Size of array:C274($DA_Return);1;-1)
						AT_Delete ($DA_Return{$j};1;->$aTransaccionesAfectas)
					End for 
					$aTransaccionesExentas{0}:=0
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->$aTransaccionesExentas;"=";->$DA_Return)
					For ($j;Size of array:C274($DA_Return);1;-1)
						AT_Delete ($DA_Return{$j};1;->$aTransaccionesExentas)
					End for 
					CREATE EMPTY SET:C140([ACT_Boletas:181];"AImprimirAfectas")
					CREATE EMPTY SET:C140([ACT_Boletas:181];"AImprimirNoAfectas")
					If ($IdTercero#0)
						KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->$IdTercero)
					Else 
						KRL_FindAndLoadRecordByIndex ($ptr_id;->$IdApdo)
					End if 
					$vt_val:=$at_idCtasCtes{$i}
					$vl_razon:=Num:C11(ST_GetWord ($vt_val;1;";"))
					$vl_cuenta:=Num:C11(ST_GetWord ($vt_val;2;";"))
					$l_idCategoriaItems:=Num:C11(ST_GetWord ($vt_val;3;";"))
					$t_moneda:=ST_GetWord ($vt_val;4;";")
					$l_idResponsable:=Num:C11(ST_GetWord ($vt_val;5;";"))
					ACTcfg_SearchCatDocsByIndex ($ptr_idCatdDocTrib->;$vl_cuenta;$vl_razon)
					
					  //20130210 RCH Requerimiento Aleman Pto Montt
					  //If (<>gCountryCode="mx")
					  //If ((<>gCountryCode="mx") | (abACT_EmiteAfectoExento{Find in array(alACT_IDsCats;$CatApdo)}))
					
					$vl_razon:=Choose:C955(($vl_razon=0);-1;$vl_razon)
					
					  //20170109 RCH
					  //ACTdte_OpcionesManeja ("LeeBlob";->$vl_razon)
					ACTcfg_LeeConfRS ($vl_razon)  //20170109 RCH
					
					$b_emisorDTECLG:=ACTdte_EsEmisorColegium ($vl_razon)
					
					If ((<>gCountryCode="mx") | (abACT_EmiteAfectoExento{Find in array:C230(alACT_IDsCats;$CatApdo)}) | ($b_emisorDTECLG))
						ARRAY LONGINT:C221($al_transaccionesBol;0)
						C_REAL:C285($vr_MontoBol)
						$vr_MontoBol:=$aMontosAfectosTotales{$i}+$aMontosNoAfectosTotales{$i}
						AT_Union (->$aTransaccionesAfectas;->$aTransaccionesExentas;->$al_transaccionesBol)
						AT_Initialize (->$aTransaccionesExentas;->$aTransaccionesAfectas)
						
						$montoAfectoTotal:=$aMontosAfectosTotales{$i}
						
						If (cs_emisorElectronico=1)
							If ($montoAfectoTotal=0)
								$montoNoAfectoTotal:=$vr_MontoBol
								COPY ARRAY:C226($al_transaccionesBol;$aTransaccionesExentas)
								$vr_MontoBol:=0
							Else 
								$montoNoAfectoTotal:=0
								COPY ARRAY:C226($al_transaccionesBol;$aTransaccionesAfectas)
							End if 
						Else 
							
							$montoNoAfectoTotal:=$vr_MontoBol
							COPY ARRAY:C226($al_transaccionesBol;$aTransaccionesExentas)
							$vr_MontoBol:=0
							
						End if 
						
					Else 
						$vr_MontoBol:=$aMontosAfectosTotales{$i}
						$montoNoAfectoTotal:=$aMontosNoAfectosTotales{$i}
						  //$montoAfectoTotal:=0
						$montoAfectoTotal:=$aMontosAfectosTotales{$i}  //20140516 RCH Las boletas se emitian sin IVA
					End if 
					
					
					ARRAY OBJECT:C1221($ao_documentos;0)
					C_OBJECT:C1216($ob_Afecto;$ob_Exento;$ob_respuesta)
					C_BOOLEAN:C305($vb_boletaConError)
					
					ARRAY LONGINT:C221($al_transacciones;0)
					
					OB SET:C1220($ob_Afecto;"monto";$vr_MontoBol)
					OB SET ARRAY:C1227($ob_Afecto;"ids_transacciones";$aTransaccionesAfectas)
					OB SET ARRAY:C1227($ob_Afecto;"ids_transacciones_pagos";$al_transacciones)
					OB SET:C1220($ob_Afecto;"fecha";DTS_MakeFromDateTime (Current date:C33(*)))
					OB SET:C1220($ob_Afecto;"documento_afecto";True:C214)
					OB SET:C1220($ob_Afecto;"id_categoria";$CatApdo)
					OB SET:C1220($ob_Afecto;"id_documento";alACT_IDDT{vlACT_IndexAfecta1})
					OB SET:C1220($ob_Afecto;"tipo_documento";atACT_NombreDoc{vlACT_IndexAfecta1})
					OB SET:C1220($ob_Afecto;"id_apoderado";$idApdo)
					OB SET:C1220($ob_Afecto;"indice_configuracion";vlACT_IndexAfecta1)
					OB SET:C1220($ob_Afecto;"nombre_set";"AImprimirAfectas")
					OB SET:C1220($ob_Afecto;"asignar_folio";False:C215)
					OB SET:C1220($ob_Afecto;"monto_afecto";$montoAfectoTotal)
					OB SET:C1220($ob_Afecto;"id_tercero";$vl_idTercero)
					OB SET:C1220($ob_Afecto;"observacion";$vt_observacion)
					OB SET:C1220($ob_Afecto;"id_razon_social";$vl_razon)
					OB SET:C1220($ob_Afecto;"emitido_desde";3)
					OB SET:C1220($ob_Afecto;"razon_referencia";0)
					OB SET:C1220($ob_Afecto;"es_documento_publico_general";False:C215)
					OB SET:C1220($ob_Afecto;"categoria";$l_idCategoriaItems)
					OB SET:C1220($ob_Afecto;"moneda";$t_moneda)
					OB SET:C1220($ob_Afecto;"imprimir";True:C214)
					OB SET:C1220($ob_Afecto;"no_abrir_dte";$b_noAbrirDTE)
					OB SET:C1220($ob_Afecto;"apoderado_responsable";$l_idResponsable)
					
					$montoAfectoTotal:=0
					OB SET:C1220($ob_Exento;"monto";$montoNoAfectoTotal)
					OB SET ARRAY:C1227($ob_Exento;"ids_transacciones";$aTransaccionesExentas)
					OB SET ARRAY:C1227($ob_Exento;"ids_transacciones_pagos";$al_transacciones)
					OB SET:C1220($ob_Exento;"fecha";DTS_MakeFromDateTime (Current date:C33(*)))
					OB SET:C1220($ob_Exento;"documento_afecto";False:C215)
					OB SET:C1220($ob_Exento;"id_categoria";$CatApdo)
					OB SET:C1220($ob_Exento;"id_documento";alACT_IDDT{vlACT_IndexExenta1})
					OB SET:C1220($ob_Exento;"tipo_documento";atACT_NombreDoc{vlACT_IndexExenta1})
					OB SET:C1220($ob_Exento;"id_apoderado";$idApdo)
					OB SET:C1220($ob_Exento;"indice_configuracion";vlACT_IndexExenta1)
					OB SET:C1220($ob_Exento;"nombre_set";"AImprimirNoAfectas")
					OB SET:C1220($ob_Exento;"asignar_folio";False:C215)
					OB SET:C1220($ob_Exento;"monto_afecto";$montoAfectoTotal)
					OB SET:C1220($ob_Exento;"id_tercero";$vl_idTercero)
					OB SET:C1220($ob_Exento;"observacion";$vt_observacion)
					OB SET:C1220($ob_Exento;"id_razon_social";$vl_razon)
					OB SET:C1220($ob_Exento;"emitido_desde";3)
					OB SET:C1220($ob_Exento;"razon_referencia";0)
					OB SET:C1220($ob_Exento;"es_documento_publico_general";False:C215)
					OB SET:C1220($ob_Exento;"categoria";$l_idCategoriaItems)
					OB SET:C1220($ob_Exento;"moneda";$t_moneda)
					OB SET:C1220($ob_Exento;"imprimir";True:C214)
					OB SET:C1220($ob_Exento;"no_abrir_dte";$b_noAbrirDTE)
					OB SET:C1220($ob_Exento;"apoderado_responsable";$l_idResponsable)
					
					APPEND TO ARRAY:C911($ao_documentos;$ob_Afecto)
					APPEND TO ARRAY:C911($ao_documentos;$ob_Exento)
					ARRAY LONGINT:C221($al_idsBoletasEmitidas;0)
					$ob_respuesta:=ACTbol_CreaDTObj (->$ao_documentos;->$al_idsBoletasEmitidas)
					
					$vb_boletaConError:=OB Get:C1224($ob_respuesta;"error_validacion")
					For ($l_boletas;1;Size of array:C274($al_idsBoletasEmitidas))
						APPEND TO ARRAY:C911($alACT_idsBoletas;$al_idsBoletasEmitidas{$l_boletas})
					End for 
					
					If ($vb_boletaConError)
						If ($b_mostrarAlerta)
							CD_Dlog (0;__ ("Ocurrió un problema al emitir los documentos para ")+Choose:C955($vl_idApoderado#0;KRL_GetTextFieldData (->[Personas:7]No:1;$ptr_id;->[Personas:7]Apellidos_y_nombres:30);KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;$ptr_id;->[ACT_Terceros:138]Nombre_Completo:9))+". "+"El proceso fue interrumpido."+" "+"Intente nuevamente. Se emitirán recibos como respaldo.")
							cbImprimirRecPago:=1
						End if 
						$i:=Size of array:C274($at_idCtasCtes)
					End if 
				End for 
				
				
				
			Else 
				If ($b_mostrarAlerta)
					CD_Dlog (0;__ ("Los apoderados y/o terceros asociados a los documentos a emitir, tienen datos de dirección, comuna y ciudad incompletos. No es posible emitir el documento tributario. Se emitirán recibos como respaldo."))
					cbImprimirRecPago:=1
				End if 
			End if 
			
		Else 
			If ($b_mostrarAlerta)
				CD_Dlog (0;__ ("El apoderado tiene la propiedad no emitir Documentos Tributarios marcada. Se emitirán recibos como respaldo."))
				cbImprimirRecPago:=1
			End if 
		End if 
		
	Else 
		If ($b_mostrarAlerta)
			CD_Dlog (0;__ ("La categoría de documentos tributarios no tiene todas las definiciones de documentos. Se emitirán recibos como respaldo."))
			cbImprimirRecPago:=1
		End if 
	End if 
End if 

  //20111116 RCH genera archivo cfdi automaticamente
ACTcfdi_OpcionesGenerales ("GeneraArchivoIngresoPago";->$alACT_idsBoletas)