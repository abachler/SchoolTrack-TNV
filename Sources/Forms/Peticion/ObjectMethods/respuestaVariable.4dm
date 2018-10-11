  // Peticion.respuestaVariable()
  // Por: Alberto Bachler K.: 02-09-14, 10:30:41
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: ((Form event:C388=On Losing Focus:K2:8) | (Form event:C388=On Mouse Leave:K2:34))
		vt_Respuesta:=Get edited text:C655
		OBJECT SET VISIBLE:C603(*;"respuestaTextoEjemplo";vt_Respuesta="")
		
	: (Form event:C388=On After Keystroke:K2:26)
		OBJECT SET VISIBLE:C603(*;"respuestaTextoEjemplo";Get edited text:C655="")
		
	Else 
		
End case 
