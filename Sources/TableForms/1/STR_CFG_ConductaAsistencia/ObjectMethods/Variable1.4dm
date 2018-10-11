  //POST KEY(Character code("2");256)

AL_ExitCell (xALP_Motivos)
$line:=AL_GetLine (xALP_categoria)
$lineAnotacion:=AL_GetLine (xALP_Motivos)
If ($line=0)
	CD_Dlog (0;__ ("Debe seleccionar la categoría");__ ("");__ ("Aceptar"))
Else 
	$emptyFounded:=Find in array:C230(<>atSTR_Anotaciones_motivo;"")
	If ($emptyFounded=-1)
		AL_UpdateArrays (xALP_Motivos;0)
		AT_Insert (0;1;->atSTR_Anotaciones_motivo;->aiSTR_Anotaciones_puntaje;->aiSTR_Anotaciones_registradas)
		AT_Insert (0;1;-><>aiID_Matriz;-><>atSTR_Anotaciones_categorias;-><>atSTR_Anotaciones_motivo;-><>aiSTR_Anotaciones_puntaje;-><>aiSTR_Anotaciones_motivo_puntaj)
		aiSTR_Anotaciones_puntaje{Size of array:C274(aiSTR_Anotaciones_puntaje)}:=ai_STR_CategoriasAnot_Puntaje{$line}
		aiSTR_Anotaciones_registradas{Size of array:C274(aiSTR_Anotaciones_puntaje)}:=0
		$size:=Size of array:C274(<>aiID_Matriz)
		<>aiID_Matriz{$size}:=aiSTR_IDCategoria{$line}
		<>atSTR_Anotaciones_categorias{$size}:=at_STR_CategoriasAnot_Nombres{$line}
		<>aiSTR_Anotaciones_puntaje{$size}:=aiSTR_Anotaciones_puntaje{Size of array:C274(aiSTR_Anotaciones_puntaje)}
		<>aiSTR_Anotaciones_motivo_puntaj{$size}:=aiSTR_Anotaciones_puntaje{Size of array:C274(aiSTR_Anotaciones_puntaje)}
		AL_UpdateArrays (xALP_Motivos;-2)
		GOTO OBJECT:C206(xALP_Motivos)
		AL_GotoCell (xALP_Motivos;1;Size of array:C274(atSTR_Anotaciones_motivo))
		AL_SetCellHigh (xALP_Motivos;1;80)
		$t_logCambios:=__ ("Se agrega una línea de Motivo de Anotación.")+"\n"  //MONO 205385
		APPEND TO ARRAY:C911(at_logCambios;$t_logCambios)
	Else 
		CD_Dlog (0;__ ("Ya existe una línea vacía para un nuevo motivo de anotación. Por favor complétela antes de agregar una nueva línea."))
	End if 
End if 