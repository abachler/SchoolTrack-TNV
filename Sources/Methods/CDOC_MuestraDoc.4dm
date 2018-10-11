//%attributes = {}
  // CDOC_MuestraDoc()
  // Por: Alberto Bachler: 15/04/13, 09:47:20
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_Desde;$l_hasta;$l_procesoWebArea;$l_test)
C_TIME:C306($h_refDocumento)
C_TEXT:C284($t_html;$t_nombreMetodo;$t_rutaDocumento;$t_rutaTemporal;$t_textoError;$t_textoMetodo)

GET MACRO PARAMETER:C997(Highlighted method text:K5:18;$t_nombreMetodo)

If ($t_nombreMetodo="")
	$t_tituloVentana:=Get window title:C450(Frontmost window:C447)
	$t_nombreMetodo:=ST_ClearSpaces (ST_GetWord ($t_tituloVentana;2;":"))
End if 

WEB SERVICE SET PARAMETER:C777("nombreMetodo";$t_nombreMetodo)
$t_textoError:=WS_CallIntranetWebService ("WScdoc_EnviaDocHTML")
$t_html:=""
If ($t_textoError="")
	WEB SERVICE GET RESULT:C779($t_html;"html";*)
	SET TEXT TO PASTEBOARD:C523($t_html)
	If ($t_html#"")
		$l_procesoWebArea:=Process number:C372("$WebArea")
		If ($l_procesoWebArea=0)
			$l_procesoWebArea:=New process:C317("WEB_OpenWebArea";Pila_256K;"$WebArea";$t_rutaDocumento;"Documentación SchoolTrack";False:C215;False:C215;True:C214;$t_html)
		Else 
			RESUME PROCESS:C320($l_procesoWebArea)
			BRING TO FRONT:C326($l_procesoWebArea)
			POST OUTSIDE CALL:C329($l_procesoWebArea)
		End if 
	End if 
End if 



