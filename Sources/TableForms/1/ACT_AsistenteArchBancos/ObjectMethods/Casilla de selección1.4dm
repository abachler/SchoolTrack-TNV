If (Self:C308->=1)
	ARRAY LONGINT:C221(alACT_ABArchivoIDPAT;0)
	ARRAY TEXT:C222(atACT_ABArchivoNombrePAT;0)
	READ ONLY:C145([xxACT_ArchivosBancarios:118])
	QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ImpExp:5=False:C215;*)
	  //QUERY([xxACT_ArchivosBancarios]; & ;[xxACT_ArchivosBancarios]Tipo="PAT";*)
	QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]id_forma_de_pago:13=-9;*)
	QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]Rol_BD:8=<>gRolBD)
	Case of 
		: (Records in selection:C76([xxACT_ArchivosBancarios:118])=1)
			SELECTION TO ARRAY:C260([xxACT_ArchivosBancarios:118]ID:1;alACT_ABArchivoIDPAT;[xxACT_ArchivosBancarios:118]Nombre:3;atACT_ABArchivoNombrePAT)
			vExportadorPAT:=atACT_ABArchivoNombrePAT{1}
			vlACT_ExportadorPATID:=alACT_ABArchivoIDPAT{1}
			_O_ENABLE BUTTON:C192(bExportadoresPAT)
		: (Records in selection:C76([xxACT_ArchivosBancarios:118])>0)
			SELECTION TO ARRAY:C260([xxACT_ArchivosBancarios:118]ID:1;alACT_ABArchivoIDPAT;[xxACT_ArchivosBancarios:118]Nombre:3;atACT_ABArchivoNombrePAT)
			vExportadorPAT:=__ ("Seleccionar...")
			vlACT_ExportadorPATID:=0
			_O_ENABLE BUTTON:C192(bExportadoresPAT)
		Else 
			vExportadorPAT:="No hay exportadores definidos para PAT"
			vlACT_ExportadorPATID:=0
			_O_DISABLE BUTTON:C193(bExportadoresPAT)
	End case 
Else 
	vExportadorPAT:=__ ("Seleccionar...")
	vlACT_ExportadorPATID:=0
	_O_DISABLE BUTTON:C193(bExportadoresPAT)
End if 
$case1:=((cbPAT=1) & (vlACT_ExportadorPATID#0))
$case2:=((cbPAC=1) & (vlACT_ExportadorPACID#0))
$case3:=((cbCuponera=1) & (vlACT_ExportadorCUPID#0))
If (($case1) | ($case2) | ($case3))
	_O_ENABLE BUTTON:C192(bNext)
Else 
	_O_DISABLE BUTTON:C193(bNext)
End if 