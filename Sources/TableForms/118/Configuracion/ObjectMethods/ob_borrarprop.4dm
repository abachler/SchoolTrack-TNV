

Case of 
	: (Form event:C388=On Clicked:K2:4)
		
		  // Declaraciones
		C_POINTER:C301($y_propiedades)
		C_LONGINT:C283($l_columna;$l_fila)
		
		  // Punteros a los controles de la interfaz
		$y_propiedades:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_propiedades")
		
		If (Size of array:C274($y_propiedades->)>0)
			
			  // obtener el nuemro de la fila del ultimo elemento seleccionado
			LISTBOX GET CELL POSITION:C971(*;"ob_listbox";$l_columna;$l_fila)
			
			  // Se elimina solo si se ha seleccionado algo
			
			If ($l_fila>0)
				  // Elimino la fila del control
				LISTBOX DELETE ROWS:C914(*;"ob_listbox";$l_fila;1)
				
				  // Selecciono una fila del listabox para solventar a que el comando LISTBOX GET CELL POSITION despues de realizarse una vez
				  // si se realiza sin seleccionar nada  despues de ello devuelve la posicion de la ejecucion anterior.
				  // Se eleva el valor de $l_fila, ya que si se pasa 0 a LISTBOX SELECT ROW, selecciona la lista completa, si no se decrementa para dejar seleccionado el elemento anterior
				If ($l_fila>1)
					$l_fila:=$l_fila-1
				End if 
				LISTBOX SELECT ROW:C912(*;"ob_listbox";$l_fila)
				
			End if 
			
		Else 
			CD_Dlog (0;"Actualmente no posee propiedades adicionales configuradas.")
		End if 
		
End case 
