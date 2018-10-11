  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce
  // Fecha y hora: 05/01/18, 13:16:49
  // ----------------------------------------------------
  // Método: [ACT_Avisos_de_Cobranza].ReferenciasMX.vtACT_referenciaBusqueda
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------
Case of 
	: (Form event:C388=On After Edit:K2:43)
		  // Usuario (SO): Saul Ponce Ticket Nº 193649 Fecha y hora: 03/01/18, 10:26:51
		C_TEXT:C284($t_textoIngresado)
		$t_textoIngresado:=Get edited text:C655
		OBJECT SET ENABLED:C1123(*;"bBanco@";(Length:C16($t_textoIngresado)<=3))
		
		If (Length:C16($t_textoIngresado)>3)
			Variable4:=""
		End if 
		
	: (Form event:C388=On Data Change:K2:15)
		  //POST KEY(Character code("+");256)
End case 