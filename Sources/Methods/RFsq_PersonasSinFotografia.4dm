//%attributes = {}
  //RFsq_PersonasSinFotografia

READ ONLY:C145([Personas:7])
REDUCE SELECTION:C351([Personas:7];0)
MESSAGES ON:C181
QUERY BY FORMULA:C48([Personas:7];Picture size:C356([Personas:7]Fotografia:43)=0)
MESSAGES OFF:C175



  // Modificado por: Alexis Bustamante (29-04-2017)
  //Ticket 180517

If (Not:C34(Shift down:C543))
	QUERY SELECTION:C341([Personas:7];[Personas:7]Inactivo:46=False:C215)
End if 




