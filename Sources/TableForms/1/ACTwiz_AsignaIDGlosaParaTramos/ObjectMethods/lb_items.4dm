
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce
  // Fecha y hora: 13-09-18, 11:16:00
  // ----------------------------------------------------
  // Método: [xxSTR_Constants].ACTwiz_AsignaIDGlosaParaTramos.lb_items
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

Case of 
	: (Form event:C388=On Data Change:K2:15)
		ACTwiz_AsignaIDGlosaTramosMas ("habilitarProximaPaginaForm")
		ACTwiz_AsignaIDGlosaTramosMas ("TildarDestildarTodasLasFilasLB")
End case 

