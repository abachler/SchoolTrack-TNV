//%attributes = {}
  // FMsq_FamiliasSinFotografia

READ ONLY:C145([Familia:78])
REDUCE SELECTION:C351([Familia:78];0)
MESSAGES ON:C181
QUERY BY FORMULA:C48([Familia:78];Picture size:C356([Familia:78]Fotografia:35)=0)
MESSAGES OFF:C175

  // Modificado por: Alexis Bustamante (29-04-2017)
  //Ticket 180517
If (Not:C34(Shift down:C543))
	QUERY SELECTION:C341([Familia:78];[Familia:78]Inactiva:31=False:C215)
End if 
