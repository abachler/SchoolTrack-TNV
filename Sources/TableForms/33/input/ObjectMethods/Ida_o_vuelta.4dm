If (Self:C308->)
	[BU_Rutas_Recorridos:33]Nombre:3:=[BU_Rutas:26]Nombre:9+" "+[BU_Rutas_Recorridos:33]Dia_Semana:6+" "+"Llegada"
Else 
	[BU_Rutas_Recorridos:33]Nombre:3:=[BU_Rutas:26]Nombre:9+" "+[BU_Rutas_Recorridos:33]Dia_Semana:6+" "+"Salida"
End if 
SET WINDOW TITLE:C213([BU_Rutas_Recorridos:33]Nombre:3)