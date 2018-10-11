//%attributes = {}
  //SN3_ActuaDatos_OpenREV
If (<>bXS_esServidorOficial)  //MONO 203046
	SN3_LoadDataReceptionSettings 
	
	READ ONLY:C145([XShell_FatObjects:86])
	QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="SN3_ActuaDatos_@")
	QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]TableNumber:5=7)
	
	If (Records in selection:C76([XShell_FatObjects:86])>0)
		WDW_OpenFormWindow (->[SN3_PublicationPrefs:161];"ActuaDatos_RevisarCambios";0;4;__ ("Actualización de Datos"))
		DIALOG:C40([SN3_PublicationPrefs:161];"ActuaDatos_RevisarCambios")
		CLOSE WINDOW:C154
	Else 
		CD_Dlog (0;__ ("No hay datos para revisar antes de actualizar, intente descargar datos desde Schoolnet con la opción ''Descargar Datos'' de este mismo menú"))
	End if 
Else 
	CD_Dlog (0;__ ("Debe estar conectado al servidor oficial para continuar..."))
End if 