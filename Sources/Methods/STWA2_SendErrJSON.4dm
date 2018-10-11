//%attributes = {}
C_TEXT:C284($msg;$1)
C_TEXT:C284($errCode;$2)
C_TEXT:C284($json;$0)

$msg:=ST_Qte ($1)
$errCode:=ST_Qte ($2)

  //$json:=JSON New
C_OBJECT:C1216($ob_objeto)
  //JSON_AgregaTexto ($json;$errCode;"error")
  //JSON_AgregaTexto ($json;$msg;"mensaje")
JSON_AgregaTexto ($ob_objeto;$errCode;"error")
JSON_AgregaTexto ($ob_objeto;$msg;"mensaje")
$0:=OB_Object2Json ($ob_objeto)
  //$0:=JSON Export to text ($json;JSON_WITHOUT_WHITE_SPACE)
  //JSON CLOSE ($json)
