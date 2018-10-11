//%attributes = {}
  //BKP_ConsultaEstadoSolicSubida
C_TEXT:C284($t_principal;$node;$json;$0)

If (Undefined:C82(<>atBKP_LOG))
	ARRAY TEXT:C222(<>atBKP_LOG;0)
End if 

BKP_EscribeLog (Current method name:C684)


  // Modificado por: Alexis Bustamante (10-06-2017)
  // Ticket 179869


C_OBJECT:C1216($ob_error)
$ob_error:=OB_Create 
OB_SET ($ob_error;-><>atBKP_LOG;"error")

$json:=OB_Object2Json ($ob_error)
$0:=$json

  //$t_principal:=JSON New 
  //JSON_EstableceValor ($t_principal;-><>atBKP_LOG;"error")
  //$json:=JSON Export to text ($t_principal;JSON_WITHOUT_WHITE_SPACE)
  //JSON CLOSE ($t_principal)

  //$0:=$json
