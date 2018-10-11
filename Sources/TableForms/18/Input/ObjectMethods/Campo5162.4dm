If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+".")
	Self:C308->:=Old:C35(Self:C308->)
Else 
	SAVE RECORD:C53([Asignaturas:18])
	For ($i;1;Size of array:C274(aNtaIdAlumno))
		BM_CreateRequest ("CalculaPromediosGenerales";String:C10(aNtaIdAlumno{$i});String:C10(aNtaIdAlumno{$i}))
	End for 
End if 