//%attributes = {}
C_TEXT:C284($1;$command)
C_LONGINT:C283($2;$userID)

C_BOOLEAN:C305($0)

$command:=$1
$userID:=$2
USR_GetGroupsLists 
USR_BuildAccesTables 

ARRAY LONGINT:C221(alUSR_Membership;0)

If ($userID<0)
	COPY ARRAY:C226(<>alUSR_GroupIds;alUSR_Membership)
Else 
	USR_GetUserProperties ($userID;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
End if 
ARRAY TEXT:C222($ATUSR_AUTHORIZEDCOMMANDS;0)
ARRAY TEXT:C222($aProcName;0)
READ ONLY:C145([xShell_UserGroups:17])
READ ONLY:C145([xShell_Users:47])
If (Size of array:C274(alUSR_Membership)>0)
	For ($i_groups;1;Size of array:C274(alUSR_Membership))
		QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]IDGroup:1=alUSR_Membership{$i_groups})
		If (Records in selection:C76([xShell_UserGroups:17])=1)
			If (BLOB size:C605([xShell_UserGroups:17]xCommands:5)>0)
				BLOB_Blob2Vars (->[xShell_UserGroups:17]xCommands:5;0;->$aProcName)
				For ($i;1;Size of array:C274($aProcName))
					$methodName:=$aProcName{$i}
					$pos:=Find in array:C230($ATUSR_AUTHORIZEDCOMMANDS;$methodName)
					If ($pos<0)
						$s:=Size of array:C274($ATUSR_AUTHORIZEDCOMMANDS)+1
						AT_Insert ($s;1;->$ATUSR_AUTHORIZEDCOMMANDS)
						$ATUSR_AUTHORIZEDCOMMANDS{$s}:=$methodName
					End if 
				End for 
			End if 
		End if 
	End for 
Else 
	$0:=False:C215
End if 

$el:=Find in array:C230($ATUSR_AUTHORIZEDCOMMANDS;$command)  // el nombre del comando es el alias
If (($el>0) | ($userID<0))
	$0:=True:C214
Else 
	  // el nombre del comando es el nombre del metodo
	$el:=Find in array:C230(<>ATUSR_METHODNAMES;$command)  // se busca el nombre del metodo en la matriz metodos/alias
	If ($el>0)
		$command:=<>atUSR_Commands{$el}  //se cambia el nombre del metodo por el nombre del comando
		$el:=Find in array:C230($ATUSR_AUTHORIZEDCOMMANDS;$command)
		If (($el>0) | ($userID<0))
			$0:=True:C214
		End if 
	End if 
End if 

If ($0=False:C215)
	$0:=USR_HasSpecialPermission ($command;$command;$userID)
End if 