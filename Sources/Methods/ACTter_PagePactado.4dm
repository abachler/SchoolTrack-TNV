//%attributes = {}
  //ACTter_PagePactado

C_LONGINT:C283($0)
If ([ACT_Terceros:138]Es_empresa:2)
	C_TEXT:C284($vt_accion)
	If (Count parameters:C259=1)
		$vt_accion:=$1
	End if 
	Case of 
		: ($vt_accion="")
			AL_UpdateArrays (xAL_ACT_Terc_Cargas;0)
			AL_UpdateArrays (xAL_ACT_Terc_Items;0)
			AL_UpdateArrays (xALP_ACT_Terc_CtasXItems;0)
			ACTter_PagePactado ("LeeCargas")
			ACTter_PagePactado ("LeeItems")
			ACTter_PagePactado ("LeeCuentasXItems")
			AL_UpdateArrays (xAL_ACT_Terc_Cargas;-2)
			AL_UpdateArrays (xAL_ACT_Terc_Items;-2)
			AL_UpdateArrays (xALP_ACT_Terc_CtasXItems;-2)
			ACTter_Datos_ALP ("SetColoresArea";->xAL_ACT_Terc_Items;->alACT_TerIdItem)
			ACTter_Datos_ALP ("SetColoresAreaCtaXItem";->xALP_ACT_Terc_CtasXItems)
			
		: ($vt_accion="LeeCargas")
			ACTter_InitVariablesForm ("Cuentas")
			ACTter_Datos_ALP ("LeeCargas";->[ACT_Terceros:138]Id:1;->alACT_TerIdCtaCte;->atACT_TerCurso;->atACT_TerAlumno)
			AT_MultiLevelSort (">>>";->atACT_TerCurso;->atACT_TerAlumno;->alACT_TerIdCtaCte)
			vl_cantidadCtas:=Size of array:C274(alACT_TerIdCtaCte)
			
		: ($vt_accion="LeeItems")
			ACTter_InitVariablesForm ("Items")
			ACTter_Datos_ALP ("LeeItems";->[ACT_Terceros:138]Id:1;->alACT_TerIdItem;->atACT_TerGlosaItem;->arACT_TerMontoItem;->atACT_TerMonedaItem)
			AT_MultiLevelSort (">>>>";->alACT_TerIdItem;->atACT_TerGlosaItem;->arACT_TerMontoItem;->atACT_TerMonedaItem)
			vl_cantidadItems:=Size of array:C274(alACT_TerIdItem)
			
		: ($vt_accion="LeeCuentasXItems")
			ACTter_InitVariablesForm ("CuentasXItems")
			ACTter_Datos_ALP ("LeeCuentasXItems";->[ACT_Terceros:138]Id:1;->atACT_GlosaCXI;->atACT_CtaCXI;->atACT_CtaCursoCXI;->arACT_MontoFijoCXI;->arACT_MontoPctCXI;->alACT_IdCXI;->apACT_ActivoCXI;->abACT_RelativoCXI;->abACT_ActivoCXI)
			AT_MultiLevelSort (">>>>>>>>>";->atACT_CtaCXI;->atACT_GlosaCXI;->atACT_CtaCursoCXI;->arACT_MontoFijoCXI;->arACT_MontoPctCXI;->alACT_IdCXI;->apACT_ActivoCXI;->abACT_RelativoCXI;->abACT_ActivoCXI)
	End case 
End if 

$0:=1