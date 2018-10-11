If (Self:C308->=1)
	If (SMTP_VerifyEmailAddress (<>vsACT_EMailContacto;False:C215)="")
		CD_Dlog (0;__ ("Ingrese una casilla de correo en el campo eMail, de la sección ")+ST_Qte (__ ("Contacto en el Colegio"))+__ (" de la página Datos Institución. A esta casilla se notificará si existen problemas encontrados."))
	Else 
		CD_Dlog (0;__ ("Se notificarán los problemas encontrados a la casilla de correo configurada en la sección ")+ST_Qte (__ ("Contacto en el Colegio"))+__ (" de la página Datos Institución (casilla configurada: ")+ST_Qte (<>vsACT_EMailContacto)+__ (")."))
	End if 
End if 