//%attributes = {}
  //SIGE_wsGetDatosColegio 
  //MONO ticket 144984
C_OBJECT:C1216($ob_request;$ob_response)
C_TEXT:C284($t_jsonRequest;$t_errormsg;$t_json)
C_LONGINT:C283($httpStatus_l)

C_TEXT:C284($err;$0)
C_TEXT:C284($SIGE_ID_convenio;$SIGE_ID_cliente;$SIGE_ConvenioToken)

$ob_request:=OB_Create 
OB_SET ($ob_request;-><>GROLBD;"rolbd")
OB_SET ($ob_request;-><>GCOUNTRYCODE;"codpais")

$t_jsonRequest:=OB_Object2Json ($ob_request;True:C214)
$httpStatus_l:=Intranet3_LlamadoWS ("WS_SIGE_datos_colegio";$t_jsonRequest;->$t_json)


If ($httpStatus_l=200)
	$ob_response:=JSON Parse:C1218($t_json;Is object:K8:27)
	
	OB_GET ($ob_response;->$SIGE_ID_convenio;"resultado.id_convenio")
	OB_GET ($ob_response;->$SIGE_ID_cliente;"resultado.id_cliente")
	OB_GET ($ob_response;->$SIGE_ConvenioToken;"resultado.convenio_token")
	OB_GET ($ob_response;->$err;"resultado.mensaje")
	
	C_BLOB:C604($xBlob)
	SET BLOB SIZE:C606($xBlob;0)
	BLOB_Variables2Blob (->$xBlob;0;->$SIGE_ID_convenio;->$SIGE_ID_cliente;->$SIGE_ConvenioToken)
	PREF_SetBlob (0;"SIGE_Datos_Cliente";$xBlob)
	
End if 

$0:=$err