  // DLOG_Confirmacion.botonUno1()
  // Por: Alberto Bachler: 20/03/13, 19:23:00
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		OBJECT SET VISIBLE:C603(*;"fondoBotonUno";True:C214)
	: (Form event:C388=On Mouse Leave:K2:34)
		OBJECT SET VISIBLE:C603(*;"fondoBotonUno";False:C215)
End case 