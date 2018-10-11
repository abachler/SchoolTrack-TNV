WDW_OpenFormWindow (->[ACT_Cuentas_Contables:286];"CentrosCostoPorNivel";0;4;"Centros de costo")
DIALOG:C40([ACT_Cuentas_Contables:286];"CentrosCostoPorNivel")
CLOSE WINDOW:C154

  //If (ok=1)
  //ACTitems_GuardaCCostoXNivel 
  //End if 

  // Modificado por: Saúl Ponce (09-12-2016)
If (ok=1)
	If (vl_numPestaña=1)
		ACTitems_GuardaCCostoXNivel (->[xxACT_Items:179]xCentro_Costo:41)
	Else 
		ACTitems_GuardaCCostoXNivel (->[xxACT_Items:179]ContaMonedaPagoPais:50)
	End if 
	LOG_RegisterEvt ("Valores en "+ST_Qte ("Configuración de Contabilidad")+" del item ID "+String:C10([xxACT_Items:179]ID:1)+", en la pestaña "+Choose:C955(vl_numPestaña=1;"Moneda Item";"Moneda País")+", almacenados correctamente.")
Else 
	ACTitems_GuardaCCostoXNivel (->vb_pestaña1)
	SET BLOB SIZE:C606(vb_pestaña1;0)
	ACTitems_GuardaCCostoXNivel (->vb_pestaña2)
	SET BLOB SIZE:C606(vb_pestaña2;0)
	LOG_RegisterEvt ("Valores descartados en "+ST_Qte ("Configuración de Contabilidad")+" del item ID "+String:C10([xxACT_Items:179]ID:1)+", en la pestaña "+Choose:C955(vl_numPestaña=1;"Moneda Item";"Moneda País")+". El usuario abandonó la configuración sin guardar.")
End if 