//%attributes = {}
  //USR_GetModuleAcces

C_TEXT:C284($module;$module2check;$1)
$module2check:=$1
  //If ((Find in array(<>atUSR_AuthModules;$module)>0) | (<>lUSR_CurrentUserID<0))
  //$0:=True
  //Else 
  //$0:=False
  //End if 

  //20131210 JHB Modificacion para poder preguntar por un usuario cualquiera

ARRAY TEXT:C222($atUSR_AuthModules;0)

$userID:=<>lUSR_CurrentUserID
COPY ARRAY:C226(<>alUSR_GroupIds;alUSR_Membership)
If (Count parameters:C259=2)
	$userID:=$2
	USR_GetUserProperties ($userID;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
End if 
If ($userID>=0)
	For ($i_groups;1;Size of array:C274(alUSR_Membership))
		QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]IDGroup:1=alUSR_Membership{$i_groups})
		If (Records in selection:C76([xShell_UserGroups:17])=1)
			ARRAY TEXT:C222(at_g2;0)
			BLOB_Blob2Vars (->[xShell_UserGroups:17]Modules:11;0;->at_g2)
			For ($i;1;Size of array:C274(at_g2))
				$module:=at_g2{$i}
				$pos:=Find in array:C230($atUSR_AuthModules;$module)
				If ($pos<0)
					APPEND TO ARRAY:C911($atUSR_AuthModules;$module)
				End if 
			End for 
		End if 
	End for 
	
	If (Find in array:C230($atUSR_AuthModules;$module2check)>0)
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
Else 
	$0:=True:C214
End if 