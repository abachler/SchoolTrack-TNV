//%attributes = {}
  // WS_SIGE_Get_Semilla
  // GetSemillaServicios

C_TEXT:C284($0)

_O_C_STRING:C293(16;$root)
_O_C_STRING:C293(16;$subelem)
C_TEXT:C284($namespace;$ConvenioToken;$ClienteId;$ConvenioId)

  //DATOS COLEGIUM

C_BLOB:C604($xBlob)
SET BLOB SIZE:C606($xBlob;0)
$xBlob:=PREF_fGetBlob (0;"SIGE_Datos_Cliente")
BLOB_Blob2Vars (->$xBlob;0;->$ConvenioId;->$ClienteId;->$ConvenioToken)
SET BLOB SIZE:C606($xBlob;0)
If (($ClienteId="") | ($ConvenioId="") | ($ConvenioToken=""))
	SIGE_wsGetDatosColegio 
	$xBlob:=PREF_fGetBlob (0;"SIGE_Datos_Cliente")
	BLOB_Blob2Vars (->$xBlob;0;->$ConvenioId;->$ClienteId;->$ConvenioToken)
	
	If (($ClienteId="") | ($ConvenioId="") | ($ConvenioToken=""))
		CD_Dlog (0;"El ID de cliente, convenio y token del convenio no pudieron ser obtenidos de la intranet de Colegium. Por favor contacte a la mesa de ayuda.")
		$b_continuar:=False:C215
	Else 
		$b_continuar:=True:C214
	End if 
Else 
	$b_continuar:=True:C214
End if 

  //$ClienteId:="11"
  //$ConvenioId:="12"
  //$ConvenioToken:="TESTCOLEGIUM"
$vt_semilla:=""

  //SemillaServiciosSoapPort.wsdl
If ($b_continuar)
	
	$namespace:="http://wwwfs.mineduc.cl/Archivos/Schemas/"
	$root:=DOM Create XML Ref:C861("EntradaSemillaServicios";$namespace)
	
	DOM SET XML DECLARATION:C859($root;"UTF-8")
	
	DOM_SetElementValueAndAttr ($root;"ClienteId";$ClienteId;True:C214)
	DOM_SetElementValueAndAttr ($root;"ConvenioId";$ConvenioId;True:C214)
	DOM_SetElementValueAndAttr ($root;"ConvenioToken";$ConvenioToken;True:C214)
	
	WEB SERVICE SET PARAMETER:C777("XMLIn";$root)
	
	vtWS_ErrorNum:=""
	vtWS_ErrorString:=""
	
	$methodCalledOnError:=Method called on error:C704
	ON ERR CALL:C155("WS_ErrorHandler")
	WEB SERVICE CALL:C778("http://w7app.mineduc.cl/WsApiAutorizacion/services/SemillaServiciosSoapPort";"getSemillaServicios";"getSemillaServicios";"http://wwwfs.mineduc.cl/Archivos/Schemas/";Web Service manual:K48:4)
	ON ERR CALL:C155($methodCalledOnError)
	
	If ((OK=1) & (vtWS_ErrorString=""))
		C_BLOB:C604($blob)
		_O_C_STRING:C293(16;$resroot)
		_O_C_STRING:C293(16;$ressubelem)
		
		WEB SERVICE GET RESULT:C779($vt_semilla;"ValorSemilla")
		
		WEB SERVICE GET RESULT:C779($blob;"XMLOut";*)
		$resroot:=DOM Parse XML variable:C720($blob)
		
		$ressubelem:=DOM Find XML element:C864($resroot;"/SemillaServicios/ValorSemilla")
		DOM GET XML ELEMENT VALUE:C731($ressubelem;$vt_semilla)
		DOM CLOSE XML:C722($resroot)
		
	End if 
	DOM CLOSE XML:C722($root)
End if 

$0:=$vt_semilla
