If (Self:C308->>0)
	If ([BU_Rutas:26]Especial:14=False:C215)
		[BU_Rutas:26]Nombre:9:=[BU_Rutas:26]Letra:8+String:C10(Self:C308->)
	Else 
		[BU_Rutas:26]Nombre:9:=[BU_Rutas:26]Letra:8+String:C10(Self:C308->)+" Especial"
	End if 
	SET WINDOW TITLE:C213([BU_Rutas:26]Nombre:9)
End if 