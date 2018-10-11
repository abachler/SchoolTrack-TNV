  // BBLci_Consola.Item.Editar()
  // Por: Alberto Bachler K.: 29-01-14, 12:18:24
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (USR_checkRights ("M";->[BBL_Items:61]))
	Case of 
		: (Form event:C388=On Clicked:K2:4)
			ModernUI_SetTextAttributes (OBJECT Get name:C1087(Object current:K67:2);-1;0;0;<>vl_ColorTextoBoton_Rojo;<>vl_ColorBarra_Fondo)
			$l_refModulo:=2
			$t_nombreModulo:="MediaTrack"
			$y_tabla:=->[BBL_Items:61]
			$l_recNum:=Record number:C243([BBL_Items:61])
			$l_IdProceso:=New process:C317("BBLci_EditaItem";Pila_256K;"Item en consola";$l_refModulo;$t_nombreModulo;$y_tabla;$l_recNum)
			ModernUI_SetTextAttributes (OBJECT Get name:C1087(Object current:K67:2);-1;0;0;<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
			
		: (Form event:C388=On Mouse Enter:K2:33)
			ModernUI_SetTextAttributes (OBJECT Get name:C1087(Object current:K67:2);-1;0;0;<>vl_ColorTextoBoton_Rojo;<>vl_ColorBarra_Fondo)
			
			
		: (Form event:C388=On Mouse Leave:K2:34)
			ModernUI_SetTextAttributes (OBJECT Get name:C1087(Object current:K67:2);-1;0;0;<>vl_ColorTextoBoton_Normal;<>vl_ColorBarra_Fondo)
			
	End case 
End if 