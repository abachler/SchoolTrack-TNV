$emptyFounded:=Find in array:C230(atSTRal_MotivosSuspension;"")
If ($emptyFounded=-1)
	AT_Insert (0;1;->atSTRal_MotivosSuspension)
	AL_UpdateArrays (xALP_Suspensiones;-2)
	GOTO OBJECT:C206(xALP_Suspensiones)
	AL_GotoCell (xALP_Suspensiones;1;Size of array:C274(atSTRal_MotivosSuspension))
	AL_SetCellHigh (xALP_Suspensiones;1;120)
Else 
	CD_Dlog (0;__ ("Ya existe una línea vacía para una nuevo motivo de castigo. Por favor complétela antes de agregar una nueva línea."))
End if 