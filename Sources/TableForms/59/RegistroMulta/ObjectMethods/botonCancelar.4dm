  // [BBL_Transacciones].RegistroMulta.botonCancelar()
  // Por: Alberto Bachler: 22/10/13, 18:09:12
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		OBJECT SET RGB COLORS:C628(*;$t_nombreObjeto;<>vl_ColorTextoBoton_MouseOn;<>vl_ColorBarra_Fondo)
		
	: (Form event:C388=On Mouse Leave:K2:34)
		OBJECT SET RGB COLORS:C628(*;$t_nombreObjeto;<>vl_ColorTextoBoton_Normal;<>vl_ColorBarra_Fondo)
		
End case 

