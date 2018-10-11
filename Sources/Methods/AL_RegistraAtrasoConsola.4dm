//%attributes = {}
  //AL_RegistraAtrasoConsola


If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("El registro de información conductual está bloqueado para el ciclo escolar actual a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5))
Else 
	If (USR_GetMethodAcces (Current method name:C684))
		WDW_OpenFormWindow (->[Alumnos_Conducta:8];"Consola_de_Atrasos";7;4;__ ("Atrasos"))
		DIALOG:C40([Alumnos_Conducta:8];"Consola_de_Atrasos")
		CLOSE WINDOW:C154
	End if 
End if 