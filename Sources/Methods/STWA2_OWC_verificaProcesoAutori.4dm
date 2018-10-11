//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 12-07-16, 18:20:04
  // ----------------------------------------------------
  // Método: STWA2_OWC_verificaProcesoAutori
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


ARRAY TEXT:C222($aAuthMethodsAlias;0)
ARRAY TEXT:C222($aAuthMethodsNames;0)
ARRAY LONGINT:C221($tempLongArray;0)
$userID:=$1
$vt_method:=$2
$b_validar:=False:C215

QUERY:C277([xShell_Users:47];[xShell_Users:47]No:1=$userID)
BLOB_Blob2Vars (->[xShell_Users:47]xGroups:18;0;->$tempLongArray)
$isAdmin:=USR_IsGroupMember_by_GrpID (-15001;$userID)
If ($userID<0) | ($isAdmin)
	$b_validar:=True:C214
Else 
	For ($i;1;Size of array:C274($tempLongArray))
		QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]IDGroup:1=$tempLongArray{$i})
		If (BLOB size:C605([xShell_UserGroups:17]xCommands:5)#0)
			BLOB_Blob2Vars (->[xShell_UserGroups:17]xCommands:5;0;->$aAuthMethodsAlias;->$aAuthMethodsNames)
			If (Size of array:C274($aAuthMethodsNames)>0)
				If (Find in array:C230($aAuthMethodsNames;$vt_method)#-1)
					$b_validar:=True:C214
					$i:=Size of array:C274($tempLongArray)+1
				End if 
			End if 
		End if 
	End for 
End if 
$0:=$b_validar