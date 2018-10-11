//%attributes = {}
  //4D_GetTableForms


  // ----------------------------------------------------
  // 4D_GetFormResourceID : return form resource ID from name
  //
  // Parameters:
  //     $1: table pointer
  //     $2: form name
  //
  // Return:
  //     $0: FO4D resource ID
  //
  // Assumptions:
  //
  //
  // ----------------------------------------------------
  // User name (OS): julio
  // Date and time: 31/05/06, 11:19:13
  // ----------------------------------------------------
  // (PM) 4D_GetFormNames
  // This method fills an array with the form names of the specified table
  // $1 = Table pointer
  // $2 = Pointer to an array to hold the form names

C_POINTER:C301($1;$2;$vp_Table;$vp_Array)
C_LONGINT:C283($i;$vl_ResID;$vl_Error;$vl_Count;$vl_Start;$vl_Offset;$vl_RecordLength)

$vp_IdsArrayPtr:=$1
$vp_NamesArrayPtr:=$2
$vp_FormIDs:=$3
$vl_RecordLength:=282  // 270

For ($j;1;Get last table number:C254)
	If (Is table number valid:C999($j))
		$vl_ResID:=4D_FindTF4DResource (Table:C252($j))
		
		If ($vl_ResID#0)
			$vl_Error:=API Get Resource ("TF4D";$vl_ResID;$vx_ResData)
			
			If ($vl_Error=0)
				$vl_Offset:=0
				  // $vl_Count:=BLOB vers entier($vx_ResData;Ordre octets natif ;$vl_Offset)
				$vl_Count:=BLOB to longint:C551($vx_ResData;Native byte ordering:K22:1;$vl_Offset)  // ****V11****
				
				  //AT_ResizeArrays (->$vp_Array;$vl_Count)
				
				$vl_Start:=12  // 6  ` ****V11****
				For ($i;1;$vl_Count)
					$vl_Offset:=$vl_Start
					APPEND TO ARRAY:C911($vp_NamesArrayPtr->;BLOB to text:C555($vx_ResData;Mac Pascal string:K22:8;$vl_Offset))
					$vl_Offset:=$vl_Start+32
					$formID:=BLOB to integer:C549($vx_ResData;Native byte ordering:K22:1;$vl_Offset)
					APPEND TO ARRAY:C911($vp_IdsArrayPtr->;$j)
					APPEND TO ARRAY:C911($vp_FormIDs->;$formID)
					$vl_Start:=$vl_Start+$vl_RecordLength
				End for 
			End if 
			
		End if 
	End if 
End for 

$vl_Error:=API Get Resource ("TF4D";1;$vx_ResData)
If ($vl_Error=0)
	$vl_Offset:=0
	  // $vl_Count:=BLOB vers entier($vx_ResData;Ordre octets natif ;$vl_Offset)
	$vl_Count:=BLOB to longint:C551($vx_ResData;Native byte ordering:K22:1;$vl_Offset)  // ****V11****
	
	  //AT_ResizeArrays (->$vp_Array;$vl_Count)
	
	$vl_Start:=12  // 6  ` ****V11****
	For ($i;1;$vl_Count)
		$vl_Offset:=$vl_Start
		$formName:=BLOB to text:C555($vx_ResData;Mac Pascal string:K22:8;$vl_Offset)
		APPEND TO ARRAY:C911($vp_NamesArrayPtr->;$formName)
		$vl_Offset:=$vl_Start+32
		$formID:=BLOB to integer:C549($vx_ResData;Native byte ordering:K22:1;$vl_Offset)
		APPEND TO ARRAY:C911($vp_IdsArrayPtr->;0)
		APPEND TO ARRAY:C911($vp_FormIDs->;$formID)
		$vl_Start:=$vl_Start+$vl_RecordLength
	End for 
End if 
SORT ARRAY:C229($vp_IdsArrayPtr->;$vp_NamesArrayPtr->;$vp_FormIDs->)