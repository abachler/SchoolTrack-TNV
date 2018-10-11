
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket Nº 187484
  // Fecha y hora: 02-10-18, 09:43:42
  // ----------------------------------------------------
  // Método: [xxSTR_Constants].ACTwiz_AsignaIDGlosaParaTramos.chk_todos
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------



Case of 
	: (Form event:C388=On Clicked:K2:4)
		
		C_BOOLEAN:C305($b_asignar)
		C_POINTER:C301($y_checkTodos)
		C_POINTER:C301($y_columnaAsignable)
		
		$y_checkTodos:=OBJECT Get pointer:C1124(Object named:K67:5;"chk_todos")
		$y_columnaAsignable:=OBJECT Get pointer:C1124(Object named:K67:5;"ab_asignable")
		$b_asignar:=($y_checkTodos->=1)
		
		AT_Populate ($y_columnaAsignable;->$b_asignar)
		ACTwiz_AsignaIDGlosaTramosMas ("habilitarProximaPaginaForm")
		ACTwiz_AsignaIDGlosaTramosMas ("actualizaContadores")
End case 