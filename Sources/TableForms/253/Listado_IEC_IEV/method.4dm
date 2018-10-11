Case of 
	: (Form event:C388=On Load:K2:1)
		ACTiecv_cargaArreglosListado ("CargaArreglos")
		
	: (Form event:C388=On Close Box:K2:21)
		ACTiecv_cargaArreglosListado ("SalidaFormulario")
		
End case 