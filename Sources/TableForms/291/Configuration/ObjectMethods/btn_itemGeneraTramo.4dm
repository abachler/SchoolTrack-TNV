
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket Nº 187484
  // Fecha y hora: 02-10-18, 09:38:41
  // ----------------------------------------------------
  // Método: [xxACT_ItemsTramos].Configuration.btn_itemGeneraTramo
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


Case of 
	: (Form event:C388=On Clicked:K2:4)
		
		C_POINTER:C301($y_control)
		C_LONGINT:C283($l_idTramo;$l_ok;$l_seleccionado;$l_idParaTramo;$l_posItem)
		
		$l_seleccionado:=ACTit_MuestraPopUpMenu (->at_GlosasItems;"Seleccione un ítem de cargo")
		If ($l_seleccionado>0)
			
			at_GlosasItems:=$l_seleccionado
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramo")
			$y_control->:=at_GlosasItems{$l_seleccionado}
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramoId")
			$y_control->:=al_IdsItems{$l_seleccionado}
			
			$l_ok:=Num:C11(ACTcfgit_OpcionesGenerales ("comparaIdSeleccionadoConAsignadoEnItem";->[xxACT_Items:179]ID:1;$y_control))
			
			If ($l_ok=1)
				$l_idTramo:=[xxACT_Items:179]ID:1
				$l_ok:=Num:C11(ACTcfgit_OpcionesGenerales ("preparaCambioGlosaParaTramo";->$l_idTramo;$y_control))
				If ($l_ok=1)
					ACTcfgit_OpcionesGenerales ("logCambioDeItemEnIdParaTramo";->$l_idTramo;$y_control)
				Else 
					If ($l_ok=-1)  // canceló
					Else 
						ACTcfgit_OpcionesGenerales ("problemaAlCambiarElIdParaTramos";->$l_idTramo;$y_control)
					End if 
				End if 
				
				
				$l_idParaTramo:=Num:C11(ACTcfgit_OpcionesGenerales ("retornaIdParaTramoDeEsteItem";->[xxACT_Items:179]ID:1))
				$l_posItem:=Find in array:C230(al_IdsItems;$l_idParaTramo)
				
				If ($l_posItem>-1)
					at_GlosasItems:=$l_posItem
					$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramo")
					$y_control->:=at_GlosasItems{$l_posItem}
					$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"ACTcfg_itemGeneraTramoId")
					$y_control->:=al_IdsItems{$l_posItem}
				End if 
			End if 
		End if 
		
End case 

