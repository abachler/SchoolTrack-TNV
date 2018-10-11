//%attributes = {}
  //XS_Init

If (Not:C34(<>OnServer))
	$vi_VSisDefined:=Num:C11(PREF_fGet (0;"VirtualStructureDefined";"0"))
	If (($vi_VSisDefined=0) & (Not:C34(USR_GetUserID <0)))
		CD_Dlog (0;__ ("La aplicación no ha sido configurada y usted no dispone de los privilegios necesarios para hacerlo.\rLa aplicación no puede ser utilizada."))
		QUIT 4D:C291
	End if 
	
	If (((Macintosh option down:C545 | Windows Alt down:C563) & (Shift down:C543) & (Macintosh command down:C546 | Windows Ctrl down:C562)) | ($vi_VSisDefined=0))
		If (<>lUSR_CurrentUserID<0)
			XS_Settings 
		Else 
			CD_Dlog (0;__ ("disable button(bEnter)"))
		End if 
	End if 
	
	$vi_VSisDefined:=Num:C11(PREF_fGet (0;"VirtualStructureDefined";"0"))
	If ($vi_VSisDefined=1)
		QUERY:C277([xShell_Tables:51];[xShell_Tables:51]PosicionEnExplorador:16>0)
		If (Records in selection:C76([xShell_Tables:51])>0)
			  //ORDER BY([xShell_Tables];[xShell_Tables]BrowserPositionNumber;>)
			  //SELECTION TO ARRAY([xShell_Tables]Alias;$aTableAlias;[xShell_Tables]TableNumber;$aTableNums)
			  //ARRAY TO LIST($aTableAlias;"XS_Browser";$aTableNums)
			  //LIST TO ARRAY("XS_Application";$at_applicationConstants)
		Else 
			PREF_Set (0;"VirtualStructureDefined";"0")
			CD_Dlog (0;__ ("disable button(bEnter)"))
		End if 
	Else 
		CD_Dlog (0;__ ("disable button(bEnter)"))
	End if 
End if 


