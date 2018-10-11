  // DLOG_Confirmacion.botonTres1()
  // Por: Alberto Bachler: 20/03/13, 19:37:17
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		OBJECT SET VISIBLE:C603(*;"fondoBotonCuatro";True:C214)
	: (Form event:C388=On Mouse Leave:K2:34)
		OBJECT SET VISIBLE:C603(*;"fondoBotonCuatro";False:C215)
End case 



