//%attributes = {}
  // 
  // obtenerFechaFoto
  // http://144.202.248.43/Colegium/ConsultarCalendario.asmx?wsdl 
  // 
  // M?todo generado autom‡ticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------

C_TEXT:C284($0)
C_POINTER:C301($1)
_O_C_STRING:C293(16;$root)
_O_C_STRING:C293(16;$subelem)
C_TEXT:C284($namespace;$vt_ws)
vtWS_ErrorString:=""
$vt_ws:=PREF_fGet (-555;"WSMXLEG_Fecha")

$namespace:="http://lcred.org/"
$root:=DOM Create XML Ref:C861("obtenerFechaFoto";$namespace)

WEB SERVICE SET PARAMETER:C777("XMLIn";$root)
ON ERR CALL:C155("WS_ErrorHandler")
WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;200)
  //CALL WEB SERVICE("http://144.202.248.43/Colegium/ConsultarCalendario.asmx";"http://lcred.org/obtenerFechaFoto";"obtenerFechaFoto";"http://lcred.org/";Web Service Manual )
WEB SERVICE CALL:C778($vt_ws;"http://lcred.org/obtenerFechaFoto";"obtenerFechaFoto";"http://lcred.org/";Web Service manual:K48:4)
$1->:=vtWS_ErrorString

If (OK=1)
	C_BLOB:C604($blob)
	_O_C_STRING:C293(16;$resroot)
	_O_C_STRING:C293(16;$ressubelem)
	WEB SERVICE GET RESULT:C779($blob;"XMLOut";*)
	$resroot:=DOM Parse XML variable:C720($blob)
	
	$ressubelem:=DOM Find XML element:C864($resroot;"/obtenerFechaFotoResponse/obtenerFechaFotoResult")
	DOM GET XML ELEMENT VALUE:C731($ressubelem;$0)
	DOM CLOSE XML:C722($resroot)
	
End if 

DOM CLOSE XML:C722($root)
