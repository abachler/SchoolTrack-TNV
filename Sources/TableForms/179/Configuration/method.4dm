Case of 
	: (Form event:C388=On Load:K2:1)
		C_BOOLEAN:C305(vbACTcfg_EnItemsEsp)
		vbACTcfg_EnItemsEsp:=False:C215
		
		  //20140428 RCH Para cargar ctas contables.
		ACTcfg_LoadConfigData (10)
		
		vModificaCPCCS:=False:C215
		XS_SetConfigInterface 
		xALSet_ACT_ConfigItems 
		ACTcfg_LoadConfigData (1)
		ACTcfg_LoadConfigData (2)
		ACTcfg_OpcionesRazonesSociales ("SetObjetosVisiblesItems")
		OBJECT SET VISIBLE:C603(*;"impresion@";False:C215)
		OBJECT SET VISIBLE:C603(*;"glosa@";True:C214)
		If ([xxACT_Items:179]Glosa_de_Impresión:20="")
			[xxACT_Items:179]Glosa_de_Impresión:20:=[xxACT_Items:179]Glosa:2
		End if 
		ARRAY TEXT:C222(atACT_HijoNumero;0)
		ARRAY TEXT:C222(atACT_Tramo;0)
		ARRAY TEXT:C222(atACT_Familia;0)
		LOC_LoadList2Array ("ACT_Hijos";->atACT_HijoNumero)
		LOC_LoadList2Array ("ACT_Tramos";->atACT_Tramo)
		LOC_LoadList2Array ("ACT_Cargas";->atACT_Familia)
		ARRAY REAL:C219(arACT_DesctoPorHijo;16)
		ARRAY REAL:C219(arACT_DesctoTramo;16)
		ARRAY REAL:C219(arACT_DesctoPorFamilia;16)
		For ($i;1;16)
			$hijo:=Get pointer:C304("vr_Hijo"+String:C10($i+1))
			$tramo:=Get pointer:C304("vr_Tramo"+String:C10($i))
			$familia:=Get pointer:C304("vr_Familia"+String:C10($i+1))
			arACT_DesctoPorHijo{$i}:=$hijo->
			arACT_DesctoTramo{$i}:=$tramo->
			arACT_DesctoPorFamilia{$i}:=$familia->
		End for 
		xALP_ACT_Set_DesctoHijos 
		xALP_ACT_Set_DesctoFamilia 
		xALP_ACT_Set_DesctoTramos 
		  //SET QUERY LIMIT(1)
		  //QUERY([ACT_Cargos];[ACT_Cargos]Ref_Item=[xxACT_Items]ID;*)
		  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00/00/00!)
		  //SET QUERY LIMIT(0)
		  //If (Records in selection([ACT_Cargos])=0)
		  //IT_SetButtonState (True;->j1)
		  //IT_SetButtonState ((Not([xxACT_Items]EsRelativo)) & (Not([xxACT_Items]EsDescuento));->j2)
		  //Else 
		  //IT_SetButtonState (False;->j1;->j2)
		  //End if 
		  //j1:=Num(Not(([xxACT_Items]VentaRapida)))
		  //j2:=Num(([xxACT_Items]VentaRapida))
		  //OBJECT SET VISIBLE(bDisableMeses;(j2=1))
		  //IT_SetEnterable (True;0;->[xxACT_Items]EsRelativo;->[xxACT_Items]EsDescuento;->[xxACT_Items]AfectoDsctoIndividual;->[xxACT_Items]Afecto_a_descuentos;->[xxACT_Items]Reembolsable;->[xxACT_Items]Interés;->[xxACT_Items]Item_Global)
		  //If (j2=1)
		  //IT_SetEnterable (False;0;->[xxACT_Items]EsRelativo;->[xxACT_Items]EsDescuento;->[xxACT_Items]AfectoDsctoIndividual;->[xxACT_Items]Afecto_a_descuentos;->[xxACT_Items]Reembolsable;->[xxACT_Items]Interés;->[xxACT_Items]Item_Global)
		  //ACTcfg_Habilitatramoshijos (False;False;False)
		  //For ($i;1;12)
		  //OBJECT SET COLOR(*;"mes"+String($i);-3)
		  //End for 
		  //Else 
		  //ACTcfg_HabilitaOpcionesItem (False)
		  //End if 
		vtACT_CPCCS:=[xxACT_Items:179]No_de_Cuenta_Contable:15
		vtACT_CAUXCC:=[xxACT_Items:179]CodAuxCta:27
		vtACT_CCCCS:=[xxACT_Items:179]Centro_de_Costos:21
		vtACT_CCPCCS:=[xxACT_Items:179]No_CCta_contable:22
		vtACT_CAUXCCC:=[xxACT_Items:179]CodAuxCCta:28
		vtACT_CCCCCS:=[xxACT_Items:179]CCentro_de_costos:23
		ACTcfgcar_SetObjects ("SetPrivilegios")
		AT_RedimArrays2Max (->atACT_HijoNumero;->arACT_DesctoPorHijo)
		AT_RedimArrays2Max (->atACT_Familia;->arACT_DesctoPorFamilia)
		
		AL_UpdateArrays (xALP_Items;0)
		ACTitems_FiltroPeriodo ("CreaLista")
		
		AL_UpdateArrays (xALP_Items;-2)
		
		ACTitems_CargaItemConf 
		
		
		  //20150725 RCH A pedido de AGH se deja solo visible para Super User
		  //OBJECT SET VISIBLE(*;"unidad_medida@";(USR_GetUserID <0))
		OBJECT SET VISIBLE:C603(*;"unidad_medida@";((USR_GetUserID <0) | (<>gCountryCode="mx")))  //20170920 RCH Ticket 188464
		
		  //20160223 RCH
		  //OBJECT SET ENABLED(*;"Codigo_interno";[xxACT_Items]VentaRapida)
		OBJECT SET ENABLED:C1123(*;"Codigo_interno";(([xxACT_Items:179]VentaRapida:3) | (<>gCountryCode="mx")))  //20170920 RCH Ticket 188464
		
	: (Form event:C388=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		ACTcfg_SaveItemdeCargo 
		
		  //20160223 RCH
		  //OBJECT SET ENABLED(*;"Codigo_interno";[xxACT_Items]VentaRapida)
		OBJECT SET ENABLED:C1123(*;"Codigo_interno";(([xxACT_Items:179]VentaRapida:3) | (<>gCountryCode="mx")))  //20171122 RCH Ticket 188464
End case 
