  // BBLci_Consola.Item.TotalPrestamos()
  // Por: Alberto Bachler K.: 18-02-14, 19:29:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_botonActivo)
C_LONGINT:C283($l_resultado)
C_POINTER:C301($y_Boton)
C_TEXT:C284($t_numeroItems;$t_tituloBoton)

C_LONGINT:C283(vl_tablaSubForm)

$b_botonActivo:=OBJECT Get enabled:C1079(*;OBJECT Get name:C1087(Object current:K67:2))

If ($b_botonActivo)
	$t_tituloBoton:=OBJECT Get title:C1068(*;OBJECT Get name:C1087(Object current:K67:2))
	$y_Boton:=OBJECT Get pointer:C1124(Object current:K67:2)
	Case of 
		: (Form event:C388=On Clicked:K2:4)
			ModernUI_SetTextAttributes (OBJECT Get name:C1087(Object current:K67:2);-1;0;0;<>vl_ColorTextoBoton_Azul;<>vl_ColorBarra_Fondo)
			READ WRITE:C146([BBL_Prestamos:60])
			QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_Item:11=[BBL_Items:61]Numero:1;*)
			QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Número_de_lector:2>0)
			ORDER BY:C49([BBL_Prestamos:60];[BBL_Prestamos:60]Fecha_de_devolución:5;>;[BBL_Prestamos:60]Hasta:4;<)
			$l_resultado:=BBLci_InfoPrestamos (->[BBL_Prestamos:60];"ListaPrestamos_Items")
			ModernUI_SetTextAttributes (OBJECT Get name:C1087(Object current:K67:2);-1;0;0;<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
			
			
		: (Form event:C388=On Mouse Enter:K2:33)
			ModernUI_SetTextAttributes (OBJECT Get name:C1087(Object current:K67:2);-1;0;0;<>vl_ColorTextoBoton_Azul;<>vl_ColorBarra_Fondo)
			
		: (Form event:C388=On Mouse Leave:K2:34)
			ModernUI_SetTextAttributes (OBJECT Get name:C1087(Object current:K67:2);-1;0;0;<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
	End case 
End if 




