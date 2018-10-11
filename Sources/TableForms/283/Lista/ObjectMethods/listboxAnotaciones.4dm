  // [xShell_AnotacionesRegistros].Lista.List Box()
  // Por: Alberto Bachler K.: 18-03-15, 10:56:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_columna;$l_fila)
C_POINTER:C301($y_fechaUsuario;$y_listboxAnotaciones)

Case of 
	: (Form event:C388=On Selection Change:K2:29)
		$y_listboxAnotaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"listboxAnotaciones")
		LISTBOX GET CELL POSITION:C971(*;"listboxAnotaciones";$l_columna;$l_fila)
		If ($l_fila>0)
			GOTO SELECTED RECORD:C245([xShell_RecordNotes:283];$l_fila)
			$y_fechaUsuario:=OBJECT Get pointer:C1124(Object named:K67:5;"fecha_y_usuario")
			$y_fechaUsuario->:=__ ("Anotación registrada el ")+DT_FechaISO_a_FechaHora ([xShell_RecordNotes:283]DTS:6)+__ (" por ")+[xShell_RecordNotes:283]Usuario:5
		Else 
			LISTBOX SELECT ROW:C912(*;"listboxAnotaciones";1)
		End if 
End case 