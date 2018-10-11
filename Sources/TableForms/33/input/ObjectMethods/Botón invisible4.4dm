$text:=AT_array2text (-><>atSTR_BUDia)
If (Is new record:C668([BU_Rutas_Recorridos:33]))
	$text:=$text+";(-;Lunes a Viernes;Lunes a Sábado;Toda la Semana"
End if 
$choice:=Pop up menu:C542($text)
vTT_CrearRecSemana:=0
If ($choice>0)
	If ($choice>8)
		[BU_Rutas_Recorridos:33]Dia_Semana:6:=<>atSTR_BUDia{1}
		[BU_Rutas_Recorridos:33]Dia_Semana_Num:12:=1
		If ([BU_Rutas_Recorridos:33]Ida_o_vuelta:7=False:C215)
			[BU_Rutas_Recorridos:33]Nombre:3:=[BU_Rutas:26]Nombre:9+" "+<>atSTR_BUDia{1}+" "+"Salida"
		Else 
			[BU_Rutas_Recorridos:33]Nombre:3:=[BU_Rutas:26]Nombre:9+" "+<>atSTR_BUDia{1}+" "+"Entrada"
		End if 
		vTT_CrearRecSemana:=$choice
	Else 
		[BU_Rutas_Recorridos:33]Dia_Semana:6:=<>atSTR_BUDia{$choice}
		[BU_Rutas_Recorridos:33]Dia_Semana_Num:12:=$choice
		If ([BU_Rutas_Recorridos:33]Ida_o_vuelta:7=False:C215)
			[BU_Rutas_Recorridos:33]Nombre:3:=[BU_Rutas:26]Nombre:9+" "+<>atSTR_BUDia{$choice}+" "+"Salida"
		Else 
			[BU_Rutas_Recorridos:33]Nombre:3:=[BU_Rutas:26]Nombre:9+" "+<>atSTR_BUDia{$choice}+" "+"Entrada"
		End if 
	End if 
	SET WINDOW TITLE:C213([BU_Rutas_Recorridos:33]Nombre:3)
	vt_DiasSemana:=ST_GetWord ($text;$choice;";")
End if 