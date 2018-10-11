If (Self:C308->)
	[BU_Rutas:26]Nombre:9:=[BU_Rutas:26]Letra:8+String:C10([BU_Rutas:26]Numero_Ruta:1)+" Especial"
Else 
	[BU_Rutas:26]Nombre:9:=[BU_Rutas:26]Letra:8+String:C10([BU_Rutas:26]Numero_Ruta:1)
End if 
SET WINDOW TITLE:C213([BU_Rutas:26]Nombre:9)