//%attributes = {}
  //ACTbol_CreaDTObj

C_OBJECT:C1216($ob;$ob_respuesta;$0)
C_POINTER:C301($1;$2)
C_BOOLEAN:C305($b_errorValidacion)

ARRAY LONGINT:C221($al_idsBoletasAfectas;0)
ARRAY LONGINT:C221($al_idsBoletasExentas;0)

C_REAL:C285($r_monto;$r_montoAfecto)
ARRAY LONGINT:C221($al_idsTransacciones;0)
ARRAY LONGINT:C221($al_idsTransaccionesPagos;0)
C_DATE:C307($d_fechaDoc)
C_TEXT:C284($t_fecha;$t_nombreDocumento;$t_nombreSet;$t_observacion;$t_monedaDocumento)
C_BOOLEAN:C305($b_documentoAfecto;$b_asignaFolio;$b_docPublicoGeneral;$b_imprimir;$b_noAbrirDTE)
C_LONGINT:C283($l_idCategoria;$l_idDocumento;$l_idApoderado;$l_indiceConf;$l_idTercero;$l_idRS;$l_emitidoDesde;$l_razonReferencia)
C_LONGINT:C283($l_idCategoriaDocumento)

C_BOOLEAN:C305($vb_validaT)
C_LONGINT:C283($l_idBoleta)
C_BLOB:C604($xBlob)
C_BOOLEAN:C305($ok;$b_errorCredito;$b_errorDebito)

C_LONGINT:C283($l_idApdoResp)

C_LONGINT:C283($vl_retorno)

For ($l_indiceObjs;1;Size of array:C274($1->))
	$ob:=$1->{$l_indiceObjs}
	
	$r_monto:=OB Get:C1224($ob;"monto")
	OB GET ARRAY:C1229($ob;"ids_transacciones";$al_idsTransacciones)
	OB GET ARRAY:C1229($ob;"ids_transacciones_pagos";$al_idsTransaccionesPagos)
	$t_fecha:=OB Get:C1224($ob;"fecha")
	$d_fechaDoc:=DTS_GetDate ($t_fecha)
	$b_documentoAfecto:=OB Get:C1224($ob;"documento_afecto")
	$l_idCategoria:=OB Get:C1224($ob;"id_categoria")
	$l_idDocumento:=OB Get:C1224($ob;"id_documento")
	$t_nombreDocumento:=OB Get:C1224($ob;"tipo_documento")
	$l_idApoderado:=OB Get:C1224($ob;"id_apoderado")
	$l_indiceConf:=OB Get:C1224($ob;"indice_configuracion")
	$t_nombreSet:=OB Get:C1224($ob;"nombre_set")
	$b_asignaFolio:=OB Get:C1224($ob;"asignar_folio")
	$r_montoAfecto:=OB Get:C1224($ob;"monto_afecto")
	$l_idTercero:=OB Get:C1224($ob;"id_tercero")
	$t_observacion:=OB Get:C1224($ob;"observacion")
	$l_idRS:=OB Get:C1224($ob;"id_razon_social")
	$l_emitidoDesde:=OB Get:C1224($ob;"emitido_desde")
	$l_razonReferencia:=OB Get:C1224($ob;"razon_referencia")
	$b_docPublicoGeneral:=OB Get:C1224($ob;"es_documento_publico_general")
	$l_idCategoriaDocumento:=OB Get:C1224($ob;"categoria")
	$t_monedaDocumento:=OB Get:C1224($ob;"moneda")
	$b_imprimir:=OB Get:C1224($ob;"imprimir")
	$b_noAbrirDTE:=OB Get:C1224($ob;"no_abrir_dte")
	$l_idApdoResp:=OB Get:C1224($ob;"apoderado_responsable")
	
	If (Not:C34($b_imprimir))
		START TRANSACTION:C239
	End if 
	
	$vb_validaT:=False:C215
	$l_idBoleta:=ACTbol_CreateRecord (Size of array:C274($al_idsTransacciones);$r_monto;$d_fechaDoc;$b_documentoAfecto;$l_idCategoria;$l_idDocumento;$t_nombreDocumento;$l_idApoderado;$l_indiceConf;$t_nombreSet;$b_asignaFolio;$r_montoAfecto;$l_idTercero;$t_observacion;$l_idRS;$l_emitidoDesde;$l_razonReferencia;$b_docPublicoGeneral;$l_idCategoriaDocumento;$t_monedaDocumento;$l_idApdoResp)
	If ($l_idBoleta>=0)
		If ($l_idBoleta>0)
			
			  //asigna a transacciones credito
			If (Size of array:C274($al_idsTransacciones)>0)
				BLOB_Variables2Blob (->$xBlob;0;->$l_idBoleta;->$al_idsTransacciones)
			End if 
			
			If ($b_imprimir)
				If ($b_noAbrirDTE)
					r_abrirDTEAlIngresarPago:=0
				End if 
				$vl_retorno:=ACTbol_PrintBoletasVR ($t_nombreSet;False:C215;$l_idDocumento;False:C215;True:C214;0;->$xBlob;r_generaDTEAlIngresarPago;r_abrirDTEAlIngresarPago;r_enviarDTEAlIngresarPago)
				If ($vl_retorno#1)
					$b_errorValidacion:=True:C214
					If ($vl_retorno#-5)
						$ReadOnlyBoletas:=Read only state:C362([ACT_Boletas:181])
						READ WRITE:C146([ACT_Boletas:181])
						KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$l_idBoleta;True:C214)
						KRL_DeleteRecord (->[ACT_Boletas:181])
						KRL_ResetPreviousRWMode (->[ACT_Boletas:181];$ReadOnlyBoletas)
					End if 
				Else 
					ACTbol_RegisterEvt ($t_nombreSet)
				End if 
				
			Else 
				  //asocia a transacciones debito
				$ok:=ACTtra_AsignaIdBoleta ($xBlob)
				If ($ok)
					If (Size of array:C274($al_idsTransaccionesPagos)>0)
						SET BLOB SIZE:C606($xBlob;0)
						BLOB_Variables2Blob (->$xBlob;0;->$l_idBoleta;->$al_idsTransaccionesPagos)
						$ok:=ACTtra_AsignaIdBoleta4Pago ($xBlob)
						If (Not:C34($ok))
							$b_errorDebito:=True:C214
						End if 
						REDUCE SELECTION:C351([ACT_Transacciones:178];0)
						KRL_UnloadReadOnly (->[ACT_Transacciones:178])
					End if 
				Else 
					$b_errorCredito:=True:C214
				End if 
				
				  //verifica emision de documento
				If ($ok)
					If (ACTbol_ValidaEmisionDT ($l_idBoleta))
						$vb_validaT:=True:C214
						
					Else 
						$b_errorValidacion:=True:C214
						$vl_retorno:=-6  //del -1 al -5 se responde en ACTbol_PrintBoletasVR
					End if 
				End if 
				
				If ($vb_validaT)
					VALIDATE TRANSACTION:C240
				Else 
					CANCEL TRANSACTION:C241
				End if 
				
			End if 
			
		End if 
	Else 
		$b_errorValidacion:=True:C214
		Case of 
			: ($l_idBoleta=-1)
				$vl_retorno:=-7  //del -1 al -5 se responde en ACTbol_PrintBoletasVR
			: ($l_idBoleta=-2)
				$vl_retorno:=-8  //del -1 al -5 se responde en ACTbol_PrintBoletasVR
		End case 
	End if 
	
	If ($b_errorValidacion)
		$l_indiceObjs:=Size of array:C274($1->)
	Else 
		If ($l_idBoleta>0)
			
			If ($b_docPublicoGeneral)
				  //log publico general
				LOG_RegisterEvt ("Documento Tributario tipo: "+$t_nombreDocumento+", folio: "+String:C10(KRL_GetNumericFieldData (->[ACT_Boletas:181]ID:1;->$l_idBoleta;->[ACT_Boletas:181]Numero:11))+" emitido para público general. Pagos asociados: "+AT_array2text (->$al_idsTransaccionesPagos;", ";"#########")+".")
			End if 
			
			If ($b_documentoAfecto)
				APPEND TO ARRAY:C911($al_idsBoletasAfectas;$l_idBoleta)
			Else 
				APPEND TO ARRAY:C911($al_idsBoletasExentas;$l_idBoleta)
			End if 
			
		End if 
		
	End if 
End for 

  //genera respuesta
OB SET ARRAY:C1227($ob_respuesta;"ids_boletas_emitidas_afectas";$al_idsBoletasAfectas)
OB SET ARRAY:C1227($ob_respuesta;"ids_boletas_emitidas_exentas";$al_idsBoletasExentas)
OB SET:C1220($ob_respuesta;"error_validacion";$b_errorValidacion)
OB SET:C1220($ob_respuesta;"num_error_validacion";$vl_retorno)

  //llena arreglo con ids de dt emitidos
C_LONGINT:C283($i)
ARRAY LONGINT:C221($2->;0)
AT_Union (->$al_idsBoletasAfectas;->$al_idsBoletasExentas;$2)

$0:=$ob_respuesta