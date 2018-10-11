C_BOOLEAN:C305(vb_CreacionBD)

Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		$y_imagenFondo:=OBJECT Get pointer:C1124(Object named:K67:5;"imagenFondo")
		GET PICTURE FROM LIBRARY:C565("Config_Back_SchoolTrack";$y_imagenFondo->)
		
		LICENCIA_ListaMacAddress 
		OBJECT SET FONT:C164(*;"claveUsuario@";"%Password")
		If (([Colegio:31]Pais:21="") | ([Colegio:31]Codigo_Pais:31=""))
			[Colegio:31]Pais:21:="Chile"
			[Colegio:31]Codigo_Pais:31:="cl"
			<>gtOrganisation_Country:="Chile"
			<>vtXS_CountryCode:=[Colegio:31]Codigo_Pais:31
			<>gCountryCode:=[Colegio:31]Codigo_Pais:31
		End if 
		$element:=HL_FindElement (hl_Pais;[Colegio:31]Codigo_Pais:31+":@")
		SELECT LIST ITEMS BY POSITION:C381(hl_Pais;$element)
		READ ONLY:C145([xShell_Users:47])
		QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=1)
		(OBJECT Get pointer:C1124(Object named:K67:5;"nombreUsuario"))->:=[xShell_Users:47]login:9
		
		
		Case of 
			: (<>vtXS_CountryCode="cl")
				OBJECT SET TITLE:C194(*;"colegio_IdColegio";"Rol Base de Datos:")
				OBJECT SET TITLE:C194(*;"colegio_IdInstitucion@";"RUT:")
				OBJECT SET FORMAT:C236([Colegio:31]RUT:2;"###.###.###-#")
				OBJECT SET FILTER:C235([Colegio:31]RUT:2;"~"+Char:C90(Double quote:K15:41)+"k;K;0-9;.;-"+Char:C90(Double quote:K15:41))
			Else 
				Case of 
					: (<>vtXS_CountryCode="mx")
						OBJECT SET TITLE:C194(*;"colegio_IdInstitucion";"ID Institución:")
						OBJECT SET TITLE:C194(*;"colegio_IdColegio";"Clave Centro de Trabajo:")
					: (<>vtXS_CountryCode="ar")
						OBJECT SET TITLE:C194(*;"colegio_IdInstitucion";"ID Institución:")
						OBJECT SET TITLE:C194(*;"colegio_IdColegio";"CUE:")
					Else 
						OBJECT SET TITLE:C194(*;"colegio_IdInstitucion";"ID Institución:")
						OBJECT SET TITLE:C194(*;"colegio_IdColegio";"ID Escuela:")
				End case 
				OBJECT SET FORMAT:C236([Colegio:31]RUT:2;"")
				OBJECT SET FILTER:C235([Colegio:31]RUT:2;"")
		End case 
		IT_PropiedadesBotonPopup ("macaddress";<>vtXS_MacAddress;300)
		If (Not:C34(vb_CreacionBD))
			OBJECT SET TITLE:C194(*;"siguiente";__ ("Siguiente"))
			OBJECT SET TITLE:C194(*;"titulo";__ ("Obtencion del registro de licencia"))
		Else 
			OBJECT SET TITLE:C194(*;"titulo";__ ("Creacion y registro de la base de datos"))
		End if 
		
	: (Form event:C388=On Data Change:K2:15)
		
		
	: (Form event:C388=On After Keystroke:K2:26)
		Case of 
			: (FORM Get current page:C276=1)
				(OBJECT Get pointer:C1124(Object with focus:K67:3))->:=Get edited text:C655
				OBJECT SET ENABLED:C1123(*;"siguiente";([Colegio:31]Nombre_Colegio:1#"") & ([Colegio:31]Rol Base Datos:9#"") & ([Colegio:31]Codigo_Pais:31#""))
				
			: (FORM Get current page:C276=2)
				(OBJECT Get pointer:C1124(Object with focus:K67:3))->:=Get edited text:C655
				$t_nombreUsuario:=(OBJECT Get pointer:C1124(Object named:K67:5;"nombreUsuario"))->
				$t_contraseña1:=(OBJECT Get pointer:C1124(Object named:K67:5;"claveUsuario_1"))->
				$t_contraseña2:=(OBJECT Get pointer:C1124(Object named:K67:5;"claveUsuario_2"))->
				OBJECT SET ENABLED:C1123(*;"siguiente";($t_nombreUsuario#"") & ($t_contraseña1#"") & ($t_contraseña2#"") & ($t_contraseña1=$t_contraseña2))
		End case 
		
	: (Form event:C388=On Page Change:K2:54)
		OBJECT SET TITLE:C194(*;"siguiente";__ ("Siguiente"))
		OBJECT SET TITLE:C194(*;"anterior";__ ("Anterior"))
		OBJECT SET ENABLED:C1123(*;"anterior";True:C214)
		OBJECT SET TITLE:C194(*;"paso";String:C10(FORM Get current page:C276))
		
		Case of 
			: (FORM Get current page:C276=1)
				OBJECT SET ENABLED:C1123(*;"anterior";False:C215)
				OBJECT SET ENABLED:C1123(*;"siguiente";([Colegio:31]Nombre_Colegio:1#"") & ([Colegio:31]Rol Base Datos:9#"") & ([Colegio:31]Codigo_Pais:31#""))
				
				
			: (FORM Get current page:C276=2)
				$t_nombreUsuario:=(OBJECT Get pointer:C1124(Object named:K67:5;"nombreUsuario"))->
				$t_contraseña1:=(OBJECT Get pointer:C1124(Object named:K67:5;"claveUsuario_1"))->
				$t_contraseña2:=(OBJECT Get pointer:C1124(Object named:K67:5;"claveUsuario_2"))->
				OBJECT SET ENABLED:C1123(*;"siguiente";($t_nombreUsuario#"") & ($t_contraseña1#"") & ($t_contraseña2#"") & ($t_contraseña1=$t_contraseña2))
				
			: (FORM Get current page:C276=3)
				If (Not:C34(vb_CreacionBD))
					OBJECT SET TITLE:C194(*;"paso";"2")
				End if 
				OBJECT SET ENABLED:C1123(*;"siguiente";([Colegio:31]Nombre_Colegio:1#"") & ([Colegio:31]Rol Base Datos:9#"") & ([Colegio:31]Codigo_Pais:31#""))
				OBJECT SET TITLE:C194(*;"siguiente";__ ("Registrar"))
				
			: (FORM Get current page:C276=4)
				If (Not:C34(vb_CreacionBD))
					OBJECT SET TITLE:C194(*;"paso";"3")
				End if 
				OBJECT SET TITLE:C194(*;"siguiente";__ ("Continuar"))
				
		End case 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		If (LICENCIA_Verifica <0)
			QUIT 4D:C291
		End if 
		
End case 
