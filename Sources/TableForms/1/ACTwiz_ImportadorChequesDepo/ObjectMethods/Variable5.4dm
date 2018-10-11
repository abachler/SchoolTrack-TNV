
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce
  // Fecha y hora: 05/10/17, 12:44:11
  // ----------------------------------------------------
  // Método: [xxSTR_Constants].ACTwiz_ImportadorChequesDepo.Variable5
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

If (vi_PageNumber=1)
	vi_PageNumber:=2
	FORM GOTO PAGE:C247(vi_PageNumber)
	POST KEY:C465(Character code:C91("+");256)
End if 


