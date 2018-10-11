
  //PEGAR ESTE CODIGO EN ZEUSSS


Case of 
		
	: (VMaximoPostulantesEnterable=0)
		VMaximoPostulantesEnterable:=1
		  //si esta desactivada la opcion para el ingreso del maximo de postulantes, se activa 
		
		  //activo el ingreso del maximo de candidatos
		OBJECT SET ENTERABLE:C238(iPST_MaxCandidates;True:C214)
		
		  //hace visible la imagen de candado abierto
		OBJECT SET VISIBLE:C603(*;"padlockUnlocked";True:C214)
		OBJECT SET ENTERABLE:C238(iPST_MaxPerSection;False:C215)
		  //hace invisible la imagen de candado cerrado
		OBJECT SET VISIBLE:C603(*;"padlockLocked";False:C215)
		
		GOTO OBJECT:C206(iPST_MaxCandidates)
		  //HIGHLIGHT TEXT([BBL_Lectores]Código_de_barra;Length([BBL_Lectores]Código_de_barra)+1;Length([BBL_Lectores]Código_de_barra)+1)
	: (VMaximoPostulantesEnterable=1)
		VMaximoPostulantesEnterable:=0
		  //se desactiva la opción para el ingreso del máximo de postulantes, en ese caso, se calculará sola
		OBJECT SET ENTERABLE:C238(iPST_MaxCandidates;False:C215)
		
		  //activo el ingreso para los candidatos por seccion, ya que no se puede modificar la cantidad maxima de candidatos
		OBJECT SET ENTERABLE:C238(iPST_MaxPerSection;True:C214)
		  //hace invisible la imagen de candado abierto
		OBJECT SET VISIBLE:C603(*;"padlockUnlocked";False:C215)
		  //hace visible la imagen de candado cerrado
		OBJECT SET VISIBLE:C603(*;"padlockLocked";True:C214)
End case 