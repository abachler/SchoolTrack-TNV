  //$tempaMeses:=aMeses
  //$choice:=Pop up menu(vt_ItemNames)
  // If ($choice>0)
$tempaMeses:=aMeses
If (Size of array:C274(atACT_ItemNames2Charge)<50)
	$choice:=Pop up menu:C542(vt_ItemNames)
	If ($choice>0)
		ok:=1
		choiceIdx:=$choice
	Else 
		ok:=0
	End if 
Else 
	ARRAY POINTER:C280(<>aChoicePtrs;0)
	ARRAY POINTER:C280(<>aChoicePtrs;1)
	<>aChoicePtrs{1}:=->atACT_ItemNames2Charge
	TBL_ShowChoiceList (1;"Seleccione un cargo";1;->bItem)
End if 

If (ok=1)
	
	vsACT_Glosa:=atACT_ItemNames2Charge{choiceIdx}
	atACT_ItemNames2Charge:=choiceIdx
	vlACT_selectedItemId:=alACT_ItemIds2Charge{choiceIdx}
	READ ONLY:C145([xxACT_Items:179])
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=vlACT_selectedItemId)
	vsACT_Moneda:=[xxACT_Items:179]Moneda:10
	prevMoneda:=vsACT_Moneda
	vrACT_Monto:=[xxACT_Items:179]Monto:7
	vsACT_CtaContable:=[xxACT_Items:179]No_de_Cuenta_Contable:15
	vsACT_CentroContable:=[xxACT_Items:179]Centro_de_Costos:21
	vsACT_CCtaContable:=[xxACT_Items:179]No_CCta_contable:22
	vsACT_CCentroContable:=[xxACT_Items:179]CCentro_de_costos:23
	vsACT_CodAuxCta:=[xxACT_Items:179]CodAuxCta:27
	vsACT_CodAuxCCta:=[xxACT_Items:179]CodAuxCCta:28
	
	  //20130910 RCH
	OBJECT SET VISIBLE:C603(*;"CentroCostoXNivel_@";BLOB size:C605([xxACT_Items:179]xCentro_Costo:41)>0)
	
	If (vsACT_Moneda#<>vsACT_MonedaColegio)
		OBJECT SET FORMAT:C236(vrACT_ValorMoneda;"|Despliegue_UF")
		OBJECT SET FORMAT:C236(vrACT_Monto;"|Despliegue_UF")
		If (vsACT_Moneda="UF")
			vrACT_ValorMoneda:=ACTut_fValorUF (Current date:C33(*))
		Else 
			vrACT_ValorMoneda:=ACTut_fValorDivisa (vsACT_Moneda)
		End if 
		vrACT_MontoPesos:=Round:C94((vrACT_ValorMoneda*vrACT_Monto);<>vlACT_Decimales)
	Else 
		OBJECT SET FORMAT:C236(vrACT_Monto;"|Despliegue_ACT")
	End if 
	cbACT_Afecto_IVA:=Num:C11([xxACT_Items:179]Afecto_IVA:12)
	cbACT_NoDocTrib:=Num:C11([xxACT_Items:179]No_incluir_en_DocTributario:31)
	cbACT_EsDescuento:=Num:C11([xxACT_Items:179]EsDescuento:6)
	OBJECT SET VISIBLE:C603(*;"@calcextra@";(vsACT_Moneda#<>vsACT_MonedaColegio))
	OBJECT SET VISIBLE:C603(*;"@ufcalcextra@";(vsACT_Moneda="UF"))
	OBJECT SET VISIBLE:C603(*;"@divisacalcextra@";((vsACT_Moneda#"UF") & (vsACT_Moneda#<>vsACT_MonedaColegio)))
	OBJECT SET VISIBLE:C603(*;"ImputacionUnica1";[xxACT_Items:179]Imputacion_Unica:24)
	If ((vsACT_Glosa#"") & (vsACT_Moneda#"") & (vrACT_Monto#0))
		_O_ENABLE BUTTON:C192(bNext)
	Else 
		_O_DISABLE BUTTON:C193(bNext)
	End if 
End if 
aMeses:=$tempaMeses
GOTO OBJECT:C206(vsACT_Moneda)