Case of 
	: (Form event:C388=On Data Change:K2:15)
		C_LONGINT:C283($col;$row)
		C_POINTER:C301($y_StatusAlumnoAlias;$y_StatusAlumnoVisible)
		$y_StatusAlumnoAlias:=OBJECT Get pointer:C1124(Object named:K67:5;"statusAlumnoAlias")
		$y_StatusAlumnoVisible:=OBJECT Get pointer:C1124(Object named:K67:5;"statusAlumnoVisible")
		
		LISTBOX GET CELL POSITION:C971(*;"lbStatusAlumno";$col;$row)
		  //Validaciones de Edición
		Case of   //Las lineas están validadas de manera fija porque el listbox no está seteado para ordenarse y las posiciones de los status son siempre las mismas
			: (($col=3) & ($row=1))  // Status visible del alumno "Activo" no puede ser false
				If (Not:C34($y_StatusAlumnoVisible->{$row}))
					$y_StatusAlumnoVisible->{$row}:=True:C214
					CD_Dlog (0;__ ("El Status Activo debe ser visible"))
				End if 
				
			: ($col=2)  //Los Alias no pueden quedar en blanco
				If (ST_GetCleanString ($y_StatusAlumnoAlias->{$row})="")
					$y_StatusAlumnoAlias->{$row}:=<>at_StatusAlumnoAlias{$row}
					CD_Dlog (0;__ ("Los Alias para los status no pueden estar vacios"))
				End if 
		End case 
		
End case 