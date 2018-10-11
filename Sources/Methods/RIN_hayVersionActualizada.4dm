//%attributes = {}
  // RIN_hayVersionActualizada()
  // Por: Alberto Bachler K.: 15-08-14, 11:55:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($b_HayNuevaVersion)
C_TEXT:C284($t_errorWS;$t_uuid;$t_version)


If (False:C215)
	C_BOOLEAN:C305(RIN_hayVersionActualizada ;$0)
	C_TEXT:C284(RIN_hayVersionActualizada ;$1)
	C_TEXT:C284(RIN_hayVersionActualizada ;$2)
End if 

$t_uuid:=$1
$t_version:=$2


WEB SERVICE SET PARAMETER:C777("uuid";$t_uuid)
WEB SERVICE SET PARAMETER:C777("version";$t_version)

$t_errorWS:=WS_CallIntranetWebService ("RINws_ComparaInforme";True:C214)
If ($t_errorWS="")
	WEB SERVICE GET RESULT:C779($b_HayNuevaVersion;"hayNuevaVersion";*)  //20180514 RCH Ticket 206788
End if 

$0:=$b_HayNuevaVersion

