//%attributes = {}
  // WSexe_ListaScriptsRemotos_in()
  // Por: Alberto Bachler: 02/05/13, 12:09:17
  //  ---------------------------------------------
  // solicita a la intranet una lista con los scripts activados para ejecución en el colegio
  // 
  //  ---------------------------------------------
C_TEXT:C284($t_rolBD;$t_CodigoPais;$t_TextoError)
C_POINTER:C301($y_IdScripts_AL)
C_BLOB:C604($x_blob)

$t_rolBD:=<>gRolBD
$t_CodigoPais:=<>gCountryCode

$y_IdScripts_AL:=$1


WS_InitWebServicesVariables 
WEB SERVICE SET PARAMETER:C777("codpais";$t_CodigoPais)
WEB SERVICE SET PARAMETER:C777("rol";$t_rolBD)
WEB SERVICE SET PARAMETER:C777("blobIds";$x_blob)
$t_TextoError:=WS_CallIntranetWebService ("WSexe_ListaScriptActivos_out")

If ($t_TextoError="")
	WEB SERVICE GET RESULT:C779($x_blob;"blobIds";*)  //20180514 RCH Ticket 206788
	If (BLOB size:C605($x_blob)>0)
		BLOB_Blob2Vars (->$x_blob;0;$y_IdScripts_AL)
	End if 
End if 

$0:=$t_TextoError



