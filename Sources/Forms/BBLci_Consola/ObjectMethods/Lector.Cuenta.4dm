  // BBLci_Consola.infoLector_Cuenta()
  // Por: Alberto Bachler: 25/10/13, 21:12:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_botonActivo;$b_conMovimientos)
C_POINTER:C301($y_Boton)
C_TEXT:C284($t_tituloBoton)

$b_botonActivo:=OBJECT Get enabled:C1079(*;OBJECT Get name:C1087(Object current:K67:2))

If ($b_botonActivo)
	$t_tituloBoton:=OBJECT Get title:C1068(*;OBJECT Get name:C1087(Object current:K67:2))
	$y_Boton:=OBJECT Get pointer:C1124(Object current:K67:2)
	Case of 
		: (Form event:C388=On Clicked:K2:4)
			ModernUI_SetTextAttributes (OBJECT Get name:C1087(Object current:K67:2);Bold:K14:2;0;0;<>vl_ColorTextoBoton_Azul;<>vl_ColorBarra_Fondo)
			QUERY:C277([BBL_Transacciones:59];[BBL_Transacciones:59]ID_User:4=[BBL_Lectores:72]ID:1)
			ORDER BY:C49([BBL_Transacciones:59];[BBL_Transacciones:59]Fecha:3;<)
			
			WDW_OpenPopupWindow (OBJECT Get pointer:C1124(Object current:K67:2);->[BBL_Lectores:72];"MovimientosCuenta";Pop up form window:K39:11)
			DIALOG:C40([BBL_Lectores:72];"MovimientosCuenta")
			CLOSE WINDOW:C154
			ModernUI_SetTextAttributes (OBJECT Get name:C1087(Object current:K67:2);-1;0;0;<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
			
		: (Form event:C388=On Mouse Enter:K2:33)
			ModernUI_SetTextAttributes (OBJECT Get name:C1087(Object current:K67:2);-1;0;0;<>vl_ColorTextoBoton_Azul;<>vl_ColorBarra_Fondo)
			
		: (Form event:C388=On Mouse Leave:K2:34)
			ModernUI_SetTextAttributes (OBJECT Get name:C1087(Object current:K67:2);-1;0;0;<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
	End case 
	
End if 





