//%attributes = {}
  //ACTfear_ObtieneCredenciales
C_TEXT:C284($t_ref;$resSubElem;$t_token;$t_sign)
C_POINTER:C301($2;$3)
C_LONGINT:C283($0)
C_BLOB:C604($xBlob)
C_TEXT:C284($t_ws)
C_LONGINT:C283($l_idRS)
C_TEXT:C284($t_dtsAhora;$t_dts)
C_DATE:C307($d_currDate;$d_prefDate)
C_TIME:C306($h_currTime;$h_prefTime)
C_BOOLEAN:C305($b_solicitar)
C_TEXT:C284(T_result;$vt_rutaCadenaOriginal;vtACT_llavePubCertificado;vtACT_llavePrivCertificado;$t_function)
C_TEXT:C284($t_result)
ARRAY TEXT:C222($etiquetasErr;0)
ARRAY TEXT:C222($valoresErr;0)

  //$t_CUIT:="20325866102"
$t_ws:="wsfe"

  //If (Count parameters>=1)
  //$vlACT_RSSel:=$1
  //End if 
  //
  //If ($vlACT_RSSel=0)
  //$vlACT_RSSel:=-1
  //End if 

$l_idRS:=$1
If ($l_idRS=0)
	$l_idRS:=-1
End if 
  //***** OJO *****
  //20160413 RCH Si en algun momento indican que hay un error de toket o hash, pueden solicitar ejecutar el script: ACTfear_EliminaToken
  //***** OJO *****
ACTfear_OpcionesGenerales ("CargaConf";->$l_idRS)

$t_nomPref:=ACTfear_OpcionesGenerales ("ObtieneNombrePreferencia";->$l_idRS;->$t_ws)
  //$t_nomPref:="ACT_WS_DTE_AR_loginCms_IDRS_"+String($l_idRS)+"_Service_"+$t_ws
$d_currDate:=Current date:C33
$h_currTime:=Current time:C178
$t_dtsAhora:=DTS_MakeFromDateTime ($d_currDate;$h_currTime)

$t_dts:=PREF_fGet (0;$t_nomPref;$t_dts)
$xBlob:=PREF_fGetBlob (0;$t_nomPref)

$d_prefDate:=DTS_GetDate ($t_dts)
$h_prefTime:=DTS_GetTime ($t_dts)

$b_solicitar:=False:C215
If (($t_dts="") | (BLOB size:C605($xBlob)=0))
	$b_solicitar:=True:C214
Else 
	  //calcular para que si es mas de 12 horas, se pida
	TRACE:C157
	$h_prefTime:=$h_prefTime+?12:00:00?
	If ($h_prefTime>?24:00:00?)
		$d_prefDate:=Add to date:C393($d_prefDate;0;0;1)
		$h_prefTime:=$h_prefTime-?24:00:00?
	End if 
	Case of 
		: (($d_currDate-$d_prefDate)>=1)  //si ocurre esto es poque hay mas de 24 horas de diferencia
			$b_solicitar:=True:C214
		: (($d_currDate=$d_prefDate) & ($h_currTime>=$h_prefTime))  //si es el mismo díá
			$b_solicitar:=True:C214
	End case 
End if 

If ($b_solicitar)
	$t_retorno:=ACTfear_GeneraTRA ($l_idRS;True:C214;->$xBlob;$t_dtsAhora)
Else 
	$xBlob:=PREF_fGetBlob (0;$t_nomPref+"_RESPONSE")
	$t_retorno:=""
End if 

If ($t_retorno="")
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	$t_ref:=DOM Parse XML variable:C720($xBlob)
	If (ok=1)
		
		$resSubElem:=DOM Find XML element:C864($t_ref;"/loginTicketResponse/credentials/token")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$t_token)
		
		$resSubElem:=DOM Find XML element:C864($t_ref;"/loginTicketResponse/credentials/sign")
		DOM GET XML ELEMENT VALUE:C731($resSubElem;$t_sign)
		
		DOM CLOSE XML:C722($t_ref)
	Else 
		CD_Dlog (0;"Las credenciales no pudieron ser obtenidas.")
	End if 
	EM_ErrorManager ("Clear")
	
	$2->:=$t_token
	$3->:=$t_sign
Else 
	ok:=0
End if 
$0:=ok