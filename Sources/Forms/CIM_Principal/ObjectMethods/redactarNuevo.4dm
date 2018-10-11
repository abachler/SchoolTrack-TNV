  // CIM_Principal.redactarNuevo()
  // Por: Alberto Bachler K.: 04-11-14, 07:32:45
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If ((<>tUSR_CurrentUserName#"") & (<>tUSR_CurrentUserEmail#""))
	vtTS_EventID:="NEW"
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"TS_EnviaIncidente";-1;8;__ ("Nuevo Ticket"))
	DIALOG:C40([xxSTR_Constants:1];"TS_EnviaIncidente")
	CLOSE WINDOW:C154
Else 
	CD_Dlog (0;__ ("Debe haber completado su nombre y dirección de correo personal en la página Configuración antes de registrar un ticket."))
End if 


