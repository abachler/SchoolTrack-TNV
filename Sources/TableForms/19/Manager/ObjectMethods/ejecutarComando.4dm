  // [xShell_ExecutableCommands].Manager_v14.ejecutarComando()
  // Por: Alberto Bachler K.: 01-07-15, 14:19:20
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_POINTER:C301($y_nombreComandos_at;$y_recNumComandos_ar)

$y_nombreComandos_at:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreComandos")
$y_recNumComandos_ar:=OBJECT Get pointer:C1124(Object named:K67:5;"recNumComandos")
vtEXC_Commands:=""

$l_recNum:=$y_recNumComandos_ar->{$y_recNumComandos_ar->}
GOTO RECORD:C242([xShell_ExecutableCommands:19];$l_recNum)
If (USR_IsGroupMember_by_GrpID (-15001))
	ACCEPT:C269
Else 
	If (USR_GetMethodAcces ([xShell_ExecutableCommands:19]MethodName:2))
		ACCEPT:C269
	End if 
End if 