//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 17:01:44
  // ----------------------------------------------------
  // Método: STWA2_OWC_dashboards
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

C_REAL:C285($real)
$userID:=STWA2_Session_GetUserSTID ($uuid)
$dash:="-1"
If (Not:C34(USR_IsGroupMember_by_GrpID (-15001;$userID)))
	USR_GetUserProperties ($userID;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
	For ($i;1;Size of array:C274(alUSR_Membership))
		$groupID:=alUSR_Membership{$i}
		USR_GetGroupAppSpecificData ($groupID;"dashboards";->$real)
		If ($real=1)
			$i:=Size of array:C274(alUSR_Membership)+1
			$dash:="0"
		End if 
	End for 
Else 
	$dash:="0"
End if 
If ($dash="0")
	$dato:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dato")
	$json:=STWA2_Dashboards ($dato;$y_ParameterNames;$y_ParameterValues)
Else 
	$json:=STWA2_JSON_SendError (-110000)
End if 


$0:=$json