  // Modificado por: Saúl Ponce (09-12-2016)
  // Implementé una selección de pestañas en el formulario
Case of 
	: (Form event:C388=On Load:K2:1)
		
		C_LONGINT:C283(vl_numPestaña;$vl_idItem)
		C_BLOB:C604(vb_pestaña1;vb_pestaña2)
		C_BOOLEAN:C305(vbACTcfg_EnItemsEsp)
		
		hl_Tab_ACTCentros:=AT_Array2ReferencedList (-><>atACT_CentroDeCosto;-><>alACT_CentroDeCosto;0;False:C215;True:C214)
		FORM FIRST PAGE:C250
		vl_numPestaña:=1
		
		  // Se inhabilita la pestaña 2 ("Moneda País") cuando el el item está en la moneda del país
		If ([xxACT_Items:179]Moneda:10=<>vtACT_monedaPais)
			SET LIST ITEM PROPERTIES:C386(hl_Tab_ACTCentros;2;False:C215;Plain:K14:1;0)
		End if 
		
		  //If (vbACTcfg_EnItemsEsp)
		  //ACTitems_LeeCentrosCostoXNivel (vl_idIE)
		  //Else 
		  //ACTitems_LeeCentrosCostoXNivel ([xxACT_Items]ID)
		  //End if 
		
		  // cuando se carga la primera vez, siempre se leen valores en los arrays de la primera pestaña ("Moneda Item")
		If (vbACTcfg_EnItemsEsp)
			ACTitems_LeeCentrosCostoXNivel (vl_idIE;->[xxACT_Items:179]xCentro_Costo:41)
			$vl_idItem:=vl_idIE
		Else 
			ACTitems_LeeCentrosCostoXNivel ([xxACT_Items:179]ID:1;->[xxACT_Items:179]xCentro_Costo:41)
			$vl_idItem:=[xxACT_Items:179]ID:1
		End if 
		
		vb_pestaña1:=[xxACT_Items:179]xCentro_Costo:41
		vb_pestaña2:=[xxACT_Items:179]ContaMonedaPagoPais:50
		
		  ////20131007 RCH si no tiene privilegios para editar, no puede hacerlo
		If (USR_GetMethodAcces ("ACTcfg_SaveItemdeCargo";0))
			OBJECT SET ENTERABLE:C238(*;"lb_centroCostoXNivel";True:C214)
		Else 
			OBJECT SET ENTERABLE:C238(*;"lb_centroCostoXNivel";False:C215)
		End if 
		
		LOG_RegisterEvt ("Ingreso a la pestaña "+ST_Qte ("Moneda Item")+" en la "+ST_Qte ("Configuración de Contabilidad")+" del item ID "+String:C10($vl_idItem)+".")
		
End case 
