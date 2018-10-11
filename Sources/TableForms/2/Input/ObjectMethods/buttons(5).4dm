If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
Else 
	C_LONGINT:C283($i;vJustified)
	If (USR_checkRights ("A";->[Alumnos_Conducta:8]) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20))
		
		KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
		AL_UpdateArrays (xALP_ConductaAlumnos;0)
		$item:=Selected list items:C379(vlTab_Conducta)
		Case of 
			: ($item=4)
				AL_RegistraAtraso 
				AL_LoadLte 
			: ($item=1)
				AL_RegistraInasistencia 
				AL_LoadAbs 
			: ($item=5)
				AL_RegistraAnotacion 
				AL_LoadAnt 
			: ($item=6)
				AL_RegistraCastigo 
				AL_LoadDtn 
			: ($item=7)
				AL_RegistraSuspension 
				AL_LoadSpn 
			: ($item=3)
				AL_RegistraLicencia 
				AL_LoadLic 
		End case 
		OBJECT SET VISIBLE:C603(*;"filtroCdta@";AL_CdtaBehaviourFilter ("mostrarFiltro"))
		
		AL_LeeSintesisConducta ([Alumnos:2]numero:1)
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
		KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key)
	Else 
		USR_ALERT_UserHasNoRights (2)
	End if 
End if 