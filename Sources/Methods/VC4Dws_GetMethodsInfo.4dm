//%attributes = {"publishedSoap":true,"executedOnServer":true}
  // VC4Dws_GetMethodsInfo()
  // Por: Alberto Bachler K.: 30-09-14, 17:04:06
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($0)
C_BLOB:C604($1)

C_BLOB:C604($x_data;$x_retorno)
C_DATE:C307($d_dateModif)
C_LONGINT:C283($i;$l_currentUserID;$l_error;$l_errorCode;$l_resultado;$l_UserID)
C_TIME:C306($h_timeModif)
C_TEXT:C284($t_currentOnErrCall;$t_dts;$t_error;$t_password;$t_UserName)
C_OBJECT:C1216($ob_Parametros;$ob_retorno)

ARRAY TEXT:C222($at_dts;0)
ARRAY TEXT:C222($at_methodPaths;0)



If (False:C215)
	C_BLOB:C604(VC4Dws_GetMethodsInfo ;$0)
	C_BLOB:C604(VC4Dws_GetMethodsInfo ;$1)
End if 

SOAP DECLARATION:C782($1;Is BLOB:K8:12;SOAP input:K46:1;"data")
SOAP DECLARATION:C782($0;Is BLOB:K8:12;SOAP output:K46:2;"output")



  //TRACE
$x_data:=$1
$l_resultado:=OB_BlobToObject (->$x_data;->$ob_Parametros)
OB_GET ($ob_Parametros;->$t_UserName;"user")
OB_GET ($ob_Parametros;->$t_password;"passw")
OB_GET ($ob_Parametros;->$at_methodPaths;"paths")

$l_currentUserID:=<>lUSR_CurrentUserID
If (USR_IsSuperUser ($t_UserName;$t_password))
	$l_UserID:=<>lUSR_CurrentUserID
	If (($l_UserID>-99) & ($l_UserID<0))
		$t_currentOnErrCall:=Method called on error:C704
		ON ERR CALL:C155("ERR_EventoError")
		For ($i;1;Size of array:C274($at_methodPaths))
			$d_dateModif:=!00-00-00!
			$h_timeModif:=?00:00:00?
			METHOD GET MODIFICATION DATE:C1170($at_methodPaths{$i};$d_dateModif;$h_timeModif;*)
			If ($d_dateModif#!00-00-00!)
				$t_dts:=String:C10($d_dateModif;ISO date:K1:8;$h_timeModif)
			Else 
				$t_dts:=""
			End if 
			APPEND TO ARRAY:C911($at_dts;$t_dts)
		End for 
		ON ERR CALL:C155($t_currentOnErrCall)
	Else 
		$t_error:="user no allowed to integrate code"
		$l_errorCode:=-2
	End if 
Else 
	$t_error:="unknown user"
	$l_errorCode:=-1
End if 
$ob_retorno:=OB_Create 
OB_SET ($ob_retorno;->$t_error;"errorText")
OB_SET ($ob_retorno;->$l_error;"errorCode")
OB_SET ($ob_retorno;->$at_methodPaths;"paths")
OB_SET ($ob_retorno;->$at_dts;"dts")
$l_resultado:=OB_ObjectToBlob (->$ob_retorno;->$x_retorno)

$0:=$x_retorno