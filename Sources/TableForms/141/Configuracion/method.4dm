C_LONGINT:C283(hl_Countries;hl_Tablas;hl_Campos;hlMeta_TipoCampo)
Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET RGB COLORS:C628(*;"Rectangulo2";0x0000;0x00F3F6FA)
		HL_ClearList (hl_Countries;hl_Tablas;hl_Campos;hlMeta_TipoCampo)
		MNU_SetMenuBar ("XS_Edicion")
		hl_Countries:=Load list:C383("XS_CountryCodes")
		hl_Tablas:=New list:C375
		APPEND TO LIST:C376(hl_Tablas;"Colegio";Table:C252(->[Colegio:31]))
		APPEND TO LIST:C376(hl_Tablas;"Alumnos";Table:C252(->[Alumnos:2]))
		APPEND TO LIST:C376(hl_Tablas;"Personas";Table:C252(->[Personas:7]))
		APPEND TO LIST:C376(hl_Tablas;"Profesores";Table:C252(->[Profesores:4]))
		APPEND TO LIST:C376(hl_Tablas;"Niveles";Table:C252(->[xxSTR_Niveles:6]))
		APPEND TO LIST:C376(hl_Tablas;"Cursos";Table:C252(->[Cursos:3]))
		
		hlMeta_TipoCampo:=New list:C375
		APPEND TO LIST:C376(hlMeta_TipoCampo;"Alfanumérico";24)
		APPEND TO LIST:C376(hlMeta_TipoCampo;"Real";1)
		APPEND TO LIST:C376(hlMeta_TipoCampo;"Entero";9)
		APPEND TO LIST:C376(hlMeta_TipoCampo;"Fecha";4)
		APPEND TO LIST:C376(hlMeta_TipoCampo;"Booleano";6)
		
		SELECT LIST ITEMS BY POSITION:C381(hl_Countries;1)
		SELECT LIST ITEMS BY POSITION:C381(hl_Tablas;1)
		
		MDATA_ObjectHandler 
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		Case of 
			: ([xxSTR_MetadatosLocales:141]Tipo:5=Is string var:K8:2)
				If (([xxSTR_MetadatosLocales:141]Largo:6=0) | ([xxSTR_MetadatosLocales:141]Largo:6>80))
					[xxSTR_MetadatosLocales:141]Largo:6:=80
				End if 
				[xxSTR_MetadatosLocales:141]ValorMaximo:9:=0
				[xxSTR_MetadatosLocales:141]ValorMinimo:8:=0
				OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMaximo:9;False:C215)
				OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMinimo:8;False:C215)
				OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ListaDeValores:7;True:C214)
				
			: ([xxSTR_MetadatosLocales:141]Tipo:5=Is date:K8:7)
				[xxSTR_MetadatosLocales:141]Largo:6:=0
				[xxSTR_MetadatosLocales:141]ValorMaximo:9:=0
				[xxSTR_MetadatosLocales:141]ValorMinimo:8:=0
				OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMaximo:9;False:C215)
				OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMinimo:8;False:C215)
				OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]Largo:6;False:C215)
				OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ListaDeValores:7;False:C215)
				
			: (([xxSTR_MetadatosLocales:141]Tipo:5=Is real:K8:4) | ([xxSTR_MetadatosLocales:141]Tipo:5=Is longint:K8:6))
				[xxSTR_MetadatosLocales:141]Largo:6:=0
				OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMaximo:9;True:C214)
				OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMinimo:8;True:C214)
				OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]Largo:6;False:C215)
				OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ListaDeValores:7;False:C215)
				
			: ([xxSTR_MetadatosLocales:141]Tipo:5=Is boolean:K8:9)
				[xxSTR_MetadatosLocales:141]Largo:6:=0
				[xxSTR_MetadatosLocales:141]ValorMaximo:9:=0
				[xxSTR_MetadatosLocales:141]ValorMinimo:8:=0
				OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMaximo:9;False:C215)
				OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]ValorMinimo:8;False:C215)
				OBJECT SET ENTERABLE:C238([xxSTR_MetadatosLocales:141]Largo:6;False:C215)
				
		End case 
		
		If (Records in selection:C76([xxSTR_MetadatosLocales:141])=1)
			OBJECT SET VISIBLE:C603(*;"delete@";True:C214)
			OBJECT SET COLOR:C271(*;"texto@";-15)
		Else 
			OBJECT SET VISIBLE:C603(*;"delete@";False:C215)
			OBJECT SET COLOR:C271(*;"texto@";-14)
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		HL_ClearList (hl_Countries;hl_Tablas;hl_Campos;hlMeta_TipoCampo)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 




