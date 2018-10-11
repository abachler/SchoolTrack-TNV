
$emptyFounded:=Find in array:C230(at_STR_CategoriasAnot_Nombres;"")
If ($emptyFounded=-1)
	AL_ExitCell (xALP_Motivos)
	AL_UpdateArrays (xALP_Motivos;0)
	ARRAY TEXT:C222(atSTR_Anotaciones_motivo;0)
	ARRAY LONGINT:C221(aiSTR_Anotaciones_puntaje;0)
	ARRAY LONGINT:C221(aiSTR_Anotaciones_registro;0)
	COPY ARRAY:C226(aiSTR_IDCategoria;$aIdCategorias)
	SORT ARRAY:C229($aIdCategorias;<)
	If (Size of array:C274($aIdCategorias)>0)
		SORT ARRAY:C229($aIdCategorias;<)
		$nextID:=$aIdCategorias{1}+1
	Else 
		$nextID:=1
	End if 
	AT_Insert (0;1;->at_STR_CategoriasAnot_Nombres;->ai_STR_CategoriasAnot_Puntaje;->aiSTR_IDCategoria;->ap_TipoAnotacion;->ai_TipoAnotacion)
	aiSTR_IDCategoria{Size of array:C274(aiSTR_IDCategoria)}:=$nextID
	ai_TipoAnotacion{Size of array:C274(aiSTR_IDCategoria)}:=0
	GET PICTURE FROM LIBRARY:C565("Icono_AnotacionNeutra";$icon)
	ap_TipoAnotacion{Size of array:C274(aiSTR_IDCategoria)}:=$icon
	  //<>aiID_Matriz{Size of array(<>aiID_Matriz)}:=aiSTR_IDCategoria{Size of array(aiSTR_IDCategoria)}
	ARRAY LONGINT:C221($aInt2;2;0)
	AL_SetCellEnter (xALP_categoria;3;Size of array:C274(aiSTR_IDCategoria);0;0;$aInt2;0)
	AL_GetCellEnter (xALP_categoria;3;Size of array:C274(aiSTR_IDCategoria);$enter)
	AL_UpdateArrays (xALP_categoria;-2)
	
	AT_Initialize (->atSTR_Anotaciones_motivo;->aiSTR_Anotaciones_puntaje;->aiSTR_Anotaciones_registradas)
	AL_UpdateArrays (xALP_Motivos;-2)
	
	GOTO OBJECT:C206(xALP_motivos)
	AL_GetCellEnter (xALP_categoria;3;Size of array:C274(aiSTR_IDCategoria);$enter)
	
	
	GOTO OBJECT:C206(xALP_categoria)
	AL_GotoCell (xALP_categoria;1;Size of array:C274(aiSTR_IDCategoria))
	AL_SetCellHigh (xALP_categoria;1;120)
	
	$t_logCambios:=__ ("Se agrega una línea a Categorías de Anotaciones.")+"\n"  //MONO 205385
	APPEND TO ARRAY:C911(at_logCambios;$t_logCambios)
	
Else 
	CD_Dlog (0;__ ("Ya existe una línea vacía para una nueva categoría de anotaciones. Por favor complétela antes de agregar una nueva línea."))
End if 