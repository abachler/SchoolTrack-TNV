If (DateIsValid (Self:C308->))
	AL_UpdateArrays (xALP_Inasistencias;0)
	AL_UpdateArrays (xALP_Subsectores;0)
	vs_SelectedClass:=<>aCursos{<>aCursos}
	ALabs_LoadData (vs_SelectedClass)
	ALabs_UpdateForm 
End if 
SET WINDOW TITLE:C213(String:C10(dFrom;3))