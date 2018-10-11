
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket Nº 187484
  // Fecha y hora: 02-10-18, 09:42:48
  // ----------------------------------------------------
  // Método: [xxSTR_Constants].ACTwiz_AsignaIDGlosaParaTramos.ACTcfg_itemGeneraTramo
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


Case of 
	: (Form event:C388=On Data Change:K2:15)
		
		C_LONGINT:C283($l_posItem)
		C_POINTER:C301($y_control)
		IT_Clairvoyance (Self:C308;->at_GlosasItems;"";False:C215)
		
		If (Self:C308->#"")
			$l_posItem:=Find in array:C230(at_GlosasItems;Self:C308->)
			If ($l_posItem#-1)
				at_GlosasItems:=$l_posItem
				$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramo")
				$y_control->:=at_GlosasItems{$l_posItem}
				$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramoId")
				$y_control->:=al_IdsItems{$l_posItem}
			End if 
		End if 
		
End case 
