C_LONGINT:C283($id;$lErr)
C_TEXT:C284($t_dts;$t_versionEstructura;$tText;$tTip)

Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET FONT:C164(vs_Password;"%password")
		$t_versionEstructura:=SYS_LeeVersionEstructura ("dts";->$t_dts)
		$t_versionEstructura:=$t_versionEstructura  //+"\r"+DTS_GetDateTimeString ($t_dts;System date long;HH MM)+" (GMT)"
		sAppVers:=$t_versionEstructura
		
		OBJECT SET VISIBLE:C603(*;"CapsLockIcon";Caps lock down:C547)
		vs_Name:=""
		vs_Password:=""
		vlBWR_CurrentModuleRef:=0
		
		
		vlXS_LastModule:=0
		
		vLanguageMenu:=Create menu:C408
		APPEND MENU ITEM:C411(vLanguageMenu;"Español")
		APPEND MENU ITEM:C411(vLanguageMenu;"English")
		APPEND MENU ITEM:C411(vLanguageMenu;"Portugues")
		SET MENU ITEM ICON:C984(vLanguageMenu;1;31934)
		SET MENU ITEM ICON:C984(vLanguageMenu;2;31935)
		SET MENU ITEM ICON:C984(vLanguageMenu;3;31936)
		SET MENU ITEM PARAMETER:C1004(vLanguageMenu;1;"es")
		SET MENU ITEM PARAMETER:C1004(vLanguageMenu;2;"en")
		SET MENU ITEM PARAMETER:C1004(vLanguageMenu;3;"pt")
		  //GET PICTURE FROM LIBRARY(17000;vBandera)
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
				
			Else 
				GET PICTURE FROM LIBRARY:C565(31934;vBandera)
				
		End case 
		  //DISABLE BUTTON(bBandera)
		vpXS_IconModule:=vpXS_IconModule1
		
		$modules:=Count list items:C380(hl_modules)
		Case of 
			: ($modules=1)
				vlBWR_CurrentModuleRef:=1
				GET WINDOW RECT:C443($left;$top;$right;$bottom)
				SET WINDOW RECT:C444($left;$top;$right;$top+241)
				For ($i;$Modules+1;8)
					  // ASM 20180307 - El cliclo hace referencia al nombre de la variable y no al nombre del objeto.
					  // Cambio para pasar el nombre de la variable
					$y_pointerName:=Get pointer:C304("vsXS_ModuleName"+String:C10($i))
					$y_pointerIcon:=Get pointer:C304("vpXS_IconModule"+String:C10($i))
					OBJECT SET VISIBLE:C603($y_pointerName->;False:C215)
					OBJECT SET VISIBLE:C603($y_pointerIcon->;False:C215)
					OBJECT SET VISIBLE:C603(*;"marcomodulo"+String:C10($i);False:C215)
				End for 
				OBJECT MOVE:C664(*;"barra";0;-81)
				OBJECT MOVE:C664(*;"fondo";0;0;0;-81)
				GET WINDOW RECT:C443($left;$top;$right;$bottom)
				SET WINDOW RECT:C444($left;$top;$right;$bottom-81)
			Else 
				For ($i;$Modules+1;8)
					  // ASM 20180307 - El cliclo hace referencia al nombre de la variable y no al nombre del objeto.
					  // Cambio para pasar el nombre de la variable
					$y_pointerName:=Get pointer:C304("vsXS_ModuleName"+String:C10($i))
					$y_pointerIcon:=Get pointer:C304("vpXS_IconModule"+String:C10($i))
					OBJECT SET VISIBLE:C603($y_pointerName->;False:C215)
					OBJECT SET VISIBLE:C603($y_pointerIcon->;False:C215)
					OBJECT SET VISIBLE:C603(*;"marcomodulo"+String:C10($i);False:C215)
				End for 
				If ($modules<5)
					If (Application type:C494=4D Remote mode:K5:5)
						OBJECT MOVE:C664(*;"barra";0;-81)
						OBJECT MOVE:C664(*;"accesoSTWA@";0;-79)
						OBJECT MOVE:C664(*;"redes-@";0;-73)  // ASM 20180307 - Agrego iconos de redes sociales
						GET WINDOW RECT:C443($left;$top;$right;$bottom)
						SET WINDOW RECT:C444($left;$top;$right;$bottom-81)
					Else 
						OBJECT MOVE:C664(*;"barra";0;-129)
						OBJECT MOVE:C664(*;"redes-@";0;-127)  // ASM 20180307 - Agrego iconos de redes sociales
						OBJECT SET VISIBLE:C603(*;"accesoSTWA@";False:C215)
						GET WINDOW RECT:C443($left;$top;$right;$bottom)
						SET WINDOW RECT:C444($left;$top;$right;$bottom-129)
					End if 
				End if 
		End case 
		SET TIMER:C645(20)
		
		C_BOOLEAN:C305(vb_ReloadLogin)
		If (vb_ReloadLogin)
			vb_ReloadLogin:=False:C215
		End if 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		ARRAY TEXT:C222(aModule;0)
		If (SYS_IsWindows )
			$err:=gui_ToolTipHide (1)
			$lErr:=gui_ToolTipDestroyControl 
		End if 
	: (Form event:C388=On Timer:K2:25)
		OBJECT SET VISIBLE:C603(*;"CapsLockIcon";Caps lock down:C547)
		If (SYS_IsWindows )
			If (Caps lock down:C547)
				$lErr:=gui_ToolTipCreate (TT_BALLOON)  //balloon
				GET WINDOW RECT:C443($left;$top;$right;$bottom)
				OBJECT GET COORDINATES:C663(*;"CapsLockIcon";$TT_Left;$TT_Top;$TT_Right;$TT_Bottom)
				$xCoord:=$left+$TT_Right+10
				$yCoord:=$top+$TT_Bottom+20
				$lErr:=gui_ToolTipShowOnCoord (1;__ ("La tecla Todo Mayúsculas está activada lo que puede provocar que su contraseña no sea reconocida.");$xCoord;$yCoord;TT_CLOSE_ON_CLICK;__ ("Todo Mayúsculas");"";150)
			Else 
				$err:=gui_ToolTipHide (1)
				$lErr:=gui_ToolTipDestroyControl 
			End if 
		End if 
End case 






