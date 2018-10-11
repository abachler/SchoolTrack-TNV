  // [xShell_ExecutableCommands].Manager_v14.Botón1()
  // Por: Alberto Bachler K.: 20-02-14, 19:08:01
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($y_codigo)


$y_codigo:=OBJECT Get pointer:C1124(Object named:K67:5;"codigo")
If (OBJECT Get visible:C1075(*;"codigoHTML@"))
	EXE_StyleCodeText ($y_codigo)
	OBJECT SET VISIBLE:C603(*;"codigoHTML@";False:C215)
	OBJECT SET TITLE:C194(*;OBJECT Get name:C1087(Object current:K67:2);"Código 4D")
	GOTO OBJECT:C206(*;"codigo")
	HIGHLIGHT TEXT:C210(*;"codigo";Length:C16($y_codigo->)+1;Length:C16($y_codigo->)+1)
Else 
	OBJECT SET VISIBLE:C603(*;"codigoHTML@";True:C214)
	OBJECT SET TITLE:C194(*;OBJECT Get name:C1087(Object current:K67:2);"Editar Script")
	GOTO OBJECT:C206(*;"codigo")
End if 




