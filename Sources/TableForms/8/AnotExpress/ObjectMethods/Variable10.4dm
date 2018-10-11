$line:=AL_GetLine (xALP_Anot)

If ($line>0)
	AT_Delete ($line;1;->atSTRal_NombreAlumno;->adSTRal_FechaAnotacion;->atSTRal_NombreProfesorAnot;->atSTRal_MotivoAnotacion;->alSTRal_NoProfesorAnot;->atSTRal_NotasAnotacion;->atSTRal_CategoriaAnotacion;->alSTRal_PuntosAnotacion;->alSTRal_NumeroAlumno;->atSTRal_TipoAnotacion;->atSTRal_AsignaturaAnot)
	(OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.alumno"))->:=""
	(OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.motivo"))->:=""
	  // Modificado por: Saúl Ponce (18-05-2017) Ticket Nº 181881, el puntero quedaba indefinido con esta nomenclatura
	  //(OBJECT Get pointer(Object named;"anotacion.idAlumno"))->:=0
	(OBJECT Get pointer:C1124(Object named:K67:5;"idAlumno"))->:=0
	
	AL_UpdateArrays (xALP_Anot;Size of array:C274(atSTRal_NombreAlumno))
	GOTO OBJECT:C206(sName)
	AL_SetLine (xALP_Anot;0)
	$line:=0
Else 
	BEEP:C151
End if 
