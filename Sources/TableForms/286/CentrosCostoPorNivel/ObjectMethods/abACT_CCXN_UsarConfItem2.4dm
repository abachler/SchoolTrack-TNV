  // ----------------------------------------------------
  // Usuario (SO): Saúl Ponce
  // Fecha y hora: 30-11-16, 13:17:53
  // ----------------------------------------------------
  // Método: [ACT_Cuentas_Contables].CentrosCostoPorNivel.abACT_CCXN_UsarConfItem1
  // Descripción
  // Se creó al copiar el AreaList desde la pestaña 1 a la pestaña 2 del formulario [ACT_Cuentas_Contables];"CentrosCostoPorNivel"
  //
  // Parámetros
  // ----------------------------------------------------


If (Form event:C388=On Data Change:K2:15)
	
	C_LONGINT:C283($l_col;$l_fila)
	C_POINTER:C301($y_array;$y_field)
	C_BOOLEAN:C305(vbACTcfg_EnItemsEsp)
	
	LISTBOX GET CELL POSITION:C971(lb_centroCostoXNivel2;$l_col;$l_fila;$y_array)
	
	If (vbACTcfg_EnItemsEsp)
		If ($y_array->{$l_fila})
			atACT_CCXN_CentroCosto{$l_fila}:=vsACT_CentroInteresesIE  //20131007 RCH
			atACT_CCXN_CentroCostoContra{$l_fila}:=vsACT_CCentroInteresesIE
			
			atACT_CCXN_CodAux{$l_fila}:=vsACT_CodInteresesIE
			atACT_CCXN_CodAuxCC{$l_fila}:=vsACT_CCodInteresesIE
			atACT_CCXN_CodPlanCtas{$l_fila}:=vsACT_CtaInteresesIE
			atACT_CCXN_CodPlanCCtas{$l_fila}:=vsACT_CCtaInteresesIE
		Else 
			atACT_CCXN_CentroCosto{$l_fila}:=""
			atACT_CCXN_CentroCostoContra{$l_fila}:=""
			
			atACT_CCXN_CodAux{$l_fila}:=""
			atACT_CCXN_CodAuxCC{$l_fila}:=""
			atACT_CCXN_CodPlanCtas{$l_fila}:=""
			atACT_CCXN_CodPlanCCtas{$l_fila}:=""
		End if 
	Else 
		If ($y_array->{$l_fila})
			atACT_CCXN_CentroCosto{$l_fila}:=[xxACT_Items:179]Centro_de_Costos:21
			atACT_CCXN_CentroCostoContra{$l_fila}:=[xxACT_Items:179]CCentro_de_costos:23
			
			atACT_CCXN_CodAux{$l_fila}:=[xxACT_Items:179]CodAuxCta:27
			atACT_CCXN_CodAuxCC{$l_fila}:=[xxACT_Items:179]CodAuxCCta:28
			atACT_CCXN_CodPlanCtas{$l_fila}:=[xxACT_Items:179]No_de_Cuenta_Contable:15
			atACT_CCXN_CodPlanCCtas{$l_fila}:=[xxACT_Items:179]No_CCta_contable:22
		Else 
			atACT_CCXN_CentroCosto{$l_fila}:=""
			atACT_CCXN_CentroCostoContra{$l_fila}:=""
			
			atACT_CCXN_CodAux{$l_fila}:=""
			atACT_CCXN_CodAuxCC{$l_fila}:=""
			atACT_CCXN_CodPlanCtas{$l_fila}:=""
			atACT_CCXN_CodPlanCCtas{$l_fila}:=""
		End if 
	End if 
End if 