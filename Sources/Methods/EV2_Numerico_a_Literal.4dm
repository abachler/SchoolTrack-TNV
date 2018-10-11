//%attributes = {}
  // EV2_Numerico_a_Literal()
  //
  //
  // creado por: Alberto Bachler Klein: 09-07-16, 11:11:50
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_REAL:C285($1)
C_LONGINT:C283($2)
C_REAL:C285($3)

C_LONGINT:C283($l_decimales)
C_REAL:C285($r_minimo;$r_valorEvaluacion)
C_TEXT:C284($t_formato)


If (False:C215)
	C_TEXT:C284(EV2_Numerico_a_Literal ;$0)
	C_REAL:C285(EV2_Numerico_a_Literal ;$1)
	C_LONGINT:C283(EV2_Numerico_a_Literal ;$2)
	C_REAL:C285(EV2_Numerico_a_Literal ;$3)
End if 

$r_valorEvaluacion:=$1
$l_decimales:=$2
$r_minimo:=$3
Case of 
	: ($r_valorEvaluacion=-10)
		$0:=""
	: ($r_valorEvaluacion=-3)
		$0:="X"
	: ($r_valorEvaluacion=-2)
		$0:="P"
	: ($r_valorEvaluacion=-4)
		$0:="*"
	: ($r_valorEvaluacion=-1)
		$0:=""
	Else 
		If ($r_valorEvaluacion>=$r_minimo)
			$t_formato:="###0"+<>vs_AppDecimalSeparator+("0"*$l_decimales)
			$0:=String:C10($r_valorEvaluacion;$t_formato)
		Else 
			$0:=""
		End if 
End case 