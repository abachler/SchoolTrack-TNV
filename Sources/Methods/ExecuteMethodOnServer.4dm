//%attributes = {"executedOnServer":true}
  // ExecMethodOnServer()
  //
  //
  // creado por: Alberto Bachler Klein: 25-11-15, 15:57:49
  // -----------------------------------------------------------
C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_OBJECT:C1216($2)
C_OBJECT:C1216($3)

C_TEXT:C284($t_metodo)
C_OBJECT:C1216($ob_Parametros;$ob_Retorno)


If (False:C215)
	C_OBJECT:C1216(ExecuteMethodOnServer ;$0)
	C_TEXT:C284(ExecuteMethodOnServer ;$1)
	C_OBJECT:C1216(ExecuteMethodOnServer ;$2)
	C_OBJECT:C1216(ExecuteMethodOnServer ;$3)
End if 

$t_metodo:=$1
$ob_Retorno:=$2
$ob_Parametros:=$3
EXECUTE METHOD:C1007($t_metodo;$ob_Retorno;$ob_Parametros)
$0:=$ob_retorno




  //C_POINTER($y_Retorno)
  //C_TEXT($t_nombreMetodo)


  //$t_nombreMetodo:=$1
  //$y_Retorno:=$2

  //  //TRACE
  //Case of
  //: (Count parameters=2)
  //EXECUTE METHOD($t_nombreMetodo;$y_Retorno->)
  //: (Count parameters=3)
  //EXECUTE METHOD($t_nombreMetodo;$y_Retorno->;$3->)
  //: (Count parameters=4)
  //EXECUTE METHOD($t_nombreMetodo;$y_Retorno->;$3->;$4->)
  //: (Count parameters=5)
  //EXECUTE METHOD($t_nombreMetodo;$y_Retorno->;$3->;$4->;$5->)
  //: (Count parameters=6)
  //EXECUTE METHOD($t_nombreMetodo;$y_Retorno->;$3->;$4->;$5->;$6->)
  //: (Count parameters=7)
  //EXECUTE METHOD($t_nombreMetodo;$y_Retorno->;$3->;$4->;$5->;$6->;$7->)
  //: (Count parameters=8)
  //EXECUTE METHOD($t_nombreMetodo;$y_Retorno->;$3->;$4->;$5->;$6->;$7->;$8->)
  //End case

  //$0:=$y_Retorno