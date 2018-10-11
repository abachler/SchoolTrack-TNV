C_BOOLEAN:C305(vb_cancelar_revision)

READ ONLY:C145([XShell_FatObjects:86])
QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="SN3_ActuaDatos_@")
QUERY SELECTION:C341([XShell_FatObjects:86];[XShell_FatObjects:86]TableNumber:5=7)

If (Records in selection:C76([XShell_FatObjects:86])>0)
	WDW_OpenFormWindow (->[SN3_PublicationPrefs:161];"ActuaDatos_RevisarCambios";0;4;__ ("Actualización de Datos"))
	DIALOG:C40([SN3_PublicationPrefs:161];"ActuaDatos_RevisarCambios")
	CLOSE WINDOW:C154
Else 
	CD_Dlog (0;__ ("No hay datos para revisar antes de actualizar, intente descargar datos desde Schoolnet con el botón Recibir ahora desde este mismo panel "))
End if 



