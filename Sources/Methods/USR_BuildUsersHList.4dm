//%attributes = {}
  //USR_BuildUsersHList

C_BOOLEAN:C305($1;$includeGroups)
C_TEXT:C284($groupName)
C_LONGINT:C283($groupId)
ARRAY LONGINT:C221($aMemberIds;0)
ARRAY TEXT:C222($aMemberNames;0)
C_LONGINT:C283($hlRef)
If (Count parameters:C259=1)
	$includeGroups:=$1
End if 

$hlRef:=New list:C375
If ($includeGroups)
	For ($i_Groups;1;Size of array:C274(<>atUSR_GroupNames))
		$newList:=New list:C375
		USR_GetGroupProperties (<>alUSR_GroupIds{$i_Groups};->$groupName;->$groupId;->$amemberIds)
		AT_ResizeArrays (->$aMemberNames;Size of array:C274($amemberIds))
		For ($i_Members;1;Size of array:C274($amemberIds))
			$name:=USR_GetUserName ($amemberIds{$i_Members})
			If ($name#"")
				APPEND TO LIST:C376($newList;$name;$amemberIds{$i_Members})
			End if 
		End for 
		SORT LIST:C391($newList;>)
		$users:=Count list items:C380($newList)
		APPEND TO LIST:C376($hlRef;$groupName;<>alUSR_GroupIds{$i_Groups};$newList;True:C214)
	End for 
	CLEAR LIST:C377($newList)
Else 
	  //AT_Array2ReferencedList (-><>atUSR_UserNames;-><>alUSR_UserIds;$hlRef)
	For ($i;1;Size of array:C274(<>atUSR_UserNames))
		APPEND TO LIST:C376($hlRef;<>atUSR_UserNames{$i};<>alUSR_UserIds{$i})
	End for 
	SORT LIST:C391($hlRef)
End if 

$0:=$hlRef