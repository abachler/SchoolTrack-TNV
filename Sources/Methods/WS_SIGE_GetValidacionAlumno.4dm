//%attributes = {}
  // WS_SIGE_GetValidacionAlumno
  // getValidacion
  // http://dido.mineduc.cl:9080/WsApiMineduc/wsdl/ValidaAlumnoSigeSoapPort.wsdl 
  // 
  // M?todo generado autom‡ticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------

C_TEXT:C284($1)
_O_C_STRING:C293(16;$root)
_O_C_STRING:C293(16;$subelem)
C_TEXT:C284($0;$namespace;$semilla;$vt_resultado)
C_TEXT:C284($numero_de_rut;$dv)
C_LONGINT:C283($vl_resultado)

$semilla:=$1
vtWS_ErrorString:=""

$namespace:="http://wwwfs.mineduc.cl/Archivos/Schemas/"

$root:=DOM Create XML Ref:C861("EntradaValidaAlumnoSige";$namespace)
DOM SET XML DECLARATION:C859($root;"UTF-8")

$numero_de_rut:=String:C10(Num:C11(Substring:C12([Alumnos:2]RUT:5;1;Length:C16([Alumnos:2]RUT:5)-1)))
$dv:=Substring:C12([Alumnos:2]RUT:5;Length:C16([Alumnos:2]RUT:5))

$ref_run:=DOM_SetElementValueAndAttr ($root;"Run")

DOM_SetElementValueAndAttr ($ref_run;"numero";$numero_de_rut;True:C214)
DOM_SetElementValueAndAttr ($ref_run;"dv";$dv;True:C214)

DOM_SetElementValueAndAttr ($root;"Nombres";[Alumnos:2]Nombres:2;True:C214)
DOM_SetElementValueAndAttr ($root;"ApellidoPaterno";[Alumnos:2]Apellido_paterno:3;True:C214)
DOM_SetElementValueAndAttr ($root;"ApellidoMaterno";[Alumnos:2]Apellido_materno:4;True:C214)
DOM_SetElementValueAndAttr ($root;"Semilla";$semilla;True:C214)

WEB SERVICE SET PARAMETER:C777("XMLIn";$root)

ON ERR CALL:C155("WS_ErrorHandler")

WEB SERVICE CALL:C778("http://w7app.mineduc.cl/WsApiMineduc/services/ValidaAlumnoSigeSoapPort";"getValidacion";"getValidacion";"http://wwwfs.mineduc.cl/Archivos/Schemas/";Web Service manual:K48:4)

$vt_resultado:=""
If (OK=1)
	C_BLOB:C604($blob)
	_O_C_STRING:C293(16;$resroot)
	_O_C_STRING:C293(16;$ressubelem)
	_O_C_STRING:C293(16;$0)
	
	WEB SERVICE GET RESULT:C779($blob;"XMLOut";*)
	$resroot:=DOM Parse XML variable:C720($blob)
	
	$ressubelem:=DOM Find XML element:C864($resroot;"/SalidaValidaAlumnoSige/ExisteFichaAlumno")
	DOM GET XML ELEMENT VALUE:C731($ressubelem;$vt_resultado)
	DOM CLOSE XML:C722($resroot)
	
End if 
DOM CLOSE XML:C722($root)
$0:=$vt_resultado
