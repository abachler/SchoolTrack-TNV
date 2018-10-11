//%attributes = {}
  // (PM) 4D_FindTF4DResource
  // This method finds the TF4D resource for the specified table
  // This resource contains information about the forms of a table
  // $1 = Table pointer
  // $0 = Resource ID

C_POINTER:C301($1;$vp_Table)
C_LONGINT:C283($0;$vl_ResID;$vl_TableNr)

$vp_Table:=$1

ARRAY LONGINT:C221($al_ResourceIDs;0)
4D_GetTF4DResourceIDs (->$al_ResourceIDs)

$vl_TableNr:=Table:C252($vp_Table)
If ($vl_TableNr<=Size of array:C274($al_ResourceIDs))
	$vl_ResID:=$al_ResourceIDs{$vl_TableNr}
End if 

$0:=$vl_ResID