Case of 
	: (Form event:C388=On Load:K2:1)
		C_BOOLEAN:C305(vbACT_Prepago)
		cbImprimirBoletas:=0
		cbImprimirRecPago:=0
		If (vbACT_Prepago)
			OBJECT SET VISIBLE:C603(*;"Prepago@";True:C214)
			ACTpgs_CargaModelosRecibos 
		Else 
			OBJECT SET VISIBLE:C603(*;"Prepago@";False:C215)
		End if 
		vbACT_Prepago:=False:C215
		
		C_LONGINT:C283(hlACT_IngresoPagos)
		hlACT_IngresoPagos:=LOC_LoadList ("ACT_PaginasIngresoPago")
		xALSet_ACT_ItemsPagos 
		xALSet_ACT_AlumnosPagos 
		ACTpgs_DeclaraArreglosCargosT 
		
		ACTpgs_ArreglosAgrupado ("SetAreaList")
		C_LONGINT:C283($page)
		ACTpgs_LimpiaVarsInterfaz ("SeteaObjetosYSelPage";->$page)
		ACTpgs_LimpiaVarsInterfaz ("SeleccionaTodosCargosAPagar";->$page)
		ACTpgs_CopiaArreglosCargos 
		AT_Initialize (->alACT_CIdsAvisos;->adACT_CFechaEmision;->adACT_CFechaVencimiento;->atACT_CAlumno;->atACT_CGlosa;->arACT_CMontoNeto;->arACT_CIntereses;->arACT_CSaldo;->alACT_RecNumsCargos;->alACT_CRefs;->alACT_CIDCtaCte;->asACT_Marcas;->arACT_MontoMoneda;->atACT_MonedaCargo;->atACT_MonedaSimbolo)
		AT_Initialize (->arACT_MontoPagado;->alACT_CIdsCargos;->alACT_CIdDctoCargo;->arACT_MontoIVA;->arACT_CMontoAfecto;->adACT_CfechaInteres;->alACT_CidCargoGenInt;->apACT_ASelectedCargo;->abACT_ASelectedCargo)
		C_LONGINT:C283(vl_lineaAviso)
		vl_lineaAviso:=0
		vbACT_IngresandoPagos:=True:C214
		XS_SetInterface 
		xALSet_ACT_AvisosPagos 
		xALSet_ACT_IngresoPagos 
		AL_UpdateArrays (ALP_CargosXPagar;-2)
		AL_UpdateArrays (ALP_AvisosXPagar;-2)
		AL_SetLine (ALP_CargosXPagar;0)
		AL_SetLine (ALP_AvisosXPagar;0)
		IT_SetButtonState (False:C215;->bSubir;->bBajar;->bDelCargos;->bSubirC;->bBajarC)
		ACTpgs_LoadInteresRecord 
		vtACT_LabelPlanillaInt:="Detalle de "+[xxACT_Items:179]Glosa:2
		UNLOAD RECORD:C212([xxACT_Items:179])
		ACTpgs_LimpiaVarsInterfaz ("SeteaTodasFlechas")
End case 
