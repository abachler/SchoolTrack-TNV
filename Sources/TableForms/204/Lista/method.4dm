  // [MPA_ObjetosMatriz].Lista()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 08/01/13, 11:40:09
  // ---------------------------------------------


  // CODIGO
Case of 
	: (Form event:C388=On Header:K2:17)
		  //ORDER BY([MPA_ObjetosMatriz];[MPA_ObjetosMatriz]Llave_unica)
		
	: (Form event:C388=On Display Detail:K2:22)
		RELATE ONE:C42([MPA_ObjetosMatriz:204]ID_Matriz:1)
		
End case 



