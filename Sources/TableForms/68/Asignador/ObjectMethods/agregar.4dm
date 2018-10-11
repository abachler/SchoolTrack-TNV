  // [STR_Medicos].Input.inscribir()
  // Por: Alberto Bachler K.: 27-06-14, 15:26:23
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		OBJECT SET HELP TIP:C1181(*;"agregar";__ ("Agregar una Materia al diccionario"))
		
		
	: (Form event:C388=On Clicked:K2:4)
		BBL_AccionesThesaurus ("agregar")
		
End case 