//%attributes = {}
  //ACTbol_EmitirDocumentos4Pagos

C_BLOB:C604($xBlob)
C_BOOLEAN:C305(vbACT_RegistrarIDSBoletas)

If (False:C215)
	C_OBJECT:C1216(ACTbol_EmitirDocumentos4Pagos ;$0)
	C_TEXT:C284(ACTbol_EmitirDocumentos4Pagos ;$1)
	C_TEXT:C284(ACTbol_EmitirDocumentos4Pagos ;$2)
	C_TEXT:C284(ACTbol_EmitirDocumentos4Pagos ;$3)
	C_REAL:C285(ACTbol_EmitirDocumentos4Pagos ;$4)
	C_REAL:C285(ACTbol_EmitirDocumentos4Pagos ;$5)
	C_REAL:C285(ACTbol_EmitirDocumentos4Pagos ;$6)
	C_REAL:C285(ACTbol_EmitirDocumentos4Pagos ;$7)
	C_TEXT:C284(ACTbol_EmitirDocumentos4Pagos ;$8)
	C_TEXT:C284(ACTbol_EmitirDocumentos4Pagos ;$9)
	C_REAL:C285(ACTbol_EmitirDocumentos4Pagos ;$10)
End if 

$SetdePagos:=$1
$DocAfecto:=$2
$DocExcento:=$3
$proximaAfecta:=$4
$proximaExcenta:=$5
$IndexAfecto:=$6
$IndexExcento:=$7
$setAfecto:=$8
$setExcento:=$9
$IDCat:=$10

$idAfecto:=alACT_IDDT{$IndexAfecto}
$idExento:=alACT_IDDT{$IndexExcento}
  //$emitidas:=0

USE SET:C118($SetdePagos)
ARRAY LONGINT:C221($aRecNumPagos;0)
ARRAY LONGINT:C221($alACT_idsPagos;0)

  //LONGINT ARRAY FROM SELECTION([ACT_Pagos];$aRecNumPagos)
SELECTION TO ARRAY:C260([ACT_Pagos:172];$aRecNumPagos;[ACT_Pagos:172]ID:1;$alACT_idsPagos)
$montoAfectoTotal:=0
$montoNoAfectoTotal:=0
$pagoSinBoletaAfecto:=0
$pagoSinBoletaExento:=0
ARRAY LONGINT:C221($al_transaccionesAfectas;0)
ARRAY LONGINT:C221($al_transaccionesExentas;0)
For ($i;1;Size of array:C274($aRecNumPagos))
	GOTO RECORD:C242([ACT_Pagos:172];$aRecNumPagos{$i})
	If (e3=0)
		$idApdo:=[ACT_Pagos:172]ID_Apoderado:3
		$id_Tercero:=0
	Else 
		$idApdo:=0
		$id_Tercero:=[ACT_Pagos:172]ID_Tercero:26
	End if 
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	ARRAY LONGINT:C221($aRecNumCargos;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRecNumCargos;"")
	If (e2=1)
		$id_cta:=al_idSeleccionado{0}
	Else 
		$id_cta:=0
	End if 
	$vl_id_RazonSocial:=al_idRazonSocial{0}
	ACTbol_MontosFromPagos ([ACT_Pagos:172]ID:1;->$aRecNumCargos;$id_cta;->$montoAfectoTotal;->$montoNoAfectoTotal;->$al_transaccionesAfectas;->$al_transaccionesExentas;$vl_id_RazonSocial;(e2=1))
End for 
UNLOAD RECORD:C212([ACT_Cargos:173])
  //20130210 RCH Requerimiento Aleman Pto Montt
  //If (<>gCountryCode="mx")
  //If ((<>gCountryCode="mx") | (abACT_EmiteAfectoExento{Find in array(alACT_IDsCats;$IDCat)}))
$vl_id_RazonSocial:=Choose:C955(($vl_id_RazonSocial=0);-1;$vl_id_RazonSocial)
$b_emisorDTECLG:=ACTdte_EsEmisorColegium ($vl_id_RazonSocial)

  //If ((<>gCountryCode="mx") | (abACT_EmiteAfectoExento{Find in array(alACT_IDsCats;$IDCat)}) | (KRL_GetBooleanFieldData (->[ACT_RazonesSociales]id;->$vl_id_RazonSocial;->[ACT_RazonesSociales]emisor_electronico)))
If ((<>gCountryCode="mx") | (abACT_EmiteAfectoExento{Find in array:C230(alACT_IDsCats;$IDCat)}) | ($b_emisorDTECLG))
	ARRAY LONGINT:C221($al_transaccionesBol;0)
	C_REAL:C285($vr_MontoBol)
	$vr_MontoBol:=$montoAfectoTotal+$montoNoAfectoTotal
	AT_Union (->$al_transaccionesAfectas;->$al_transaccionesExentas;->$al_transaccionesBol)
	AT_Initialize (->$al_transaccionesExentas;->$al_transaccionesAfectas)
	  //COPY ARRAY($al_transaccionesBol;$al_transaccionesExentas)
	  //$montoNoAfectoTotal:=$vr_MontoBol
	$montoAfectoTotalBolE:=$montoAfectoTotal
	If (cs_emisorElectronico=1)  //20130903 RCH
		If ($montoAfectoTotal=0)  //20130729 RCH para emitir un dcto afecto cuando hay cargos afectos
			COPY ARRAY:C226($al_transaccionesBol;$al_transaccionesExentas)
			$montoNoAfectoTotal:=$vr_MontoBol
		Else 
			COPY ARRAY:C226($al_transaccionesBol;$al_transaccionesAfectas)
			$montoAfectoTotal:=$vr_MontoBol
		End if 
	Else 
		
		$montoNoAfectoTotal:=$vr_MontoBol
		$montoAfectoTotal:=0
		COPY ARRAY:C226($al_transaccionesBol;$al_transaccionesExentas)
		$vr_MontoBol:=0
		
	End if 
Else 
	  //$montoAfectoTotalBolE:=0
	$montoAfectoTotalBolE:=$montoAfectoTotal  //20140516 RCH Las boletas se emitian sin IVA
	
End if 

  //$emitidas:=0

  //20150325 RCH Si el proceso era iniciado desde 2 maquinas diferentes, el folio se podría duplicar.
While (Semaphore:C143("CreacionDT"))
	DELAY PROCESS:C323(Current process:C322;20)
End while 

ARRAY OBJECT:C1221($ao_documentos;0)
C_OBJECT:C1216($ob_Afecto;$ob_Exento;$ob_respuesta)
C_BOOLEAN:C305($b_boletaConError)

ARRAY LONGINT:C221($al_transacciones;0)

OB SET:C1220($ob_Afecto;"monto";$montoAfectoTotal)
OB SET ARRAY:C1227($ob_Afecto;"ids_transacciones";$al_transaccionesAfectas)
OB SET ARRAY:C1227($ob_Afecto;"ids_transacciones_pagos";$al_transacciones)
OB SET:C1220($ob_Afecto;"fecha";DTS_MakeFromDateTime (vdACT_FEmisionBol))
OB SET:C1220($ob_Afecto;"documento_afecto";True:C214)
OB SET:C1220($ob_Afecto;"id_categoria";$IDCat)
OB SET:C1220($ob_Afecto;"id_documento";$idAfecto)
OB SET:C1220($ob_Afecto;"tipo_documento";$DocAfecto)
OB SET:C1220($ob_Afecto;"id_apoderado";$idApdo)
OB SET:C1220($ob_Afecto;"indice_configuracion";$IndexAfecto)
OB SET:C1220($ob_Afecto;"nombre_set";$setAfecto)
OB SET:C1220($ob_Afecto;"asignar_folio";True:C214)
OB SET:C1220($ob_Afecto;"monto_afecto";$montoAfectoTotalBolE)
OB SET:C1220($ob_Afecto;"id_tercero";$id_Tercero)
OB SET:C1220($ob_Afecto;"observacion";"")
OB SET:C1220($ob_Afecto;"id_razon_social";$vl_id_RazonSocial)
OB SET:C1220($ob_Afecto;"emitido_desde";2)
OB SET:C1220($ob_Afecto;"razon_referencia";0)
OB SET:C1220($ob_Afecto;"es_documento_publico_general";(e4=1))
OB SET:C1220($ob_Afecto;"categoria";alACT_idsCategorias{0})
OB SET:C1220($ob_Afecto;"moneda";atACT_Monedas{0})
OB SET:C1220($ob_Afecto;"imprimir";False:C215)
OB SET:C1220($ob_Afecto;"no_abrir_dte";False:C215)
OB SET:C1220($ob_Afecto;"apoderado_responsable";alACT_Responsables{0})

$montoAfectoTotalBolE:=0
OB SET:C1220($ob_Exento;"monto";$montoNoAfectoTotal)
OB SET ARRAY:C1227($ob_Exento;"ids_transacciones";$al_transaccionesExentas)
OB SET ARRAY:C1227($ob_Exento;"ids_transacciones_pagos";$al_transacciones)
OB SET:C1220($ob_Exento;"fecha";DTS_MakeFromDateTime (vdACT_FEmisionBol))
OB SET:C1220($ob_Exento;"documento_afecto";False:C215)
OB SET:C1220($ob_Exento;"id_categoria";$IDCat)
OB SET:C1220($ob_Exento;"id_documento";$idExento)
OB SET:C1220($ob_Exento;"tipo_documento";$DocExcento)
OB SET:C1220($ob_Exento;"id_apoderado";$idApdo)
OB SET:C1220($ob_Exento;"indice_configuracion";$IndexExcento)
OB SET:C1220($ob_Exento;"nombre_set";$setExcento)
OB SET:C1220($ob_Exento;"asignar_folio";True:C214)
OB SET:C1220($ob_Exento;"monto_afecto";$montoAfectoTotalBolE)
OB SET:C1220($ob_Exento;"id_tercero";$id_Tercero)
OB SET:C1220($ob_Exento;"observacion";"")
OB SET:C1220($ob_Exento;"id_razon_social";$vl_id_RazonSocial)
OB SET:C1220($ob_Exento;"emitido_desde";2)
OB SET:C1220($ob_Exento;"razon_referencia";0)
OB SET:C1220($ob_Exento;"es_documento_publico_general";(e4=1))
OB SET:C1220($ob_Exento;"categoria";alACT_idsCategorias{0})
OB SET:C1220($ob_Exento;"moneda";atACT_Monedas{0})
OB SET:C1220($ob_Exento;"imprimir";False:C215)
OB SET:C1220($ob_Exento;"no_abrir_dte";False:C215)
OB SET:C1220($ob_Exento;"apoderado_responsable";alACT_Responsables{0})

APPEND TO ARRAY:C911($ao_documentos;$ob_Afecto)
APPEND TO ARRAY:C911($ao_documentos;$ob_Exento)
ARRAY LONGINT:C221($al_idsBoletasEmitidas;0)
$ob_respuesta:=ACTbol_CreaDTObj (->$ao_documentos;->$al_idsBoletasEmitidas)

$b_boletaConError:=OB Get:C1224($ob_respuesta;"error_validacion")
If (vbACT_RegistrarIDSBoletas)
	For ($l_boletas;1;Size of array:C274($al_idsBoletasEmitidas))
		APPEND TO ARRAY:C911(alACT_idsBoletasEmitidas;$al_idsBoletasEmitidas{$l_boletas})
	End for 
End if 

CLEAR SEMAPHORE:C144("CreacionDT")

$0:=$ob_respuesta