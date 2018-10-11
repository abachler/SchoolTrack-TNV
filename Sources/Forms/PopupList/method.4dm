  // PopupList()
  // Por: Alberto Bachler K.: 01-07-14, 20:57:07
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_abajo;$l_alturaVentana;$l_anchoLista;$l_Arriba;$l_derecha;$l_izquierda)


ARRAY LONGINT:C221($al_refItems;0)
ARRAY TEXT:C222($at_Items;0)

Case of 
	: (Form event:C388=On Load:K2:1)
		
		GET WINDOW RECT:C443($l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
		
		If (Count list items:C380(LV_ListaValores_hl)<9)
			$l_alturaVentana:=Count list items:C380(LV_ListaValores_hl)*20
		End if 
		
		For ($i;1;Count list items:C380(LV_ListaValores_hl))
			GET LIST ITEM:C378(LV_ListaValores_hl;$i;$l_refItem;$t_textoItem)
			APPEND TO ARRAY:C911($at_Items;$t_textoItem)
		End for 
		$l_anchoLista:=hmFree_GetArrayWidth ($at_Items;OBJECT Get font:C1069(LV_ListaValores_hl);OBJECT Get font size:C1070(LV_ListaValores_hl);OBJECT Get font style:C1071(LV_ListaValores_hl))
		
		If (($l_izquierda+$l_anchoLista+20)>Screen width:C187)
			$l_anchoLista:=Screen width:C187-20
		Else 
			$l_anchoLista:=$l_anchoLista+20
		End if 
		SET WINDOW RECT:C444($l_izquierda;$l_Arriba;$l_izquierda+$l_anchoLista;$l_Arriba+$l_alturaVentana)
		
		SELECT LIST ITEMS BY POSITION:C381(LV_ListaValores_hl;1)
		SET LIST PROPERTIES:C387(LV_ListaValores_hl;_o_Ala Macintosh:K28:1;_o_Macintosh node:K28:5;20)
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Validate:K2:3)
		If (Selected list items:C379(LV_ListaValores_hl)>0)
			GET LIST ITEM:C378(LV_ListaValores_hl;Selected list items:C379(LV_ListaValores_hl);LV_refItemSeleccionado_l;LV_textoItemSeleccionado_t)
		Else 
			LV_refItemSeleccionado_l:=0
			LV_textoItemSeleccionado_t:=""
		End if 
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

