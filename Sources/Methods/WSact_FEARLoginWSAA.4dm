//%attributes = {}
  // 
  // WSact_FEARLoginWSAA
  // https://wswhomo.afip.gov.ar/wsfev1/service.asmx?WSDL
  // 
  // Método generado automáticamente por el asistente de Servicios Web de 4D.
  // ----------------------------------------------------------------
C_BOOLEAN:C305(<>bACTfear_CopiarRequest;<>bACTfear_CopiarResponse)
C_TEXT:C284($t_xmlOUT;$t_xml)
C_TEXT:C284($1)
C_TEXT:C284($0)
C_TEXT:C284($2)
C_LONGINT:C283($l_idRS)
C_BLOB:C604(xblob)
SET BLOB SIZE:C606(xblob;0)

$t_prefName:=$2
$t_dtsAhora:=$3
$l_idRS:=$4
  //If (False)

_O_C_STRING:C293(16;$root)
_O_C_STRING:C293(16;$subElem)
C_TEXT:C284($nameSpace)
$nameSpace:="http://wsaa.view.sua.dvadac.desein.afip.gov"
$root:=DOM Create XML Ref:C861("loginCms";$nameSpace)

$subElem:=DOM Create XML element:C865($root;"/loginCms/in0")
DOM SET XML ELEMENT VALUE:C868($subElem;$1)

WEB SERVICE SET PARAMETER:C777("XMLIn";$root)

If (<>bACTfear_CopiarRequest)
	DOM EXPORT TO VAR:C863($root;$t_xmlOUT)
	SET TEXT TO PASTEBOARD:C523($t_xmlOUT)
End if 

ACTfear_CallWebService ("loginCms";$l_idRS)
  //WEB SERVICE CALL("https://wsaahomo.afip.gov.ar/ws/services/LoginCms";"";"loginCms";"http://wsaa.view.sua.dvadac.desein.afip.gov";Web Service Manual)
  //201500810 RCH Se agrega testeo de variable vtWS_ErrorString y se devuelve en $0 solo si se obtiene loginCmsReturn
If (vtWS_ErrorString="")
	EM_ErrorManager ("Install")
	EM_ErrorManager ("SetMode";"")
	
	_O_C_STRING:C293(16;$resRoot)
	_O_C_STRING:C293(16;$resSubElem)
	WEB SERVICE GET RESULT:C779(xblob;"XMLOut";*)
	$resRoot:=DOM Parse XML variable:C720(xblob)
	If (OK=1)
		If (<>bACTfear_CopiarResponse)
			DOM EXPORT TO VAR:C863($resRoot;$t_xml)
			SET TEXT TO PASTEBOARD:C523($t_xmlOUT+$t_xml)
		End if 
		
		$resSubElem:=DOM Find XML element:C864($resRoot;"/loginCmsResponse/loginCmsReturn")
		If ($resSubElem#"0000000000000000")
			
			PREF_SetBlob (0;$t_prefName;xblob)
			PREF_Set (0;$t_prefName;$t_dtsAhora)
			
			DOM GET XML ELEMENT VALUE:C731($resSubElem;$0)
			
		End if 
		
		DOM CLOSE XML:C722($resRoot)
		
	End if 
	EM_ErrorManager ("Clear")
Else 
	If (<>bACTfear_CopiarResponse)
		SET TEXT TO PASTEBOARD:C523($t_xmlOUT+vtWS_ErrorString)
	End if 
End if 

DOM CLOSE XML:C722($root)

SET BLOB SIZE:C606(xblob;0)
