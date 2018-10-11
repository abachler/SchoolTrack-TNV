  // Método: Método de Formulario: [SN3_PublicationPrefs]UserAndPasswords
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/02/10, 18:47:17
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222(SN3_LoginType;0)
		APPEND TO ARRAY:C911(SN3_LoginType;__ ("Primer nombre (pedro)"))
		APPEND TO ARRAY:C911(SN3_LoginType;__ ("Primer nombre_Apellido paterno (pedro_malaga)"))
		APPEND TO ARRAY:C911(SN3_LoginType;__ ("Apellido Paterno (malaga)"))
		APPEND TO ARRAY:C911(SN3_LoginType;__ ("Nombres (pedro_alonso)"))
		APPEND TO ARRAY:C911(SN3_LoginType;__ ("Inicial primer nombre y apellido paterno (pmalaga)"))
		APPEND TO ARRAY:C911(SN3_LoginType;__ ("Identificador nacional principal (127214468)"))
		
		ARRAY TEXT:C222(SN3_PasswordType;0)
		APPEND TO ARRAY:C911(SN3_PasswordType;__ ("Apellido paterno y cuatro digitos al azar (malaga4852)"))
		APPEND TO ARRAY:C911(SN3_PasswordType;__ ("Primer nombre y cuatro digitos al azar (pedro4852)"))
		APPEND TO ARRAY:C911(SN3_PasswordType;__ ("Primer nombre_Apellido paterno y cuatro digitos al azar (pedro_malaga4852)"))
		APPEND TO ARRAY:C911(SN3_PasswordType;__ ("Iniciales y 8 digitos al azar (pam46535623)"))
		APPEND TO ARRAY:C911(SN3_PasswordType;__ ("Identificador nacional principal (127214468)"))
		APPEND TO ARRAY:C911(SN3_PasswordType;__ ("Ocho digitos al azar"))
		APPEND TO ARRAY:C911(SN3_PasswordType;__ ("Ocho carateres al azar"))
		APPEND TO ARRAY:C911(SN3_PasswordType;__ ("Cuatro digitos al azar"))
		
		ARRAY TEXT:C222(SN3_WhatUsers;0)
		APPEND TO ARRAY:C911(SN3_WhatUsers;__ ("Relaciones Familiares (Todas)"))
		APPEND TO ARRAY:C911(SN3_WhatUsers;__ ("Relaciones Familiares (Padres y Madres)"))
		APPEND TO ARRAY:C911(SN3_WhatUsers;__ ("Relaciones Familiares (Apoderados Académico y de Cuentas)"))
		APPEND TO ARRAY:C911(SN3_WhatUsers;__ ("Relaciones Familiares (Padres, Madres, Apoderados Académicos, Apoderados de Cuenta)"))
		APPEND TO ARRAY:C911(SN3_WhatUsers;__ ("Alumnos"))
		APPEND TO ARRAY:C911(SN3_WhatUsers;__ ("Todos"))
		
		SN3_LoadUsersSettings 
		
		OBJECT SET ENTERABLE:C238(SN3_Separador;(cb_UsarOtroChar=1))
		
		If (SN3_MailAddress="")
			SN3_MailAddress:=<>tUSR_CurrentUserEmail
		End if 
		
		SN3_LoginType:=SN3_LoginTypeSel
		SN3_PasswordType:=SN3_PasswordTypeSel
		SN3_WhatUsers:=SN3_WhatUsersSel
		
		$cond:=((SN3_MailAddress#"") & ((cb_FormatoXLS=1) | (cb_FormatoPDF=1)))
		
		IT_SetButtonState ($cond;->bSend)
		GET PICTURE FROM LIBRARY:C565("Config_Back_SchoolNet";vp_FondoConfig)
	: (Form event:C388=On Close Box:K2:21)
		SN3_LoginTypeSel:=SN3_LoginType
		SN3_PasswordTypeSel:=SN3_PasswordType
		SN3_WhatUsersSel:=SN3_WhatUsers
		SN3_SaveUsersConfig 
		CANCEL:C270
End case 