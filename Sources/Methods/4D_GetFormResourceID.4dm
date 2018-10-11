//%attributes = {}
  //4D_GetFormResourceID

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
  //
C_LONGINT:C283($0)
C_LONGINT:C283($1;$tableNum)
C_TEXT:C284($2;$formName)

  //--- copy parameters to locals
$tableNum:=$1
$formName:=$2
$0:=0
  //--- locals
C_LONGINT:C283($i;$vl_ResID;$vl_Error;$vl_Count;$vl_Start;$vl_Offset;$vl_RecordLength)

  //--- code
$vl_RecordLength:=282
If ($tableNum=0)
	$vl_ResID:=1
Else 
	$vl_ResID:=4D_FindTF4DResource (Table:C252($tableNum))
End if 

If ($vl_ResID#0)
	$vl_Error:=API Get Resource ("TF4D";$vl_ResID;$vx_ResData)
	
	If ($vl_Error=0)
		$vl_Offset:=0
		$vl_Count:=BLOB to integer:C549($vx_ResData;Native byte ordering:K22:1;$vl_Offset)
		
		$vl_Start:=12
		For ($i;1;$vl_Count)
			$vl_Offset:=$vl_Start
			If ($formName=BLOB to text:C555($vx_ResData;Mac Pascal string:K22:8;$vl_Offset))
				$vl_Offset:=$vl_Start+32
				$0:=BLOB to integer:C549($vx_ResData;Native byte ordering:K22:1;$vl_Offset)
				$i:=$vl_Count+1
			End if 
			$vl_Start:=$vl_Start+$vl_RecordLength
		End for 
	End if 
	
End if 
