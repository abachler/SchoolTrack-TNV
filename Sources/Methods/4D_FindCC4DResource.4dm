//%attributes = {}
  // (PM) 4D_FindCC4DResource
  // This method returns the ID of the CC4D resource for the specified
  // project method. This resource contains a tokenized version of the
  // program code of the project method.
  // $1 = Method name
  // $0 = Resource ID

_O_C_STRING:C293(40;$vs40_MethodName;$vs40_CurrentMethodName)
C_LONGINT:C283($0;$vl_ResID;$i;$vl_Error;$vl_RecordLength;$vl_Count;$vl_Start;$vl_Offset)
C_BLOB:C604($vx_Data)

$vs40_MethodName:=$1
$vl_RecordLength:=76
$vl_ResID:=0

  // Get the list of project methods
$vl_Error:=API Get Resource ("TP4D";0;$vx_Data)

If ($vl_Error=0)
	
	  // Get the number of methods
	$vl_Count:=BLOB size:C605($vx_Data)\$vl_RecordLength
	
	$vl_Start:=8
	  //$vl_Offset:=8
	For ($i;1;$vl_Count)
		
		  // Get the current method name
		$vl_Offset:=$vl_Start
		$vs40_CurrentMethodName:=BLOB to text:C555($vx_Data;Mac Pascal string:K22:8;$vl_Offset)
		
		  // If we found the requested methodname
		If ($vs40_CurrentMethodName=$vs40_MethodName)
			  // Get the ID of the corresponding CC4D resource and jump out of the loop      
			$vl_Offset:=$vl_Start+32
			$vl_ResID:=BLOB to integer:C549($vx_Data;Native byte ordering:K22:1;$vl_Offset)
			$i:=$vl_Count
		End if 
		
		$vl_Start:=$vl_Start+$vl_RecordLength
		  //$vl_Start:=$vl_Start+1
		
	End for 
	
End if 

$0:=$vl_ResID