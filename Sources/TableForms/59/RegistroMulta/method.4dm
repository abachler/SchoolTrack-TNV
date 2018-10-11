  // [BBL_Transacciones].RegistroMulta()
  // Por: Alberto Bachler: 22/10/13, 17:29:15
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET RGB COLORS:C628(*;"barra@";<>vl_ColorBarra_Borde;<>vl_ColorBarra_Fondo)
		OBJECT SET TITLE:C194(*;"titulo";"Multa a "+[BBL_Lectores:72]Nombre_Comun:35)
		OBJECT SET RGB COLORS:C628(*;"botonAceptar";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
		OBJECT SET RGB COLORS:C628(*;"botonCancelar";<>vl_ColorTextoBoton_Normal;<>vl_ColorBarra_Fondo)
		GOTO OBJECT:C206(*;"montoMulta")
		
		Case of 
			: (vl_modoConsola=Pago)
				FORM GOTO PAGE:C247(2)
			: (vl_modoConsola=Multa)
				FORM GOTO PAGE:C247(1)
				OBJECT SET VISIBLE:C603(*;"montoPagado@";False:C215)
		End case 
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
	: (Form event:C388=On Validate:K2:3)
		
		
End case 



