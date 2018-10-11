
Case of 
	: (Form event:C388=On Clicked:K2:4)
		  // Declaraciones
		C_POINTER:C301($y_propiedades;$y_valores)
		C_LONGINT:C283($l_posicion;$l_contador;$l_indide)
		C_BOOLEAN:C305($b_continuar)
		
		  // Punteros a los controles de la interfaz
		$y_propiedades:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_propiedades")
		$y_valores:=OBJECT Get pointer:C1124(Object named:K67:5;"ob_valores")
		
		  // Posicion donde agregar la nueva fila 0 para el inicio, n para una posicion especifica, > a size of array al final de la lista (arrays)
		$l_posicion:=Size of array:C274($y_propiedades->)+1
		
		  // Determinar nombre de propiedad
		$b_continuar:=True:C214
		$l_indide:=1
		While ($b_continuar)
			$l_contador:=0
			$l_contador:=Count in array:C907($y_propiedades->;"Nueva Propiedad "+String:C10($l_indide))
			If ($l_contador=0)
				$b_continuar:=False:C215
				$l_contador:=$l_indide
			Else 
				$l_indide:=$l_indide+1
			End if 
		End while 
		
		  // Inserto la nueva fila en el control
		LISTBOX INSERT ROWS:C913(*;"ob_listbox";$l_posicion;1)
		
		  // Inicializo nueva posicion
		$y_propiedades->{Size of array:C274($y_propiedades->)}:="Nueva Propiedad "+String:C10($l_contador)
		$y_valores->{Size of array:C274($y_valores->)}:="Valor"
		
End case 