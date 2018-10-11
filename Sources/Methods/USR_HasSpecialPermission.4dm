//%attributes = {}
  //USR_HasSpecialPermission

C_TEXT:C284($1;$2;$reference;$method)
C_LONGINT:C283($3;$userID)
C_BOOLEAN:C305($0;$authorized)
$reference:=$1
$method:=$2
$userID:=<>lUSR_CurrentUserID
If (Count parameters:C259=3)
	$userID:=$3
End if 

READ ONLY:C145([xShell_SpecialPermissions:119])
Case of 
	: (($reference#"") & ($method#""))
		QUERY:C277([xShell_SpecialPermissions:119];[xShell_SpecialPermissions:119]Reference:1=$reference;*)
		QUERY:C277([xShell_SpecialPermissions:119]; & ;[xShell_SpecialPermissions:119]MethodName:2=$method)
		If (Records in selection:C76([xShell_SpecialPermissions:119])=0)
			QUERY:C277([xShell_SpecialPermissions:119];[xShell_SpecialPermissions:119]MethodName:2=$method)
		End if 
	: (($reference="") & ($method#""))
		QUERY:C277([xShell_SpecialPermissions:119];[xShell_SpecialPermissions:119]MethodName:2=$method)
	: (($reference#"") & ($method=""))
		QUERY:C277([xShell_SpecialPermissions:119];[xShell_SpecialPermissions:119]Reference:1=$reference)
End case 
Case of 
	: (Records in selection:C76([xShell_SpecialPermissions:119])>1)
		CD_Dlog (0;__ ("Error. Hay más de un registro de permisos especiales.\r\rLos permisos especiales no pueden ser utilizados."))
	: (Records in selection:C76([xShell_SpecialPermissions:119])=1)
		$hlUsers:=BLOB to list:C557([xShell_SpecialPermissions:119]Users:4)
		$UserName:=HL_FindInListByReference ($hlUsers;$userID)
		If ($userName="")
			If (BLOB size:C605([xShell_SpecialPermissions:119]Groups:3)>0)
				$hlGroups:=BLOB to list:C557([xShell_SpecialPermissions:119]Groups:3)
			End if 
			For ($i;1;Count list items:C380($hlGroups))
				GET LIST ITEM:C378($hlGroups;$i;$groupID;$groupName)
				If (USR_IsGroupMember_by_GrpID ($groupID;$userID))
					$authorized:=True:C214
					$i:=Count list items:C380($hlGroups)+1
				End if 
			End for 
		Else 
			$authorized:=True:C214
		End if 
	Else 
		$authorized:=False:C215
End case 

$0:=$authorized
