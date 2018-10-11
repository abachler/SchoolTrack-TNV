//%attributes = {}
  //ACTpw_RetreivePagosBC
C_TEXT:C284($t_json;$methodCalledOnError)


If (Is compiled mode:C492)
	
	  //WSact_DTECallWebService
	C_LONGINT:C283($vl_proc)
	
	$methodCalledOnError:=Method called on error:C704
	ON ERR CALL:C155("WS_ErrorHandler")
	
	vtWS_ErrorNum:=""
	vtWS_ErrorString:=""
	
	WEB SERVICE SET PARAMETER:C777("rol";<>gRolBD)
	WEB SERVICE SET PARAMETER:C777("codigopais";<>vtXS_CountryCode)
	
	$vl_proc:=IT_UThermometer (1;0;"Contactándose con Colegium...")
	WEB SERVICE CALL:C778("http://bancomer.colegium.com:8080/BancomerWS/BancomerServices";"";"sincroniza_pendientes";"http://bancomerws.colegium.cl/";Web Service dynamic:K48:1)
	IT_UThermometer (-2;$vl_proc)
	EM_ErrorManager ("Clear")
	
	If (vtWS_ErrorString="")
		WEB SERVICE GET RESULT:C779($t_json;"return";*)
	Else 
		  //20170220 RCH Se usa objeto
		C_OBJECT:C1216($ob)
		OB SET:C1220($ob;"error";-1;"descripcion";vtWS_ErrorString)
		$t_json:=JSON Stringify:C1217($ob)
		
	End if 
	ON ERR CALL:C155($methodCalledOnError)
	
Else 
	  //20170220 RCH Se usa objeto
	C_OBJECT:C1216($ob)
	OB SET:C1220($ob;"error";0;"descripcion";"")
	$t_json:=JSON Stringify:C1217($ob)
	
End if 

$0:=$t_json