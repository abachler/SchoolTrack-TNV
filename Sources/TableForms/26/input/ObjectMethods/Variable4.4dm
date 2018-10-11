If (Records in table:C83([BU_Rutas_Recorridos:33])>0)
	READ ONLY:C145([BU_Rutas:26])
	QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2=[BU_Rutas:26]ID:12)
	ORDER BY:C49([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]Nombre:3;>)
	FORM SET OUTPUT:C54([BU_Rutas_Recorridos:33];"Lista Impresa")
	PRINT SELECTION:C60([BU_Rutas_Recorridos:33])
Else 
	CD_Dlog (0;__ ("No registro de recorridos para imprimir, seleccione otro recorrido."))
End if 