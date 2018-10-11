$text:=AT_array2text (-><>atSTR_BUJornada)
$choice:=Pop up menu:C542($text)

If ($choice>0)
	[BU_Rutas_Recorridos:33]Jornada:4:=<>atSTR_BUJornada{$choice}
End if 