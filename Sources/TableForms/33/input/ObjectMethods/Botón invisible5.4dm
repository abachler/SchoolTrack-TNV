$text:=AT_array2text (-><>atSTR_BUHoras)
$choice:=Pop up menu:C542($text)

If ($choice>0)
	[BU_Rutas_Recorridos:33]Hora:5:=Time:C179(<>atSTR_BUHoras{$choice})
End if 