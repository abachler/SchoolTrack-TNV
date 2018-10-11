  // [Profesores].Input.Field4()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 11/06/12, 09:42:05
  // ---------------------------------------------


  // CODIGO
  //evita un bug en v12.4 con los filtros con marcador de posición
Case of 
	: (Form event:C388=On After Keystroke:K2:26)
		$t_Keystroke:=Keystroke:C390
		If (($t_Keystroke="M") | ($t_Keystroke="F"))
			POST KEY:C465(9;0)
		End if 
End case 