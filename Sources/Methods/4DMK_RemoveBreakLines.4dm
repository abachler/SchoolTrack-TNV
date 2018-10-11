//%attributes = {}
  // 4DMK_RemoveBreakLines()
  //
  //
  // creado por: Alberto Bachler Klein: 18-01-17, 11:38:53
  // -----------------------------------------------------------
C_TEXT:C284($t_metodo)


GET MACRO PARAMETER:C997(Highlighted method text:K5:18;$t_metodo)
If (Length:C16($t_metodo)=0)
	GET MACRO PARAMETER:C997(Full method text:K5:17;$t_metodo)
	$t_metodo:=Replace string:C233($t_metodo;"\\\r";"")
	SET MACRO PARAMETER:C998(Full method text:K5:17;$t_metodo)
Else 
	$t_metodo:=Replace string:C233($t_metodo;"\\\r";"")
	SET MACRO PARAMETER:C998(Highlighted method text:K5:18;$t_metodo)
End if 





