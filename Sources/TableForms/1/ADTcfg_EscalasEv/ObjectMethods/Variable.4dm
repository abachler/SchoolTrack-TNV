AL_UpdateArrays (xALP_Indicadores;0)
Case of 
	: (Self:C308-><Size of array:C274(atPST_Indicadores))  //numero menor al actual numero de indicadores, se deben eliminar algunos
		$rowstoDelete:=Size of array:C274(atPST_Indicadores)-Self:C308->
		AT_Delete (1;$rowstoDelete;->atPST_Indicadores;->atPST_NombreIndicador)
		AL_UpdateArrays (xALP_Indicadores;-2)
	: (Self:C308->>Size of array:C274(atPST_Indicadores))  //numero mayor al numero de indicadores, se inserta al final solamente
		_O_C_INTEGER:C282($rowsToInsert)
		$rowsToInsert:=Self:C308->-Size of array:C274(atPST_Indicadores)
		AT_Insert (1;$rowsToInsert;->atPST_Indicadores;->atPST_NombreIndicador)
		AL_UpdateArrays (xALP_Indicadores;-2)
		GOTO OBJECT:C206(xALP_Indicadores)
		AL_GotoCell (xALP_Indicadores;1;1)
End case 