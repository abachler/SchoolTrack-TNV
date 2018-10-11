//%attributes = {}
  //ACTcfg_OpcionesArraysItemsM

C_TEXT:C284($vt_accion;$1)
C_POINTER:C301($ptr1)
C_LONGINT:C283($vl_idItem;$i)

$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="InitArrays")
		ARRAY LONGINT:C221(alACT_ItemRecNum;0)
		ARRAY TEXT:C222(atACT_GlosaItemMatriz;0)
		ARRAY REAL:C219(arACT_amountItemMatriz;0)
		ARRAY BOOLEAN:C223(abACT_IsDiscountItemMatriz;0)
		ARRAY BOOLEAN:C223(abACT_IsPercentItemMatriz;0)
		ARRAY BOOLEAN:C223(abACT_esDescontable;0)
		ARRAY TEXT:C222(atACT_MonedaItem;0)
		ARRAY INTEGER:C220(alACT_MesDeCargo;0)
		ARRAY BOOLEAN:C223(abACT_ItemAfectoIVA;0)
		ARRAY BOOLEAN:C223(abACT_AfectoDescInd;0)
		ARRAY PICTURE:C279(apACT_AfectoItemMatriz;0)
		ARRAY BOOLEAN:C223(abACT_AfectoItemMatriz;0)
		ARRAY LONGINT:C221(alACT_IdItemMatriz;0)
		ARRAY LONGINT:C221(alACT_RecNumItems;0)
		_O_ARRAY STRING:C218(80;asACT_CtaContableItem;0)
		_O_ARRAY STRING:C218(80;asACT_CentroContableItem;0)
		_O_ARRAY STRING:C218(80;asACT_CCtaContableItem;0)
		_O_ARRAY STRING:C218(80;asACT_CCentroContableItem;0)
		ARRAY BOOLEAN:C223(abACT_ImputacionUnica;0)
		_O_ARRAY STRING:C218(80;asACT_CodAuxCta;0)
		_O_ARRAY STRING:C218(80;asACT_CodAuxCCta;0)
		ARRAY BOOLEAN:C223(abACT_NoDocTrib;0)
		ARRAY TEXT:C222(atACT_NombreRazonSocial;0)
		ARRAY LONGINT:C221(alACT_NombreRazonSocial;0)
		ARRAY BOOLEAN:C223(abACT_NoRecargoAut;0)
		
	: ($vt_accion="InsertaElemento")
		READ ONLY:C145([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$ptr1->)
		AT_Insert (0;1;->alACT_ItemRecNum;->atACT_GlosaItemMatriz;->arACT_AmountItemMatriz;->abACT_IsDiscountItemMatriz;->abACT_isPercentItemMatriz;->abACT_esDescontable;->atACT_MonedaItem;->alACT_MesDeCargo;->abACT_ItemAfectoIVA;->abACT_AfectoDescInd;->abACT_AfectoItemMatriz;->apACT_AfectoItemMatriz;->asACT_CtaContableItem;->asACT_CentroContableItem;->asACT_CCtaContableItem;->asACT_CCentroContableItem;->abACT_ImputacionUnica;->asACT_CodAuxCta;->asACT_CodAuxCCta;->abACT_NoDocTrib;->atACT_NombreRazonSocial;->alACT_NombreRazonSocial;->abACT_NoRecargoAut)
		$i:=Size of array:C274(alACT_ItemRecNum)
		alACT_ItemRecNum{$i}:=Record number:C243([xxACT_Items:179])
		atACT_GlosaItemMatriz{$i}:=[xxACT_Items:179]Glosa:2
		arACT_AmountItemMatriz{$i}:=[xxACT_Items:179]Monto:7
		abACT_IsDiscountItemMatriz{$i}:=[xxACT_Items:179]EsDescuento:6
		abACT_isPercentItemMatriz{$i}:=[xxACT_Items:179]EsRelativo:5
		abACT_esDescontable{$i}:=[xxACT_Items:179]Afecto_a_descuentos:4
		atACT_MonedaItem{$i}:=[xxACT_Items:179]Moneda:10
		alACT_MesDeCargo{$i}:=[xxACT_Items:179]Meses_de_cargo:9
		abACT_ItemAfectoIVA{$i}:=[xxACT_Items:179]Afecto_IVA:12
		abACT_AfectoDescInd{$i}:=[xxACT_Items:179]AfectoDsctoIndividual:17
		abACT_AfectoItemMatriz{$i}:=[xxACT_Items:179]Afecto_IVA:12
		asACT_CtaContableItem{$i}:=[xxACT_Items:179]No_de_Cuenta_Contable:15
		asACT_CentroContableItem{$i}:=[xxACT_Items:179]Centro_de_Costos:21
		asACT_CCtaContableItem{$i}:=[xxACT_Items:179]No_CCta_contable:22
		asACT_CCentroContableItem{$i}:=[xxACT_Items:179]CCentro_de_costos:23
		abACT_ImputacionUnica{$i}:=[xxACT_Items:179]Imputacion_Unica:24
		asACT_CodAuxCta{$i}:=[xxACT_Items:179]CodAuxCta:27
		asACT_CodAuxCCta{$i}:=[xxACT_Items:179]CodAuxCCta:28
		abACT_NoDocTrib{$i}:=[xxACT_Items:179]No_incluir_en_DocTributario:31
		If (abACT_AfectoItemMatriz{$i})
			GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";apACT_AfectoItemMatriz{$i})
		Else 
			GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_AfectoItemMatriz{$i})
		End if 
		atACT_NombreRazonSocial{$i}:=[xxACT_Items:179]RazonSocialAsociada:35
		alACT_NombreRazonSocial{$i}:=[xxACT_Items:179]ID_RazonSocial:36
		  //abACT_NoRecargoAut{$i}:=[xxACT_Items]NoAfecto_a_RecargosAut
		abACT_NoRecargoAut{$i}:=([xxACT_Items:179]id_tipoRecargoAut:45=0)  //se utiliza nuevo campo
		
	: ($vt_accion="InsertaElementosDesdeArreglo")
		For ($i;1;Size of array:C274($ptr1->))
			$vl_idItem:=$ptr1->{$i}
			ACTcfg_OpcionesArraysItemsM ("InsertaElemento";->$vl_idItem)
		End for 
		
	: ($vt_accion="InsertaElementosDesdeID")
		ACTcfg_OpcionesArraysItemsM ("InitArrays")
		$vl_idItem:=$ptr1->
		AT_Insert (0;1;->alACT_IdItemMatriz)
		alACT_IdItemMatriz{Size of array:C274(alACT_IdItemMatriz)}:=$vl_idItem
		ACTcfg_OpcionesArraysItemsM ("InsertaElemento";->$vl_idItem)
		
	: ($vt_accion="InicializaArrays")
		AT_Initialize (->alACT_ItemRecNum;->atACT_GlosaItemMatriz;->arACT_amountItemMatriz;->abACT_IsDiscountItemMatriz;->abACT_IsPercentItemMatriz;->abACT_esDescontable;->atACT_MonedaItem;->alACT_MesDeCargo;->abACT_ItemAfectoIVA;->abACT_AfectoDescInd;->apACT_AfectoItemMatriz;->abACT_AfectoItemMatriz;->alACT_IdItemMatriz;->alACT_RecNumItems)
		AT_Initialize (->asACT_CtaContableItem;->asACT_CentroContableItem;->asACT_CCtaContableItem;->asACT_CCentroContableItem;->abACT_ImputacionUnica;->asACT_CodAuxCta;->asACT_CodAuxCCta;->abACT_NoDocTrib;->atACT_NombreRazonSocial;->alACT_NombreRazonSocial;->abACT_NoRecargoAut)
		
End case 