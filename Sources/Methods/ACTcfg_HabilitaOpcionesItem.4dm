//%attributes = {}
  //ACTcfg_HabilitaOpcionesItem

If (Count parameters:C259=1)
	$modify:=$1
Else 
	$modify:=True:C214
End if 
If ([xxACT_Items:179]EsRelativo:5)
	If ($modify)
		[xxACT_Items:179]Afecto_a_descuentos:4:=False:C215
		[xxACT_Items:179]Afecto_IVA:12:=False:C215
		[xxACT_Items:179]Interés:19:=0
		[xxACT_Items:179]Reembolsable:18:=False:C215
		[xxACT_Items:179]AfectoDsctoIndividual:17:=False:C215
		[xxACT_Items:179]ID_Categoria:8:=0
	End if 
	IT_SetEnterable (False:C215;0;->[xxACT_Items:179]Afecto_a_descuentos:4;->[xxACT_Items:179]Afecto_IVA:12;->[xxACT_Items:179]Interés:19;->[xxACT_Items:179]Reembolsable:18;->[xxACT_Items:179]AfectoDsctoIndividual:17;->[xxACT_Items:179]TasaInteresMensual:25;->[xxACT_Items:179]AfectoInteres:26;->[xxACT_Items:179]TipoInteres:29;->[xxACT_Items:179]No_incluir_en_DocTributario:31)
	OBJECT SET FORMAT:C236([xxACT_Items:179]Monto:7;"|Pct_4DecIfNec")
	ACTcfg_Habilitatramoshijos (False:C215;False:C215;False:C215)
Else 
	If ((<>gCountryCode="cl") & ([xxACT_Items:179]Moneda:10="UF@"))
		OBJECT SET FORMAT:C236([xxACT_Items:179]Monto:7;"|Despliegue_UF")
	Else 
		OBJECT SET FORMAT:C236([xxACT_Items:179]Monto:7;"|Despliegue_ACT")
	End if 
	ACTcfg_Habilitatramoshijos (Not:C34([xxACT_Items:179]EsDescuento:6);Not:C34([xxACT_Items:179]EsDescuento:6);Not:C34([xxACT_Items:179]EsDescuento:6))
	If ([xxACT_Items:179]EsDescuento:6)
		If ($modify)
			[xxACT_Items:179]Afecto_a_descuentos:4:=False:C215
			[xxACT_Items:179]Interés:19:=0
			[xxACT_Items:179]Reembolsable:18:=False:C215
			[xxACT_Items:179]AfectoDsctoIndividual:17:=False:C215
		End if 
		IT_SetEnterable (False:C215;0;->[xxACT_Items:179]Afecto_a_descuentos:4;->[xxACT_Items:179]Afecto_IVA:12;->[xxACT_Items:179]Interés:19;->[xxACT_Items:179]Reembolsable:18;->[xxACT_Items:179]AfectoDsctoIndividual:17;->[xxACT_Items:179]TasaInteresMensual:25;->[xxACT_Items:179]AfectoInteres:26;->[xxACT_Items:179]TipoInteres:29)
	Else 
		IT_SetEnterable (True:C214;0;->[xxACT_Items:179]Afecto_a_descuentos:4;->[xxACT_Items:179]Afecto_IVA:12;->[xxACT_Items:179]Interés:19;->[xxACT_Items:179]Reembolsable:18;->[xxACT_Items:179]AfectoDsctoIndividual:17;->[xxACT_Items:179]TasaInteresMensual:25;->[xxACT_Items:179]AfectoInteres:26;->[xxACT_Items:179]TipoInteres:29)
	End if 
	If ([xxACT_Items:179]No_incluir_en_DocTributario:31)
		[xxACT_Items:179]Afecto_IVA:12:=False:C215
		OBJECT SET ENTERABLE:C238([xxACT_Items:179]Afecto_IVA:12;False:C215)
	Else 
		If (Not:C34([xxACT_Items:179]EsDescuento:6))
			OBJECT SET ENTERABLE:C238([xxACT_Items:179]Afecto_IVA:12;True:C214)
		End if 
	End if 
End if 

OBJECT SET ENABLED:C1123(*;"eliminaDescuento";Not:C34([xxACT_Items:179]EsDescuento:6))