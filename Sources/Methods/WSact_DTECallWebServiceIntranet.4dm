//%attributes = {}
  //WSact_DTECallWebServiceIntranet 

  //WSact_DTECallWebService
C_TEXT:C284($vt_method;$1;$vt_url)
C_LONGINT:C283($vl_proc)

$vt_method:=$1

error:=0
EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")
$vl_proc:=IT_UThermometer (1;0;"Contactándose con Colegium...")
WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;180)
WEB SERVICE CALL:C778("https://intranet.colegium.com/4DSOAP/";"SchoolNetII_WebServices#WSsend_RazonesSociales";$vt_method;"http://intranet.colegium.com/namespace_SchoolNetII";Web Service dynamic:K48:1)
IT_UThermometer (-2;$vl_proc)
EM_ErrorManager ("Clear")
