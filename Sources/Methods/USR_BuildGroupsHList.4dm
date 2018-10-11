//%attributes = {}
  //USR_BuildGroupsHList

$hlRef:=New list:C375
  //AT_Array2ReferencedList (-><>atUSR_GroupNames;-><>alUSR_GroupIds;$hlRef)
For ($i;1;Size of array:C274(<>atUSR_GroupNames))
	APPEND TO LIST:C376($hlRef;<>atUSR_GroupNames{$i};<>alUSR_GroupIds{$i})
End for 
$0:=$hlRef