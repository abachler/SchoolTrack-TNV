//%attributes = {}
  //PFsq_ProfesoresSinFotografia

READ ONLY:C145([Profesores:4])
REDUCE SELECTION:C351([Profesores:4];0)
MESSAGES ON:C181
QUERY BY FORMULA:C48([Profesores:4];Picture size:C356([Profesores:4]Fotografia:59)=0)
MESSAGES OFF:C175


  // Modificado por: Alexis Bustamante (29-04-2017)
  //Ticket 180517

If (Not:C34(Shift down:C543))
	QUERY SELECTION:C341([Profesores:4];[Profesores:4]Inactivo:62=False:C215)
End if 
