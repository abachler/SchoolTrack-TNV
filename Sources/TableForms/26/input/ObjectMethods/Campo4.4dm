If (Self:C308->>"")
	If ([BU_Rutas:26]Especial:14=False:C215)
		[BU_Rutas:26]Nombre:9:=Self:C308->+String:C10([BU_Rutas:26]Numero_Ruta:1)
	Else 
		[BU_Rutas:26]Nombre:9:=Self:C308->+String:C10([BU_Rutas:26]Numero_Ruta:1)+" Especial"
	End if 
	_O_ENABLE BUTTON:C192(Botón1)
	_O_ENABLE BUTTON:C192(b_Eliminar)
	SET WINDOW TITLE:C213([BU_Rutas:26]Nombre:9)
End if 