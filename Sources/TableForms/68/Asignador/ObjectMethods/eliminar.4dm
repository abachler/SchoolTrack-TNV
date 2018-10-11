  // [STR_Medicos].Input.retirar()
  // Por: Alberto Bachler K.: 27-06-14, 16:33:40
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		OBJECT SET HELP TIP:C1181(*;"eliminar";__ ("Eliminar materia"))
		
	: (Form event:C388=On Clicked:K2:4)
		BBL_AccionesThesaurus ("eliminar")
End case 
