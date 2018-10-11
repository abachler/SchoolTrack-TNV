If (Self:C308->=1)
	ARRAY LONGINT:C221(alACT_ABArchivoIDCUP;0)
	ARRAY TEXT:C222(atACT_ABArchivoNombreCUP;0)
	READ ONLY:C145([xxACT_ArchivosBancarios:118])
	QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ImpExp:5=False:C215;*)
	QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]Tipo:6="Cuponera";*)
	QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]Rol_BD:8=<>gRolBD)
	Case of 
		: (Records in selection:C76([xxACT_ArchivosBancarios:118])=1)
			SELECTION TO ARRAY:C260([xxACT_ArchivosBancarios:118]ID:1;alACT_ABArchivoIDCUP;[xxACT_ArchivosBancarios:118]Nombre:3;atACT_ABArchivoNombreCUP)
			vExportadorCUP:=atACT_ABArchivoNombreCUP{1}
			vlACT_ExportadorCUPID:=alACT_ABArchivoIDCUP{1}
			_O_ENABLE BUTTON:C192(bExportadoresCUP)
		: (Records in selection:C76([xxACT_ArchivosBancarios:118])>0)
			SELECTION TO ARRAY:C260([xxACT_ArchivosBancarios:118]ID:1;alACT_ABArchivoIDCUP;[xxACT_ArchivosBancarios:118]Nombre:3;atACT_ABArchivoNombreCUP)
			vExportadorCUP:="Seleccionar..."
			vlACT_ExportadorCUPID:=0
			_O_ENABLE BUTTON:C192(bExportadoresCUP)
		Else 
			vExportadorCUP:="No hay exportadores definidos para "+"Cuponera"
			vlACT_ExportadorCUPID:=0
			_O_DISABLE BUTTON:C193(bExportadoresCUP)
	End case 
Else 
	vExportadorCUP:="Seleccionar..."
	vlACT_ExportadorCUPID:=0
	_O_DISABLE BUTTON:C193(bExportadoresCUP)
End if 
$case1:=((cbPAT=1) & (vlACT_ExportadorPATID#0))
$case2:=((cbPAC=1) & (vlACT_ExportadorPACID#0))
$case3:=((cbCuponera=1) & (vlACT_ExportadorCUPID#0))
If (($case1) | ($case2) | ($case3))
	_O_ENABLE BUTTON:C192(bNext)
Else 
	_O_DISABLE BUTTON:C193(bNext)
End if 