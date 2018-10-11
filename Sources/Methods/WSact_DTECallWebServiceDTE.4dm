//%attributes = {}
  //WSact_DTECallWebServiceDTE

  //WSact_DTECallWebService
C_TEXT:C284($vt_method;$1;$vt_url)
C_LONGINT:C283($vl_proc)

$vt_method:=$1

error:=0
EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")
  //$vl_proc:=IT_UThermometer (1;0;"Contactándose con Colegium...")
WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;180)
$vt_url:="http://172.16.0.150:8081/4DSOAP/"
$vt_url:=PREF_fGet (0;"ACT_PrefURLDTEManejoArchivos";$vt_url)
  //$vt_url:="http://192.168.2.2:8081/4DSOAP/"
  //$vt_url:="http://172.16.0.236:8081/4DSOAP/"
$vt_url:="http://172.16.0.155:8081/4DSOAP/"

  //CALL WEB SERVICE("http://intranet.colegium.com/4DSOAP/";"SchoolNetII_WebServices#WSsend_RazonesSociales";$vt_method;"http://intranet.colegium.com/namespace_SchoolNetII";Web Service Dynamic)
WEB SERVICE CALL:C778($vt_url;"A_WebService#WSout_SendFolioDTE";$vt_method;"http://www.4d.com/namespace/default";Web Service dynamic:K48:1)
  //IT_UThermometer (-2;$vl_proc)
EM_ErrorManager ("Clear")
