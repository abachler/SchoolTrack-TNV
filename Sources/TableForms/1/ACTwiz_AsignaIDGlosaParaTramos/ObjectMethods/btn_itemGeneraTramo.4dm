
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket Nº 187484
  // Fecha y hora: 02-10-18, 09:40:15
  // ----------------------------------------------------
  // Método: [xxSTR_Constants].ACTwiz_AsignaIDGlosaParaTramos.btn_itemGeneraTramo
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


Case of 
	: (Form event:C388=On Clicked:K2:4)
		
		C_POINTER:C301($y_control)
		C_LONGINT:C283($l_seleccionado)
		C_BOOLEAN:C305($b_marcado1;$b_marcado2)
		
		$b_marcado1:=False:C215
		$b_marcado2:=False:C215
		
		$l_seleccionado:=ACTit_MuestraPopUpMenu (->at_GlosasItems;"Seleccione un ítem de cargo")
		If ($l_seleccionado>0)
			at_GlosasItems:=$l_seleccionado
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramo")
			$y_control->:=at_GlosasItems{$l_seleccionado}
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramoId")
			$y_control->:=al_IdsItems{$l_seleccionado}
		End if 
		
		ACTwiz_AsignaIDGlosaTramosMas ("habilitarProximaPaginaForm")
		
End case 

