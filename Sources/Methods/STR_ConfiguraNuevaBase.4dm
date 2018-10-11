//%attributes = {}
  //STR_ConfiguraNuevaBase

  //MODIFICADO PARA SCHOOLTRACK X
  //NO REEMPLAZAR CON CODIGO DE VERSIONES ANTERIORES



If (Records in table:C83([xxSTR_Constants:1])=0)
	READ WRITE:C146([xxSTR_Constants:1])
	CREATE RECORD:C68([xxSTR_Constants:1])
	[xxSTR_Constants:1]Año:8:=Year of:C25(Current date:C33(*))
	
	SAVE RECORD:C53([xxSTR_Constants:1])
	UNLOAD RECORD:C212([xxSTR_Constants:1])
	READ ONLY:C145([xxSTR_Constants:1])
	
	ALL RECORDS:C47([Colegio:31])
	If (Records in selection:C76([Colegio:31])=0)
		READ WRITE:C146([Colegio:31])
		CREATE RECORD:C68([Colegio:31])
		SAVE RECORD:C53([Colegio:31])
		READ ONLY:C145([Colegio:31])
	End if 
	SYS_OpenLangageResource 
	LICENCIA_ListaMacAddress 
	CFG_LoadDevelopperConfig 
	
	
	QRY_LoadLibrary 
	IN_FirstUseWizard 
	
	WS_InitWebServicesVariables 
	XS_ReadCustomerData 
	  //MONO actualmente el tercer parámetro de irá RIN_DescargaLibreria vació ya que todavía no hay repositorio por colegio.
	  //además de ser un llamado para crear una librería desde 0 para un colegio nuevo.
	  //$t_uuidInstitucion:=LICENCIA_ObtieneUUIDinstitucion 
	RIN_DescargaLibreria (<>vtXS_CountryCode;<>vtXS_langage;"")
	SQ_CargaDatos 
	FLUSH CACHE:C297
	PREF_Set (0;"Log days";"90")
	
	SYS_EstableceVersionBaseDeDatos 
End if 

