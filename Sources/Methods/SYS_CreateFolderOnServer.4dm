//%attributes = {"executedOnServer":true}
  //SYS_CreateFolderOnServer
  //20111020 RCH. Ejecuta SYS_CreateFolder en el server
C_TEXT:C284($1)
  //SYS_CreateFolder ($1)
  //20131014 ASM Se generaba problema al tener el server en win y el cliente en Mac
If (SYS_IsWindows )
	$t_RutaWin:=Substring:C12($1;3;Length:C16($1))
	$t_RaizWin:=Substring:C12($1;1;2)
	$t_RutaWin:=Replace string:C233($t_RutaWin;":";"\\")
	$t_Ruta:=$t_RaizWin+$t_RutaWin
Else 
	$t_Ruta:=Replace string:C233($1;"\\";":")
End if 
SYS_CreateFolder ($t_Ruta)