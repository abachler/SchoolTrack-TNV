//%attributes = {}
  //PERIODOS_refConfiguracion

$nivel:=$1
$reference:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
If ($reference=0)
	$reference:=-1  //CONFIGURACIÒN POR DEFECTO
End if 

$0:=$reference