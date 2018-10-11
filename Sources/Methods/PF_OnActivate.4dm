//%attributes = {}
  //PF_OnActivate

Case of 
	: (vsBWR_CurrentModule="SchoolTrack")
		If (Record number:C243([Profesores:4])=-3)
			SET WINDOW TITLE:C213(__ ("Nuevo profesor"))
		Else 
			SET WINDOW TITLE:C213(__ ("Profesores: ")+[Profesores:4]Nombre_comun:21)
		End if 
	: (vsBWR_CurrentModule="AdmissionTrack")
		If (Record number:C243([Profesores:4])=-3)
			SET WINDOW TITLE:C213(__ ("Nuevo Entrevistador"))
		Else 
			SET WINDOW TITLE:C213(__ ("Entrevistadores: ")+[Profesores:4]Nombre_comun:21)
		End if 
End case 
