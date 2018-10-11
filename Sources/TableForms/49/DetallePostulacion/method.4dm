Case of 
	: (Form event:C388=On Load:K2:1)
		  //se inicializan los arreglos que tendrán los campos que se editen que deben ser enviados al servidor nuevamente
		XS_SetInterface 
		xALPSet_ADN_DetallePostulacion 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
