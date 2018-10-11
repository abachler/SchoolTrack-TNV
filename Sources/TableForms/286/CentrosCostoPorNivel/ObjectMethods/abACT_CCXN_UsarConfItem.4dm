If (Form event:C388=On Data Change:K2:15)
	
	C_LONGINT:C283($l_col;$l_fila)
	C_POINTER:C301($y_array;$y_field)
	C_BOOLEAN:C305(vbACTcfg_EnItemsEsp)
	
	LISTBOX GET CELL POSITION:C971(lb_centroCostoXNivel;$l_col;$l_fila;$y_array)
	
	If (vbACTcfg_EnItemsEsp)
		If ($y_array->{$l_fila})
			atACT_CCXN_CentroCosto{$l_fila}:=vsACT_CentroInteresesIE  //20131007 RCH
			atACT_CCXN_CentroCostoContra{$l_fila}:=vsACT_CCentroInteresesIE
			
			  // Modificado por: Saul Ponce (09-12-2016) - Para manejar las 4 nuevas columnas en la interfaz de contabilidad del item
			atACT_CCXN_CodAux{$l_fila}:=vsACT_CodInteresesIE
			atACT_CCXN_CodAuxCC{$l_fila}:=vsACT_CCodInteresesIE
			atACT_CCXN_CodPlanCtas{$l_fila}:=vsACT_CtaInteresesIE
			atACT_CCXN_CodPlanCCtas{$l_fila}:=vsACT_CCtaInteresesIE
		Else 
			atACT_CCXN_CentroCosto{$l_fila}:=""
			atACT_CCXN_CentroCostoContra{$l_fila}:=""
			
			  // Modificado por: Saul Ponce (09-12-2016) - Para manejar las 4 nuevas columnas en la interfaz de contabilidad del item
			atACT_CCXN_CodAux{$l_fila}:=""
			atACT_CCXN_CodAuxCC{$l_fila}:=""
			atACT_CCXN_CodPlanCtas{$l_fila}:=""
			atACT_CCXN_CodPlanCCtas{$l_fila}:=""
		End if 
	Else 
		If ($y_array->{$l_fila})
			atACT_CCXN_CentroCosto{$l_fila}:=[xxACT_Items:179]Centro_de_Costos:21
			atACT_CCXN_CentroCostoContra{$l_fila}:=[xxACT_Items:179]CCentro_de_costos:23
			
			  // Modificado por: Saul Ponce (09-12-2016) - Para manejar las 4 nuevas columnas en la interfaz de contabilidad del item
			atACT_CCXN_CodAux{$l_fila}:=[xxACT_Items:179]CodAuxCta:27
			atACT_CCXN_CodAuxCC{$l_fila}:=[xxACT_Items:179]CodAuxCCta:28
			atACT_CCXN_CodPlanCtas{$l_fila}:=[xxACT_Items:179]No_de_Cuenta_Contable:15
			atACT_CCXN_CodPlanCCtas{$l_fila}:=[xxACT_Items:179]No_CCta_contable:22
		Else 
			atACT_CCXN_CentroCosto{$l_fila}:=""
			atACT_CCXN_CentroCostoContra{$l_fila}:=""
			
			
			  // Modificado por: Saul Ponce (09-12-2016) - Para manejar las 4 nuevas columnas en la interfaz de contabilidad del item
			atACT_CCXN_CodAux{$l_fila}:=""
			atACT_CCXN_CodAuxCC{$l_fila}:=""
			atACT_CCXN_CodPlanCtas{$l_fila}:=""
			atACT_CCXN_CodPlanCCtas{$l_fila}:=""
		End if 
	End if 
End if 