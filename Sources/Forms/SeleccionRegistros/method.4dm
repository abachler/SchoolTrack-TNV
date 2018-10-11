  // SeleccionRegistros()
  // Por: Alberto Bachler: 01/10/13, 13:26:25
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283(vl_tablaSubForm)

Case of 
	: (Form event:C388=On Load:K2:1)
		
		Case of 
			: (vl_tablaSubForm=Table:C252(->[BBL_Lectores:72]))
				FORM GET PROPERTIES:C674([BBL_Lectores:72];"Seleccion";vl_anchoSubform;vl_AltoSubForm)
				GET WINDOW RECT:C443($l_izquierdaVentana;$l_arribaVentana;$l_derechaVentana;$l_abajoVentana)
				SET WINDOW RECT:C444($l_izquierdaVentana;$l_arribaVentana;$l_izquierdaVentana+vl_anchoSubform;$l_arribaVentana*5)
				FORM GOTO PAGE:C247(1)
				
			: (vl_tablaSubForm=Table:C252(->[BBL_Items:61]))
				FORM GET PROPERTIES:C674([BBL_Items:61];"Seleccion";vl_anchoSubform;vl_AltoSubForm)
				FORM GOTO PAGE:C247(2)
				
			: (vl_tablaSubForm=Table:C252(->[BBL_Prestamos:60]))
				
		End case 
		
	: (Form event:C388=On Clicked:K2:4)
		
	: (Form event:C388=On Double Clicked:K2:5)
		ACCEPT:C269
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
	: (Form event:C388=On Selection Change:K2:29)
		
		
End case 







