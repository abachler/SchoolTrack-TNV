
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket Nº 187484
  // Fecha y hora: 02-10-18, 09:41:38
  // ----------------------------------------------------
  // Método: [xxSTR_Constants].ACTwiz_AsignaIDGlosaParaTramos.cb_filtroAños
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

Case of 
	: (Form event:C388=On Clicked:K2:4)
		
		C_TEXT:C284($t_añoSel)
		C_POINTER:C301($y_listaAños)
		
		ARRAY TEXT:C222($at_años;0)
		
		$y_listaAños:=OBJECT Get pointer:C1124(Object named:K67:5;"cb_filtroAños")
		COPY ARRAY:C226($y_listaAños->;$at_años)
		  //$t_añoSel:=$y_listaAños->{0} // Modificado por: Saul Ponce (07-10-2018)
		$t_añoSel:=$y_listaAños->{$y_listaAños->}
		
		If ($t_añoSel#"")
			ACTwiz_AsignaIDGlosaTramosMas ("DeclaraArraysLB")
			ACTitems_CargaLista ($t_añoSel)
			
			If ($t_añoSel="Todos")
				ACTwiz_AsignaIDGlosaTramosMas ("PreparaArraysLB")
			Else 
				ACTwiz_AsignaIDGlosaTramosMas ("PreparaArraysLB";->$t_añoSel)
			End if 
			
			  //ACTwiz_AsignaIDGlosaTramosMas ("PreparaControlesInterfazLB")  // Modificado por: SaulPonceOrtega (07-10-2018)
			ACTwiz_AsignaIDGlosaTramosMas ("habilitarProximaPaginaForm")
			ACTwiz_AsignaIDGlosaTramosMas ("actualizaContadores")
		End if 
End case 
