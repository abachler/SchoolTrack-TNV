$emptyFounded:=Find in array:C230(atSTRal_MotivosCastigo;"")
If ($emptyFounded=-1)
	AT_Insert (0;1;->atSTRal_MotivosCastigo)
	AL_UpdateArrays (xALP_castigos;-2)
	GOTO OBJECT:C206(xALP_castigos)
	AL_GotoCell (xALP_castigos;1;Size of array:C274(atSTRal_MotivosCastigo))
	AL_SetCellHigh (xALP_castigos;1;120)
Else 
	CD_Dlog (0;__ ("Ya existe una línea vacía para una nuevo motivo de castigo. Por favor complétela antes de agregar una nueva línea."))
End if 