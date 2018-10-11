//%attributes = {}
  // (PM) 4D_FindFI4DResource
  // This method finds the FI4D resource for the specified table.
  // This resource contains some information about the table definition and the
  // TF4D resource (list of forms)
  // $1 = Pointer to a table or subtable
  // $0 = Resource ID

C_POINTER:C301($1;$vp_Table)
C_LONGINT:C283($0;$vl_ResID;$vl_TableNr;$vl_FieldNr;$vl_Error;$vl_Count;$vl_Offset)
C_BLOB:C604($vx_ResData)
C_BOOLEAN:C305($vb_IsSubTable)

$vp_Table:=$1
$vl_TableNr:=Table:C252($vp_Table)
$vl_FieldNr:=Field:C253($vp_Table)
$vb_IsSubTable:=False:C215
$vl_ResID:=0

  // Test if we are looking for a subtable
If ($vl_FieldNr>0)
	If (Type:C295($vp_Table->)=Is subtable:K8:11)
		$vb_IsSubTable:=True:C214
	End if 
End if 

  // Get all the ID's of the FI4D resources
ARRAY LONGINT:C221($al_ResIDs;0)
$vl_Error:=API Get Resource ID List ("FI4D";$al_ResIDs)

  // Loop through all the resources
For ($vl_Count;1;Size of array:C274($al_ResIDs))
	
	  // Get the resource data
	$vl_Error:=API Get Resource ("FI4D";$al_ResIDs{$vl_Count};$vx_ResData)
	If ($vl_Error=0)
		
		  // Check if the resource belongs to the table we are looking for
		$vl_Offset:=6
		If (BLOB to integer:C549($vx_ResData;Native byte ordering:K22:1;$vl_Offset)=$vl_TableNr)
			$vl_ResID:=$al_ResIDs{$vl_Count}
			
			If ($vb_IsSubTable)
				  // If it is a subtable we have to look for the resource ID of the subtable        
				$vl_Offset:=30  // Header size for the table definition
				$vl_Offset:=$vl_Offset+(66*($vl_FieldNr-1))  // Record size for each field definition
				$vl_Offset:=$vl_Offset+48  // Offset for the resource ID of the subtable definition
				$vl_ResID:=BLOB to integer:C549($vx_ResData;Native byte ordering:K22:1;$vl_Offset)
			End if 
			
			$vl_Count:=Size of array:C274($al_ResIDs)
		End if 
	End if 
	
End for 

$0:=$vl_ResID