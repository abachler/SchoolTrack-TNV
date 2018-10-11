$currLang:=<>vtXS_langage
<>vtXS_langage:=Dynamic pop up menu:C1006(vLanguageMenu;$currLang)
If (<>vtXS_langage#"")
	If ($currLang#<>vtXS_langage)
		PREF_Set (<>lUSR_CurrentUserID;"language";<>vtXS_langage)
		LOC_ChangeLanguage (<>vtXS_langage)
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
		vb_ReloadLogin:=True:C214
		ACCEPT:C269
	End if 
End if 