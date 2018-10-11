  // [xShell_ExecutableCommands].Manager_v14.ejecutarCodigo()
  // Por: Alberto Bachler K.: 21-02-14, 12:40:16
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($y_codigo;$y_ejecutarEnServidor)

$y_ejecutarEnServidor:=OBJECT Get pointer:C1124(Object named:K67:5;"ejecutarEnServidor")
$y_codigo:=OBJECT Get pointer:C1124(Object named:K67:5;"codigo")
vtEXC_Commands:=$y_codigo->
bExecuteOnServer:=$y_ejecutarEnServidor->



