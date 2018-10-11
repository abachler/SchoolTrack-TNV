//%attributes = {}
  // WS_SIGE_TipoEnsenanza
  // addTipoEnsenanza
  // http://dido.mineduc.cl:9080/WsApiMineduc/wsdl/TipoEnsenanzaSigeSoapPort.wsdl  
  // 

C_TEXT:C284($0;$2;$semilla;$vt_ini_mañana;$vt_ter_mañana;$vt_ini_tarde;$vt_ter_tarde;$vt_ini_vesp;$vt_ter_vesp;$vt_ini_mt;$vt_ter_mt;$childName)
C_POINTER:C301($1;$ptr_array_values;$3;$ptr_error)
$ptr_array_values:=$1
$semilla:=$2
$ptr_error:=$3

_O_C_STRING:C293(16;$root)
_O_C_STRING:C293(16;$subelem)
C_TEXT:C284($namespace;$RBD)
$namespace:="http://dido.mineduc.cl/Archivos/Schemas/"
$root:=DOM Create XML Ref:C861("EntradaAddTipoEnsenanzaSige";$namespace)
DOM SET XML DECLARATION:C859($root;"UTF-8")

  //$RBD:=String(Num(Substring($ptr_array_values->{1};1;Length($ptr_array_values->{1})-1)))

$ref_1:=DOM_SetElementValueAndAttr ($root;"RecordTipoEnsenanzaSige")
$ref_2:=DOM_SetElementValueAndAttr ($ref_1;"PKTipoEnsenanzaSige")
DOM_SetElementValueAndAttr ($ref_2;"AnioEscolar";String:C10(<>gyear);True:C214)
DOM_SetElementValueAndAttr ($ref_2;"RBD";$ptr_array_values->{1};True:C214)
DOM_SetElementValueAndAttr ($ref_2;"CodigoTipoEnsenanza";$ptr_array_values->{3};True:C214)

DOM_SetElementValueAndAttr ($ref_1;"EstadoTipoEnsenanza";$ptr_array_values->{19};True:C214)
DOM_SetElementValueAndAttr ($ref_1;"NumeroAutorizacion";$ptr_array_values->{6};True:C214)

C_DATE:C307($vd_fecha_aut)
$vd_fecha_aut:=Date:C102($ptr_array_values->{7})
DOM_SetElementValueAndAttr ($ref_1;"FechaAutorizacion";String:C10(Year of:C25($vd_fecha_aut))+"-"+String:C10(Month of:C24($vd_fecha_aut);"00")+"-"+String:C10(Day of:C23($vd_fecha_aut);"00");True:C214)

C_BOOLEAN:C305($vb_CP;$vb_PJ)
If ($ptr_array_values->{4}="SI")
	$vb_CP:=True:C214
	If ($ptr_array_values->{5}="SI")
		$vb_PJ:=True:C214
	End if 
End if 

DOM_SetElementValueAndAttr ($ref_1;"TieneCentroPadres";ST_Boolean2Str ($vb_CP;"True";"False");True:C214)
DOM_SetElementValueAndAttr ($ref_1;"TienePersonalidadJuridica";ST_Boolean2Str ($vb_PJ;"True";"False");True:C214)
DOM_SetElementValueAndAttr ($ref_1;"NumeroGruposDiferenciales";$ptr_array_values->{10};True:C214)

$vt_ini_mañana:=String:C10(Time:C179($ptr_array_values->{11});1)+"-03:00"
$vt_ter_mañana:=String:C10(Time:C179($ptr_array_values->{12});1)+"-03:00"
$vt_ini_tarde:=String:C10(Time:C179($ptr_array_values->{13});1)+"-03:00"
$vt_ter_tarde:=String:C10(Time:C179($ptr_array_values->{14});1)+"-03:00"
$vt_ini_mt:=String:C10(Time:C179($ptr_array_values->{15});1)+"-03:00"
$vt_ter_mt:=String:C10(Time:C179($ptr_array_values->{16});1)+"-03:00"
$vt_ini_vesp:=String:C10(Time:C179($ptr_array_values->{17});1)+"-03:00"
$vt_ter_vesp:=String:C10(Time:C179($ptr_array_values->{18});1)+"-03:00"

DOM_SetElementValueAndAttr ($ref_1;"HorarioInicioManana";$vt_ini_mañana;True:C214)
DOM_SetElementValueAndAttr ($ref_1;"HorarioTerminoManana";$vt_ter_mañana;True:C214)
DOM_SetElementValueAndAttr ($ref_1;"HorarioInicioTarde";$vt_ini_tarde;True:C214)
DOM_SetElementValueAndAttr ($ref_1;"HorarioTerminoTarde";$vt_ter_tarde;True:C214)
DOM_SetElementValueAndAttr ($ref_1;"HorarioInicioMananaTarde";$vt_ini_mt;True:C214)
DOM_SetElementValueAndAttr ($ref_1;"HorarioTerminoMananaTarde";$vt_ter_mt;True:C214)
DOM_SetElementValueAndAttr ($ref_1;"HorarioInicioVespertino";$vt_ini_vesp;True:C214)
DOM_SetElementValueAndAttr ($ref_1;"HorarioTerminoVespertino";$vt_ter_vesp;True:C214)

DOM_SetElementValueAndAttr ($root;"Semilla";$semilla;True:C214)

WEB SERVICE SET PARAMETER:C777("XMLIn";$root)

  //para ver como genero el xml
DOM EXPORT TO VAR:C863($root;$text)
CLEAR PASTEBOARD:C402
SET TEXT TO PASTEBOARD:C523($text)

vtWS_ErrorString:=""
ON ERR CALL:C155("WS_ErrorHandler")
WEB SERVICE CALL:C778("http://w7app.mineduc.cl/WsApiMineduc/services/TipoEnsenanzaSigeSoapPort";"addTipoEnsenanza";"addTipoEnsenanza";"http://wwwfs.mineduc.cl/Archivos/Schemas/";Web Service manual:K48:4)


$vt_cod_resp:=""
If (OK=1)
	C_BLOB:C604($blob)
	_O_C_STRING:C293(16;$resroot)
	_O_C_STRING:C293(16;$ressubelem)
	
	$vt_msg:=""
	
	WEB SERVICE GET RESULT:C779($blob;"XMLOut";*)
	$resroot:=DOM Parse XML variable:C720($blob)
	
	  //DOM EXPORT TO FILE($resroot;"") para revisar el xml en un archivo
	
	$ressubelem:=DOM Find XML element:C864($resroot;"/SalidaAddTipoEnsenanzaSige/CodigoRespuestaTipoEnsenanza")
	DOM GET XML ELEMENT VALUE:C731($ressubelem;$vt_cod_resp)
	
	If ($vt_cod_resp="2")
		
		$xml_Parent_Ref:=DOM Get first child XML element:C723($resroot;$childName;$childValue)
		$xml_Parent_Ref2:=DOM Get next sibling XML element:C724($xml_Parent_Ref;$childName;$childValue)
		$xml_Parent_Ref3:=DOM Get first child XML element:C723($xml_Parent_Ref2;$childName;$childValue)
		$xml_Parent_Ref4:=DOM Get next sibling XML element:C724($xml_Parent_Ref3;$childName;$childValue)
		$vt_msg:=$vt_msg+"\r"+$childValue
		
		While (OK=1)
			$xml_Parent_Ref4:=DOM Get next sibling XML element:C724($xml_Parent_Ref4;$childName;$childValue)
			If (OK=1)
				$vt_msg:=$vt_msg+" "+$childValue
			End if 
		End while 
		
	End if 
	
	DOM CLOSE XML:C722($resroot)
Else 
	$vt_msg:="Argumentos invalidos o faltantes en el envío, revise la configuración del tipo de enseñanza."
	$vt_cod_resp:="-1"
End if 

DOM CLOSE XML:C722($root)
$ptr_error->:=$vt_msg
$0:=$vt_cod_resp
