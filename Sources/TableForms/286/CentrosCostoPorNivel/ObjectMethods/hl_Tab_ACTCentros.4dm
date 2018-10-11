  // ----------------------------------------------------
  // Usuario (SO): Saúl Ponce
  // Fecha y hora: 30-11-16, 12:51:54
  // ----------------------------------------------------
  // Método: [ACT_Cuentas_Contables].CentrosCostoPorNivel.hl_Tab_ACTCentros
  // Descripción:
  // Maneja la pestaña hl_Tab_ACTCentros seleccionada en la ventana de "Configuración de Contabilidad" para saber cuál información cargar.
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($object;$vt_pestaña)
C_LONGINT:C283($vl_idItem)
C_POINTER:C301($y_punteroCampo)
GET LIST ITEM:C378(hl_Tab_ACTCentros;Selected list items:C379(hl_Tab_ACTCentros);vl_numPestaña;$object)
FORM GOTO PAGE:C247(vl_numPestaña)

If (vl_numPestaña=1)
	$y_punteroCampo:=->[xxACT_Items:179]xCentro_Costo:41
	$vt_pestaña:="Moneda Item"
	  // ACTitems_GuardaCCostoXNivel (->[xxACT_Items]ContaMonedaPagoPais)
Else 
	$y_punteroCampo:=->[xxACT_Items:179]ContaMonedaPagoPais:50
	$vt_pestaña:="Moneda Pais"
	  // ACTitems_GuardaCCostoXNivel (->[xxACT_Items]xCentro_Costo)
End if 



If (vbACTcfg_EnItemsEsp)
	ACTitems_LeeCentrosCostoXNivel (vl_idIE;$y_punteroCampo)
	$vl_idItem:=vl_idIE
Else 
	ACTitems_LeeCentrosCostoXNivel ([xxACT_Items:179]ID:1;$y_punteroCampo)
	$vl_idItem:=[xxACT_Items:179]ID:1
End if 

LOG_RegisterEvt ("Cambio a la pestaña "+ST_Qte ($vt_pestaña)+" en la "+ST_Qte ("Configuración de Contabilidad")+" del item ID "+String:C10($vl_idItem)+".")

