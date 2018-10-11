If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Script ◊aUFOcc
	  //Autor: Alberto Bachler
	  //Creada el 20/6/96 a 11:53 AM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
Case of 
	: (_O_During:C30)
		If (<>aUFvalues#0)
			_O_ENABLE BUTTON:C192(bdelV)
			_O_ENABLE BUTTON:C192(baddV)
			sUFvalue:=<>aUFvalues{<>aUFvalues}
		Else 
			_O_DISABLE BUTTON:C193(bdelV)
		End if 
End case 
