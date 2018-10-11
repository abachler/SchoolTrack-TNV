//%attributes = {}
C_TEXT:C284($dato;$1)
C_POINTER:C301($2;$3)
C_POINTER:C301($parameterNames;$parameterValues)

$parameterNames:=$2
$parameterValues:=$3

$dato:=$1
Case of 
	: ($dato="asistencia")
		$0:=STWA2_Dash_Asistencia ($parameterNames;$parameterValues)
	: ($dato="calificaciones")
		$0:=STWA2_Dash_Calificaciones ($parameterNames;$parameterValues)
	: ($dato="anotaciones")
		$0:=STWA2_Dash_Anotaciones ($parameterNames;$parameterValues)
	: ($dato="prestamos")
		  //$0:=STWA2_Dash_Prestamos($parameterNames;$parameterValues)
	: ($dato="deudaactual")
		$0:=STWA2_Dash_DeudaActual ($parameterNames;$parameterValues)
	: ($dato="atrasos")
		$0:=STWA2_Dash_Atrasos ($parameterNames;$parameterValues)
	: ($dato="mapas")
		$0:=STWA2_Dash_Aprendizajes ($parameterNames;$parameterValues)
End case 