//%attributes = {"executedOnServer":true}
  // SYS_GetDataPath()
  // Por: Alberto Bachler K.: 16-04-15, 19:52:41
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)

C_TEXT:C284($t_nombreServidor;$t_rutaBD)


If (False:C215)
	C_TEXT:C284(SYS_GetDataPath ;$0)
End if 

If (Application type:C494=4D Server:K5:6)
	$t_nombreServidor:=Current machine:C483
	If ($t_nombreServidor#"")
		<>vt_DataPath:=$t_nombreServidor+"//"+Data file:C490
	Else 
		<>vt_DataPath:="<nombre desconocido>//"+Data file:C490
	End if 
	$t_rutaBD:=<>vt_DataPath
Else 
	<>vt_DataPath:=Data file:C490
End if 
$0:=<>vt_DataPath

