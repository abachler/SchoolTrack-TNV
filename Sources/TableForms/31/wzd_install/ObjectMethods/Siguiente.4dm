  // [Colegio].wzd_install.Siguiente()
  // Por: Alberto Bachler K.: 13-10-14, 17:01:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_recNum;$l_resultado)
C_POINTER:C301($y_modulosAutorizado;$y_modulosId;$y_modulosNombre)
C_TEXT:C284($t_claveUsuario1;$t_claveUsuario2;$t_mensajeError;$t_nombreUsuario)
C_BOOLEAN:C305($b_cargarUUID)

ARRAY LONGINT:C221($al_idUsuarios;0)

Case of 
	: (FORM Get current page:C276=1)
		OBJECT SET ENABLED:C1123(*;"siguiente";([Colegio:31]Nombre_Colegio:1#"") & ([Colegio:31]Rol Base Datos:9#"") & ([Colegio:31]Codigo_Pais:31#""))
		<>vtXS_CountryCode:=[Colegio:31]Codigo_Pais:31
		<>gCountryCode:=[Colegio:31]Codigo_Pais:31
		<>gRut:=[Colegio:31]RUT:2
		If (([Colegio:31]Rol Base Datos:9#"") & ([Colegio:31]Codigo_Pais:31#""))
			If ([Colegio:31]Codigo_Pais:31="cl")
				[Colegio:31]Moneda:49:="Peso Chileno;$"
			Else 
				[Colegio:31]Moneda:49:=ACT_DivisaPais 
			End if 
			ACTutl_GetDecimalFormat 
			[Colegio:31]Numero_Decimales:53:=<>vlACT_Decimales
			
			If ([Colegio:31]Rol Base Datos:9#Old:C35([Colegio:31]Rol Base Datos:9))  //20171003 RCH Cuando cambian el RBD desde acá... ya se hacía al cambiarlo desde la configuración generales de ST
				$b_cargarUUID:=True:C214
			End if 
			
			SAVE RECORD:C53([Colegio:31])
			
			$l_recNum:=Record number:C243([Colegio:31])
			If ($b_cargarUUID)  //20171003 RCH Cuando cambian el RBD desde acá... ya se hacía al cambiarlo desde la configuración generales de ST
				LICENCIA_ObtieneUUIDinstitucion (True:C214)
			End if 
			KRL_ReloadAsReadOnly (->[Colegio:31])
			KRL_GotoRecord (->[Colegio:31];$l_recNum)
			
			LICENCIA_RegistroAplicacion 
			KRL_GotoRecord (->[Colegio:31];$l_recNum;True:C214)
			If (Not:C34(Util_isValidUUID ([Colegio:31]UUID:58)))
				[Colegio:31]Rol Base Datos:9:=""
				ModernUI_Notificacion (__ ("Registro del establecimiento");__ ("El identificador del establecimiento no está registrado en Colegium"))
				GOTO OBJECT:C206([Colegio:31]Rol Base Datos:9)
			Else 
				If (vb_creacionBD=True:C214)
					FORM NEXT PAGE:C248
				Else 
					FORM GOTO PAGE:C247(3)
				End if 
			End if 
		End if 
		
		
	: (FORM Get current page:C276=2)
		$t_nombreUsuario:=(OBJECT Get pointer:C1124(Object named:K67:5;"nombreUsuario"))->
		$t_claveUsuario1:=(OBJECT Get pointer:C1124(Object named:K67:5;"claveUsuario_1"))->
		$t_claveUsuario2:=(OBJECT Get pointer:C1124(Object named:K67:5;"claveUsuario_2"))->
		READ WRITE:C146([xShell_Users:47])
		QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=1)
		[xShell_Users:47]Name:2:=$t_nombreUsuario
		[xShell_Users:47]login:9:=$t_nombreUsuario
		[xShell_Users:47]xPass:13:=USR_EncryptPassWord ($t_claveUsuario1)
		[xShell_Users:47]PasswordVersion:10:=3
		SAVE RECORD:C53([xShell_Users:47])
		KRL_ReloadAsReadOnly (->[xShell_Users:47])
		APPEND TO ARRAY:C911($al_idUsuarios;[xShell_Users:47]No:1)
		USR_AddUserMembership ([xShell_Users:47]No:1;-15001)
		USR_AddUserMembership ([xShell_Users:47]No:1;-15002)
		USR_SetGroupMemberList (-15001;->$al_idUsuarios)
		USR_SetGroupMemberList (-15002;->$al_idUsuarios)
		USR_GetGroupMemberList (-15001)
		
		FORM NEXT PAGE:C248
		
	: (FORM Get current page:C276=3)
		SAVE RECORD:C53([xShell_ApplicationData:45])
		$t_mensajeError:=LICENCIA_Descarga 
		If ($t_mensajeError#"")
			ModernUI_Notificacion (__ ("Registro de licencia");$t_mensajeError)
		Else 
			$l_resultado:=LICENCIA_Verifica (True:C214)
			If ($l_resultado=1)
				$y_modulosNombre:=OBJECT Get pointer:C1124(Object named:K67:5;"moduloNombre")
				$y_modulosAutorizado:=OBJECT Get pointer:C1124(Object named:K67:5;"moduloAutorizado")
				$y_modulosId:=OBJECT Get pointer:C1124(Object named:K67:5;"moduloId")
				
				  //20150226 RCH
				  //LICENCIA_InfoModulosAutorizados ($y_modulosNombre;$y_modulosAutorizado;$y_modulosId)
				LICENCIA_InfoModulosAutorizados ($y_modulosNombre;$y_modulosId;$y_modulosAutorizado)
				
				FORM GOTO PAGE:C247(4)
			End if 
		End if 
		
	: (FORM Get current page:C276=4)
		ACCEPT:C269
		
End case 

