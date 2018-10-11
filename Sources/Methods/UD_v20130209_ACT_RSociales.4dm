//%attributes = {}
  //UD_v20130209_ACT_RSociales

If (ACT_AccountTrackInicializado )
	C_LONGINT:C283($i)
	C_BLOB:C604($xBlob)
	C_TEXT:C284($vt_nombrePref)
	
	ACTcfg_OpcionesRazonesSociales ("LeePreferencias")
	  //cargo principal
	ACTcfg_OpcionesRazonesSociales ("CreaPrincipal")
	
	READ WRITE:C146([ACT_RazonesSociales:279])
	  //cargo posibles secundarias
	ACTcfg_OpcionesRazonesSociales ("GetNamePref";->$vt_nombrePref)
	READ ONLY:C145([xShell_Prefs:46])
	QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
	QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1=$vt_nombrePref+"@")
	ORDER BY:C49([xShell_Prefs:46];[xShell_Prefs:46]_Longint:6;>)
	
	For ($i;1;Records in selection:C76([xShell_Prefs:46]))
		$xBlob:=BLOB_ExpandBlob ([xShell_Prefs:46]_blob:10)
		
		ACTcfg_OpcionesRazonesSociales ("LimpiaVars")
		BLOB_Blob2Vars (->$xBlob;0;-><>vsACT_Direccion;-><>vsACT_Comuna;-><>vsACT_Ciudad;-><>vsACT_CPostal;-><>vsACT_Telefono;-><>vsACT_Fax;-><>vsACT_Email;-><>vsACT_RepLegal;-><>vsACT_RUTRepLegal;-><>vsACT_RazonSocial;-><>vsACT_RUT;-><>vPict_Logo;-><>vsACT_Giro;-><>vsACT_NombreContacto;-><>vsACT_EMailContacto;-><>vsACT_TelefonoContacto)
		  //ACTcfg_OpcionesRazonesSociales ("DesarmaBlob";->$xBlob)
		
		QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]id:1=[xShell_Prefs:46]_Longint:6)
		If (Records in selection:C76([ACT_RazonesSociales:279])=0)
			CREATE RECORD:C68([ACT_RazonesSociales:279])
			
			[ACT_RazonesSociales:279]id:1:=[xShell_Prefs:46]_Longint:6
			[ACT_RazonesSociales:279]direccion:7:=<>vsACT_Direccion
			[ACT_RazonesSociales:279]comuna:8:=<>vsACT_Comuna
			[ACT_RazonesSociales:279]ciudad:10:=<>vsACT_Ciudad
			[ACT_RazonesSociales:279]codigo_postal:9:=<>vsACT_CPostal
			[ACT_RazonesSociales:279]telefono:11:=<>vsACT_Telefono
			[ACT_RazonesSociales:279]fax:12:=<>vsACT_Fax
			[ACT_RazonesSociales:279]eMail:13:=<>vsACT_Email
			[ACT_RazonesSociales:279]representante_legal:4:=<>vsACT_RepLegal
			[ACT_RazonesSociales:279]representante_legal_rut:5:=<>vsACT_RUTRepLegal
			[ACT_RazonesSociales:279]razon_social:2:=<>vsACT_RazonSocial
			[ACT_RazonesSociales:279]RUT:3:=<>vsACT_RUT
			[ACT_RazonesSociales:279]logo:17:=<>vPict_Logo
			[ACT_RazonesSociales:279]giro:18:=<>vsACT_Giro
			[ACT_RazonesSociales:279]contacto_nombre:14:=<>vsACT_NombreContacto
			[ACT_RazonesSociales:279]contacto_eMail:15:=<>vsACT_EMailContacto
			[ACT_RazonesSociales:279]contacto_telefono:16:=<>vsACT_TelefonoContacto
			SAVE RECORD:C53([ACT_RazonesSociales:279])
		End if 
		
		NEXT RECORD:C51([xShell_Prefs:46])
	End for 
	KRL_UnloadReadOnly (->[ACT_RazonesSociales:279])
	
	SQ_EscribeDatos 
	SQ_getLastID (->[ACT_RazonesSociales:279]id:1)
	SQ_CargaDatos 
End if 
