//%attributes = {}
  //WSact_sincronizaFoliosDisponib

  //WSact_CargaCAF

C_TEXT:C284($1)
C_LONGINT:C283($0)
C_LONGINT:C283(vlWS_estado)
C_TEXT:C284(vtWS_glosa)
vlWS_estado:=0
vtWS_glosa:=""
  //vtWS_folios:=""
C_BLOB:C604($xInput)
C_TEXT:C284($t_ref)

$t_rut:="969288109"

$b_caso1:=False:C215
$b_caso2:=False:C215
$b_caso3:=True:C214
$b_caso4:=False:C215

TRACE:C157
Case of 
	: ($b_caso1)
		  //opcion 1
		$nameSpace:="http://dtenet.colegium.com/FoliosDisponibles/"
		$t_ref:=DOM Create XML Ref:C861("fol:doFoliosDisponibles";$nameSpace)
		DOM_SetElementValueAndAttr ($t_ref;"contribuyente";$t_rut;True:C214)
		DOM EXPORT TO VAR:C863($t_ref;$xInput)
		DOM EXPORT TO VAR:C863($t_ref;$t_texto)
		DOM CLOSE XML:C722($t_ref)
		SET TEXT TO PASTEBOARD:C523($t_texto)
		WEB SERVICE SET PARAMETER:C777("Param";$xInput)
		
		WEB SERVICE CALL:C778("http://192.168.0.20:8080/dteNet/FoliosDisponiblesService";"http://dtenet.colegium.com/FoliosDisponibles/doFoliosDisponibles";"doFoliosDisponibles";"http://dtenet.colegium.com/FoliosDisponibles/";Web Service manual out:K48:3)
		
		$text:=WEB SERVICE Get info:C780(1)
		If ($text#"")
			
		End if 
		If (OK=1)
			C_BLOB:C604($xx_tipo3)
			WEB SERVICE GET RESULT:C779($xx_tipo3;*)
			If (BLOB size:C605($xx_tipo3)>0)
				$t_ref:=DOM Parse XML variable:C720($xx_tipo3)
				DOM EXPORT TO VAR:C863($t_ref;$t_varXML)
				If (ok=1)
					SET TEXT TO PASTEBOARD:C523($t_varXML)
				End if 
				DOM CLOSE XML:C722($t_ref)
			End if 
		End if 
		
		
	: ($b_caso2)
		WEB SERVICE SET PARAMETER:C777("contribuyente";$t_rut)
		WEB SERVICE CALL:C778("http://192.168.0.20:8080/dteNet/FoliosDisponiblesService";"http://dtenet.colegium.com/FoliosDisponibles/doFoliosDisponibles";"doFoliosDisponibles";"http://dtenet.colegium.com/FoliosDisponibles/";Web Service dynamic:K48:1)
		
		C_TEXT:C284($t_tipo3)
		WEB SERVICE GET RESULT:C779($t_tipo3;"foliosTipo";*)
		
	: ($b_caso3)
		WEB SERVICE SET PARAMETER:C777("contribuyente";$t_rut)
		WEB SERVICE CALL:C778("http://192.168.0.21:8080/dteNet/FoliosDisponiblesService";"http://dtenet.colegium.com/FoliosDisponibles/doFoliosDisponibles";"doFoliosDisponibles";"http://dtenet.colegium.com/FoliosDisponibles/";Web Service manual out:K48:3)
		
		  //tipo blob
		C_BLOB:C604($xx_tipo3)
		  //GET WEB SERVICE RESULT($xx_tipo3;"foliosTipo";*)
		WEB SERVICE GET RESULT:C779($xx_tipo3)
		
		$t_ref:=DOM Parse XML variable:C720($xx_tipo3)
		DOM EXPORT TO VAR:C863($t_ref;$t_varXML)
		If (ok=1)
			SET TEXT TO PASTEBOARD:C523($t_varXML)
		End if 
		DOM CLOSE XML:C722($t_ref)
		
		  //tipo texto
		C_TEXT:C284($t_tipo3)
		WEB SERVICE GET RESULT:C779($t_tipo3;"Tipo";*)  //20180514 RCH Ticket 206788
		SET TEXT TO PASTEBOARD:C523($t_tipo3)
		ALERT:C41($t_tipo3)
		
End case 
TRACE:C157


  //CALL WEB SERVICE("http://192.168.0.21:80/dteNet/CargaCAFService";"http://dtenet.colegium.com/CargaCAF/doCargaCAF";"doCargaCAF";"http://dtenet.colegium.com/CargaCAF/";Web Service Manual)
  //WSact_DTECallWebService ("doFoliosDisponibles")

  //If (OK=1)
  //C_BLOB($xx_tipo)
  //C_BLOB($xx_tipo2)
  //C_BLOB($xx_tipo3)
  //GET WEB SERVICE RESULT($xx_tipo;"esadoProcesamiento")
  //
  //$t_ref:=DOM Parse XML variable($xx_tipo)
  //DOM EXPORT TO VAR($t_ref;$t_varXML)
  //If (ok=1)
  //SET TEXT TO PASTEBOARD($t_varXML)
  //End if 
  //DOM CLOSE XML($t_ref)
  //
  //GET WEB SERVICE RESULT($xx_tipo2;"glosaProcesamiento")
  //$t_ref:=DOM Parse XML variable($xx_tipo2)
  //DOM EXPORT TO VAR($t_ref;$t_varXML)
  //If (ok=1)
  //SET TEXT TO PASTEBOARD($t_varXML)
  //End if 
  //DOM CLOSE XML($t_ref)
  //
  //GET WEB SERVICE RESULT($xx_tipo3;"foliosTipo";*)
  //$t_ref:=DOM Parse XML variable($xx_tipo3)
  //DOM EXPORT TO VAR($t_ref;$t_varXML)
  //If (ok=1)
  //SET TEXT TO PASTEBOARD($t_varXML)
  //End if 
  //DOM CLOSE XML($t_ref)
  //
  //GET WEB SERVICE RESULT(vlWS_estado;"esadoProcesamiento")
  //
  //GET WEB SERVICE RESULT(vtWS_glosa;"glosaProcesamiento")
  //SET TEXT TO PASTEBOARD(vtWS_glosa)
  //
  //GET WEB SERVICE RESULT(vtWS_folios;"foliosTipo";*)
  //If (vlWS_estado=0)
  //CD_Dlog (0;vtWS_glosa)
  //End if 
  //End if 
$0:=vlWS_estado
