Case of 
	: (Form event:C388=On Data Change:K2:15)
		  // Declaraciones
		C_POINTER:C301($y_propiedades;$y_valores)
		C_LONGINT:C283($l_columna;$l_fila)
		C_TEXT:C284($t_propiedad)
		C_BOOLEAN:C305($b_duplicada)
		
		  // Punteros a los controles de la interfaz
		$y_propiedades:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_propiedades")
		$y_valores:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_valores")
		
		  // obtener el nuemro de la fila del ultimo elemento seleccionado
		LISTBOX GET CELL POSITION:C971(*;"ob_listbox";$l_columna;$l_fila)
		
		For ($i;1;Size of array:C274($y_propiedades->))
			If ($i#$l_fila)
				If (($y_propiedades->{$i}=$y_propiedades->{$l_fila}))
					$b_duplicada:=True:C214
					$i:=Size of array:C274($y_propiedades->)+1
				End if 
			End if 
		End for 
		
		  // Si existe duplicidad se manipula el nombre creado
		If ($b_duplicada)
			CD_Dlog (0;"La propiedad definida ya existe.\n\nLa edicion se ha cancelado.")
			$y_propiedades->{$l_fila}:=$y_propiedades->{0}
		End if 
		
End case 