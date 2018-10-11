  // [xShell_ExecutableCommands].Manager_v14.lb_Comandos()
  // Por: Alberto Bachler K.: 28-07-15, 11:35:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($y_ListaComandos_LB;$y_nombreComandos_at;$y_recNumComandos_al)

$y_ListaComandos_LB:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_Comandos")
$y_nombreComandos_at:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreComandos")
$y_recNumComandos_al:=OBJECT Get pointer:C1124(Object named:K67:5;"recNumComandos")


OBJECT SET ENABLED:C1123(*;"ejecutarComando";(Find in array:C230($y_ListaComandos_LB->;True:C214)>-1))
If (Form event:C388=On Double Clicked:K2:5)
	GOTO RECORD:C242([xShell_ExecutableCommands:19];$y_recNumComandos_al->{$y_recNumComandos_al->})
	If (USR_IsGroupMember_by_GrpID (-15001))
		bExecute:=1
		ACCEPT:C269
	Else 
		If (USR_GetMethodAcces ([xShell_ExecutableCommands:19]MethodName:2))
			bExecute:=1
			ACCEPT:C269
		End if 
	End if 
End if 