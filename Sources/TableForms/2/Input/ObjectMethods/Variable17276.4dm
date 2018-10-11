If (USR_checkRights ("L";->[Alumnos_ObsOrientacion:127]))
	Case of 
		: (alProEvt=1)
			$line:=AL_GetLine (Self:C308->)
			GOTO SELECTED RECORD:C245([Alumnos_ObsOrientacion:127];$line)
			If ((<>lUSR_RelatedTableUserID#[Alumnos_ObsOrientacion:127]RegistradaPor_Numero:7) & ([Alumnos_ObsOrientacion:127]Public:6=False:C215))
				OBJECT SET VISIBLE:C603(*;"Observaciones";False:C215)
			Else 
				OBJECT SET VISIBLE:C603(*;"Observaciones";True:C214)
			End if 
		: (alProEvt=2)
			$line:=AL_GetLine (Self:C308->)
			GOTO SELECTED RECORD:C245([Alumnos_ObsOrientacion:127];$line)
			If ((<>lUSR_RelatedTableUserID#[Alumnos_ObsOrientacion:127]RegistradaPor_Numero:7) & ([Alumnos_ObsOrientacion:127]Public:6=False:C215))
				CD_Dlog (0;__ ("La observación seleccionada es privada."))
				OBJECT SET VISIBLE:C603(*;"Observaciones";False:C215)
			Else 
				WDW_OpenFormWindow (->[Alumnos_ObsOrientacion:127];"Input";-1;5)
				KRL_ModifyRecord (->[Alumnos_ObsOrientacion:127];"Input")
				CLOSE WINDOW:C154
				QUERY:C277([Alumnos_ObsOrientacion:127];[Alumnos_ObsOrientacion:127]Alumno_Numero:1=[Alumnos:2]numero:1)
				AL_UpdateFields (Self:C308->;2)
				OBJECT SET VISIBLE:C603(*;"Observaciones";True:C214)
			End if 
	End case 
End if 