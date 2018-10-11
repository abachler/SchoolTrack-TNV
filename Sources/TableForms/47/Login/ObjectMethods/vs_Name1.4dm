$preserveEnteredValue:=True:C214
IT_Clairvoyance (Self:C308;-><>atUSR_UserNames;"";$preserveEnteredValue)
Case of 
	: (Form event:C388=On Losing Focus:K2:8)
		If (vs_Name#"")
			GOTO OBJECT:C206(vs_Password)
			$NotSuperUser:=Not:C34(USR_IsSuperUser (vs_Name))
			If ($NotSuperUser)
				READ ONLY:C145([xShell_Users:47])
				QUERY:C277([xShell_Users:47];[xShell_Users:47]login:9=Self:C308->)
				If (Records in selection:C76([xShell_Users:47])=1)
					<>lUSR_CurrentUserID:=[xShell_Users:47]No:1
				Else 
					<>lUSR_CurrentUserID:=0
				End if 
			End if 
			If (<>lUSR_CurrentUserID#0)
				  //<>vtXS_langage:=<>vtXS_DefaultProfileLanguage
				<>vtXS_langage:=PREF_fGet (<>lUSR_CurrentUserID;"language";"")
				vlXS_LastModule:=Num:C11(PREF_fGet (<>lUSR_CurrentUserID;"lastModule";"1"))
				Case of 
					: (<>vtXS_langage="es")
						GET PICTURE FROM LIBRARY:C565(31934;vBandera)
					: (<>vtXS_langage="en")
						GET PICTURE FROM LIBRARY:C565(31935;vBandera)
					: (<>vtXS_langage="fr")
						
					: (<>vtXS_langage="pt")
						GET PICTURE FROM LIBRARY:C565(31936;vBandera)
					: (<>vtXS_langage="it")
						
					: (<>vtXS_langage="de")
						
				End case 
				
			Else 
				<>vtXS_langage:="es"
				vlXS_LastModule:=1
			End if 
			For ($h;1;8)
				$textPointer:=Get pointer:C304("vsXS_ModuleName"+String:C10($h))
				OBJECT SET FONT STYLE:C166($textPointer->;0)
			End for 
			$textPointer:=Get pointer:C304("vsXS_ModuleName"+String:C10(vlXS_LastModule))
			OBJECT SET FONT STYLE:C166($textPointer->;1)
		Else 
			<>vtXS_langage:="es"
			vlXS_LastModule:=1
			_O_DISABLE BUTTON:C193(bInterface)
		End if 
		GOTO OBJECT:C206(*;"PW_PasswordObject")
		
	: (Form event:C388=On After Keystroke:K2:26)
		If (vs_Name="")
			<>vtXS_langage:="es"
			vlXS_LastModule:=1
		End if 
		
		
End case 