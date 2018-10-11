//%attributes = {}
  //4D_GetMethodTextBlob_By_CC4D_ID

C_TEXT:C284($vt_MethodText;$vt_LineText)
C_LONGINT:C283($vl_MethodID;$vl_ResID;$vl_Error;$vl_Offset;$1)
C_LONGINT:C283($vl_MethodSize;$vl_LineSize;$vl_LogicalLineSize;$vl_LineNum)
C_BLOB:C604($vx_Resource;$vx_LineTokens)
C_BLOB:C604($blobText;$0)
C_LONGINT:C283($apiRef)
$vl_ResID:=$1

If (Count parameters:C259=2)
	$apiRef:=$2
Else 
	$apiRef:=0
End if 


If ($vl_ResID#0)
	
	  // Get the resource data
	$vl_Error:=API Get Resource ("CC4D";$vl_ResID;$vx_Resource;$apiRef)
	If ($vl_Error=0)
		
		$vl_MethodSize:=BLOB size:C605($vx_Resource)-13
		$vl_Offset:=10
		$vl_LineNum:=0  // just for fun
		
		While ($vl_Offset<$vl_MethodSize)
			$vl_LineNum:=$vl_LineNum+1
			$vl_LineSize:=BLOB to integer:C549($vx_Resource;Native byte ordering:K22:1;$vl_Offset)
			$vl_Offset:=$vl_Offset+2
			$vl_LogicalLineSize:=BLOB to integer:C549($vx_Resource;Native byte ordering:K22:1;$vl_Offset)
			$vl_Offset:=$vl_Offset-4
			COPY BLOB:C558($vx_Resource;$vx_LineTokens;$vl_Offset;0;$vl_LineSize)
			$vl_Offset:=$vl_Offset+$vl_LineSize
			
			Case of 
				: ($vl_LogicalLineSize<2)
					  //$vt_MethodText:=$vt_MethodText+Char(Carriage return )
					TEXT TO BLOB:C554("\r";$blobText;Mac text without length:K22:10;*)
				Else 
					$vl_Error:=API Detokenize ($vx_LineTokens;$vt_LineText)
					If ($vl_Error#0)
						$vl_Offset:=$vl_MethodSize  // bail out on error
					Else 
						  //$vt_MethodText:=$vt_MethodText+$vt_LineText+Char(Carriage return )
						TEXT TO BLOB:C554($vt_LineText+"\r";$blobText;Mac text without length:K22:10;*)
					End if 
			End case 
			
		End while 
		
	End if 
	
End if 

$0:=$blobText