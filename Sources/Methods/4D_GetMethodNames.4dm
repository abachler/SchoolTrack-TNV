//%attributes = {}
  // (PM) 4D_GetMethodNames
  // This method fills an array with the names of all the project methods
  // $1 = Pointer to an array to hold the method names

C_POINTER:C301($1;$vp_Array)
C_BLOB:C604($vx_Data)
C_LONGINT:C283($i;$vl_Error;$vl_RecordLength;$vl_Count;$vl_Start;$vl_Offset)

$vp_Array:=$1
$vl_RecordLength:=76
$vl_Error:=API Get Resource ("TP4D";0;$vx_Data)

If ($vl_Error=0)
	
	$vl_Count:=BLOB size:C605($vx_Data)\$vl_RecordLength
	
	AT_RedimArrays ($vl_Count;$vp_Array)
	
	$vl_Start:=8
	For ($i;1;$vl_Count)
		$vl_Offset:=$vl_Start
		$vp_Array->{$i}:=BLOB to text:C555($vx_Data;Mac Pascal string:K22:8;$vl_Offset)
		$vl_Start:=$vl_Start+$vl_RecordLength
	End for 
	
End if 

SORT ARRAY:C229($vp_Array->)