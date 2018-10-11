
If (Form event:C388=On After Keystroke:K2:26)
	C_TEXT:C284($t_usuarioAutorizado)
	
	$t_Contraseña:=Get edited text:C655
	
	  //If (Character code(Keystroke)=Backspace Key)
	  //If ($t_Contraseña#"")
	  //$t_Contraseña:=Substring($t_Contraseña;1;Length($t_Contraseña)-1)
	  //End if 
	  //End if 
	
	
	$b_SuperUser:=USR_IsSuperUser (vt_nombreUsuario;$t_Contraseña)
	
	
	If ($t_Contraseña#"")
		If (Not:C34($b_SuperUser))
			READ ONLY:C145([xShell_Users:47])
			QUERY:C277([xShell_Users:47];[xShell_Users:47]login:9=vt_nombreUsuario)
			If (Records in selection:C76([xShell_Users:47])=1)
				$storedPassword:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
				If (ST_ExactlyEqual ($storedPassword;$t_Contraseña)=1)
					$t_usuarioAutorizado:=[xShell_Users:47]login:9
					$l_userId:=[xShell_Users:47]No:1
				Else 
					$t_usuarioAutorizado:=""
				End if 
			End if 
		Else 
			$t_usuarioAutorizado:=<>tUSR_CurrentUser
			$l_userId:=<>lUSR_CurrentUserID
			<>tUSR_CurrentUser:=""
			<>lUSR_CurrentUserID:=0
		End if 
	End if 
	
	
	
	If (($t_usuarioAutorizado#"") & (USR_IsGroupMember_by_GrpID (-15001;$l_userId)))
		_O_ENABLE BUTTON:C192(bnuevoServer)
	Else 
		_O_DISABLE BUTTON:C193(bnuevoServer)
	End if 
End if 
