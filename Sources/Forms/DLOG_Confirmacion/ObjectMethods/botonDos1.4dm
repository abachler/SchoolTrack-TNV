  // DLOG_Confirmacion.botonDos1()
  // Por: Alberto Bachler: 20/03/13, 19:36:34
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		OBJECT SET VISIBLE:C603(*;"fondoBotonDos";True:C214)
	: (Form event:C388=On Mouse Leave:K2:34)
		OBJECT SET VISIBLE:C603(*;"fondoBotonDos";False:C215)
End case 



