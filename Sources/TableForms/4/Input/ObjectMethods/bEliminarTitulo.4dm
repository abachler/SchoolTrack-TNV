If (USR_checkRights ("M";->[Profesores:4]))
	$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar esta información?");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		QUERY:C277([Profesores_Titulos:216];[Profesores_Titulos:216]ID_Profesor:5;=;[Profesores:4]Numero:1;*)
		QUERY:C277([Profesores_Titulos:216]; & ;[Profesores_Titulos:216]Titulo:1=at_TitulosProfesores{at_TitulosProfesores})
		KRL_DeleteRecord (->[Profesores_Titulos:216])
		DELETE FROM ARRAY:C228(at_TitulosProfesores;at_TitulosProfesores)
	End if 
End if 