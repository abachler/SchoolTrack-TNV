If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
	Self:C308->:=Old:C35(Self:C308->)
Else 
	POST KEY:C465(Character code:C91("*");256)
End if 
