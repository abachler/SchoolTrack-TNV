//%attributes = {}
  //RINSCwa_TestJSONPagos 

  //Ejemplo json

  // Modificado por: Alexis Bustamante (12-06-2017)
  //TICKET 179869

C_TEXT:C284($json;$0)
C_TEXT:C284($t_texto;$t_ref)
C_OBJECT:C1216($ob)
If ((Not:C34(Is compiled mode:C492)) | (USR_GetUserID <0))
	C_TEXT:C284(<>tACT_ruta;$t_texto;$t_ref)
	C_BLOB:C604($xBlob)
	If (<>tACT_ruta="")
		<>tACT_ruta:=xfGetFileName 
	End if 
	DOCUMENT TO BLOB:C525(<>tACT_ruta;$xBlob)
	$t_texto:=Convert to text:C1012($xBlob;"UTF-8")
	
	$ob:=JSON Parse:C1218($t_texto)
	  //$t_ref:=JSON Parse text ($t_texto)
	$json:=OB_Object2Json ($ob)
	
	SET TEXT TO PASTEBOARD:C523($json)
	  //$json:=JSON Export to text ($t_ref;JSON_WITHOUT_WHITE_SPACE)
	  //JSON CLOSE ($t_ref)
End if 
$0:=$json
