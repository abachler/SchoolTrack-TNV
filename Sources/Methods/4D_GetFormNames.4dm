//%attributes = {}
  // (PM) 4D_GetFormNames
  // This method fills an array with the form names of the specified table
  // $1 = Table pointer
  // $2 = Pointer to an array to hold the form names

C_POINTER:C301($1;$2;$vp_Table;$vp_Array)
C_LONGINT:C283($i;$vl_ResID;$vl_Error;$vl_Count;$vl_Start;$vl_Offset;$vl_RecordLength)
C_BLOB:C604($vx_ResData)

$vp_Table:=$1
$vp_Array:=$2
$vl_RecordLength:=282

$vl_ResID:=4D_FindTF4DResource ($vp_Table)

If ($vl_ResID#0)
	$vl_Error:=API Get Resource ("TF4D";$vl_ResID;$vx_ResData)
	
	If ($vl_Error=0)
		$vl_Offset:=0
		$vl_Count:=BLOB to longint:C551($vx_ResData;Native byte ordering:K22:1;$vl_Offset)
		
		
		$vl_Start:=12
		For ($i;1;$vl_Count)
			$vl_Offset:=$vl_Start
			APPEND TO ARRAY:C911($vp_Array->;BLOB to text:C555($vx_ResData;Mac Pascal string:K22:8;$vl_Offset))
			$vl_Start:=$vl_Start+$vl_RecordLength
		End for 
	End if 
	
End if 

SORT ARRAY:C229($vp_Array->)