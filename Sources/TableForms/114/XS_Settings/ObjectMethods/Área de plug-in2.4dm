Case of 
	: (ALProEvt=1)
		$line:=AL_GetLine (Self:C308->)
		IT_SetButtonState (($line>0);->bDelLine)
	: (ALProEvt=3)  //empty area single click
		
	: (ALProevt=4)  //empty area double click
		
	: (ALProEvt=5)  //right clcik on area with data
		$line:=AL_GetLine (Self:C308->)
		IT_SetButtonState (($line>0);->bDelLine)
		LIST TO ARRAY:C288("XS_Modules";$aContextualMenuItems)
		INSERT IN ARRAY:C227($aContextualMenuItems;Size of array:C274($aContextualMenuItems)+1;2)
		$aContextualMenuItems{Size of array:C274($aContextualMenuItems)-1}:="-"
		$aContextualMenuItems{Size of array:C274($aContextualMenuItems)}:="Todos los Módulos"
		$el:=Find in array:C230($aContextualMenuItems;atXS_Methods_Module{$line})
		If ($el>0)
			$aContextualMenuItems{$el}:=("!"+Char:C90(195))+$aContextualMenuItems{$el}
		End if 
		
		INSERT IN ARRAY:C227($aContextualMenuItems;Size of array:C274($aContextualMenuItems)+1;6)
		$aContextualMenuItems{Size of array:C274($aContextualMenuItems)-5}:="-"
		$aContextualMenuItems{Size of array:C274($aContextualMenuItems)-4}:=("!"+Char:C90(195))*Num:C11(abXS_Methods_Executable{$line})+"Ejecutable desde Consola"
		$aContextualMenuItems{Size of array:C274($aContextualMenuItems)-3}:=("!"+Char:C90(195))*Num:C11(abXS_Methods_AuthRequired{$line})+"Requiere autorización"
		$aContextualMenuItems{Size of array:C274($aContextualMenuItems)-2}:=("!"+Char:C90(195))*Num:C11(abXS_Methods_ExecOnClient{$line})+"Ejecución local"
		$aContextualMenuItems{Size of array:C274($aContextualMenuItems)-1}:="-"
		$aContextualMenuItems{Size of array:C274($aContextualMenuItems)}:="Modificar descripción..."
		$menuItems:=""
		For ($i;1;Size of array:C274($aContextualMenuItems))
			$menuItems:=$menuItems+$aContextualMenuItems{$i}+";"
		End for 
		$menuItems:=Substring:C12($menuItems;1;Length:C16($menuItems)-1)
		$choice:=Pop up menu:C542($menuItems)
		
		If ($choice>0)
			Case of 
				: ($choice<=(Count list items:C380(hl_Modules)+2))
					atXS_Methods_Module{$line}:=$aContextualMenuItems{$choice}
					
				: ($choice=(Count list items:C380(hl_Modules)+4))  //executable
					If (abXS_Methods_Executable{$line})
						abXS_Methods_Executable{$line}:=False:C215
					Else 
						abXS_Methods_Executable{$line}:=True:C214
					End if 
					
				: ($choice=(Count list items:C380(hl_Modules)+5))  //permission required
					If (abXS_Methods_AuthRequired{$line})
						abXS_Methods_AuthRequired{$line}:=False:C215
					Else 
						abXS_Methods_AuthRequired{$line}:=True:C214
					End if 
					
				: ($choice=(Count list items:C380(hl_Modules)+6))  //execution on client
					If (abXS_Methods_ExecOnClient{$line})
						abXS_Methods_ExecOnClient{$line}:=False:C215
					Else 
						abXS_Methods_ExecOnClient{$line}:=True:C214
					End if 
				: ($choice=(Count list items:C380(hl_Modules)+8))  //modificar descripcion
					vtXS_CommandDesc:=atXS_Methods_Description{$line}
					WDW_OpenFormWindow (->[xShell_Dialogs:114];"XS_ExeCommsDescription";0;4;__ ("Descripción para ")+atXS_Methods_Name{$line})
					DIALOG:C40([xShell_Dialogs:114];"XS_ExeCommsDescription")
					CLOSE WINDOW:C154
					If (OK=1)
						atXS_Methods_Description{$line}:=Replace string:C233(vtXS_CommandDesc;"\r";" ")
					End if 
			End case 
			AL_UpdateArrays (Self:C308->;-2)
			AL_SetLine (Self:C308->;0)
			_O_DISABLE BUTTON:C193(bDelLine)
		End if 
		
	: (ALProEvt=6)  //right click on empty area
		
		
		
End case 