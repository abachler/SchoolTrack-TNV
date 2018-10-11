//%attributes = {}
  //Alsq_AlumnosSinFotografia

READ ONLY:C145([Alumnos:2])
REDUCE SELECTION:C351([Alumnos:2];0)
MESSAGES ON:C181
QUERY BY FORMULA:C48([Alumnos:2];Picture size:C356([Alumnos:2]Fotografía:78)=0)
MESSAGES OFF:C175
  // Modificado por: Alexis Bustamante (29-04-2017)
  //Ticket 180517

If (Not:C34(Shift down:C543))
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="Activo")
End if 
