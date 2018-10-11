$tempaMeses:=aMeses
IT_Clairvoyance (Self:C308;->atACT_ItemNames2Charge;"";False:C215)
If (Self:C308->#"")
	$item:=Find in array:C230(atACT_ItemNames2Charge;Self:C308->)
	If ($item#-1)
		atACT_ItemNames2Charge:=$item
		vlACT_selectedItemId:=alACT_ItemIds2Charge{$item}
		READ ONLY:C145([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=vlACT_selectedItemId)
		vsACT_MonedaDef:=[xxACT_Items:179]Moneda:10
		vrACT_MontoDef:=[xxACT_Items:179]Monto:7
		vsACT_CtaContableDef:=[xxACT_Items:179]No_de_Cuenta_Contable:15
		vsACT_CentroContableDef:=[xxACT_Items:179]Centro_de_Costos:21
		vsACT_CCtaContableDef:=[xxACT_Items:179]No_CCta_contable:22
		vsACT_CCentroContableDef:=[xxACT_Items:179]CCentro_de_costos:23
		vsACT_CodAuxCtaDef:=[xxACT_Items:179]CodAuxCta:27
		vsACT_CodAuxCCtaDef:=[xxACT_Items:179]CodAuxCCta:28
		
		  //20130910 RCH
		OBJECT SET VISIBLE:C603(*;"CentroCostoXNivel_@";BLOB size:C605([xxACT_Items:179]xCentro_Costo:41)>0)
		
		If (vsACT_MonedaDef#<>vsACT_MonedaColegio)
			OBJECT SET FORMAT:C236(vrACT_ValorMonedaDef;"|Despliegue_UF")
			OBJECT SET FORMAT:C236(vrACT_MontoDef;"|Despliegue_UF")
			If (vsACT_MonedaDef="UF")
				vrACT_ValorMonedaDef:=ACTut_fValorUF (Current date:C33(*))
			Else 
				vrACT_ValorMonedaDef:=ACTut_fValorDivisa (vsACT_MonedaDef)
			End if 
			vrACT_MontoPesosDef:=Round:C94((vrACT_ValorMonedaDef*vrACT_MontoDef);<>vlACT_Decimales)
		Else 
			OBJECT SET FORMAT:C236(vrACT_MontoDef;"|Despliegue_ACT")
		End if 
		OBJECT SET VISIBLE:C603(*;"@calcitem@";(vsACT_MonedaDef#<>vsACT_MonedaColegio))
		OBJECT SET VISIBLE:C603(*;"@ufcalcitem@";(vsACT_MonedaDef="UF"))
		OBJECT SET VISIBLE:C603(*;"@divisacalcitem@";((vsACT_MonedaDef#"UF") & (vsACT_MonedaDef#<>vsACT_MonedaColegio)))
		OBJECT SET VISIBLE:C603(*;"ImputacionUnica";[xxACT_Items:179]Imputacion_Unica:24)
		_O_ENABLE BUTTON:C192(bNext)
	Else 
		_O_DISABLE BUTTON:C193(bNext)
		vsACT_MonedaDef:=""
		vrACT_MontoDef:=0
		vrACT_ValorMonedaDef:=0
		vrACT_MontoPesosDef:=0
		OBJECT SET VISIBLE:C603(*;"ImputacionUnica";False:C215)
	End if 
Else 
	_O_DISABLE BUTTON:C193(bNext)
	vsACT_MonedaDef:=""
	vrACT_MontoDef:=0
	vrACT_ValorMonedaDef:=0
	vrACT_MontoPesosDef:=0
	OBJECT SET VISIBLE:C603(*;"ImputacionUnica";False:C215)
End if 
aMeses:=$tempaMeses