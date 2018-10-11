//%attributes = {}
  //4D_SaveMethodText

  // (PM) 4D_SetMethodText
  // This method will set the contents of the specified method
  // It can also be used to create new methods, but you should re-open 
  // the structure file to see the changes applied.
  // With many thanks to Miloslav Bystricky for helping with the code
  // $1 = Method name
  // $2 = Method text

_O_C_STRING:C293(40;$1;$vs40_MethodName)
C_TEXT:C284($2;$vt_MethodText)
C_LONGINT:C283($vl_ResID;$vl_Error;$vl_Offset;$vl_LineNr;$vl_TokenOffset;$vl_TokenSize)
C_BOOLEAN:C305($vb_IsNewMethod)
C_BLOB:C604($vx_Resource;$vx_LineTokens)

$vs40_MethodName:=$1
$vt_MethodText:=$2
$vl_ResID:=0

$vl_ResID:=4D_FindCC4DResource ($vs40_MethodName)
$vb_IsNewMethod:=($vl_ResID=-1)

  // Split the method text into seperate lines
ARRAY TEXT:C222($at_Lines;0)
API Text To Array ($vt_MethodText;Char:C90(Carriage return:K15:38);$at_Lines)

SET BLOB SIZE:C606($vx_Resource;0)
$vl_Offset:=0

INTEGER TO BLOB:C548(100;$vx_Resource;Native byte ordering:K22:1;$vl_Offset)  // Set the window rectangle
INTEGER TO BLOB:C548(100;$vx_Resource;Native byte ordering:K22:1;$vl_Offset)
INTEGER TO BLOB:C548(500;$vx_Resource;Native byte ordering:K22:1;$vl_Offset)
INTEGER TO BLOB:C548(500;$vx_Resource;Native byte ordering:K22:1;$vl_Offset)
INTEGER TO BLOB:C548(-Size of array:C274($at_Lines);$vx_Resource;Native byte ordering:K22:1;$vl_Offset)  // Set the line count (negative for listing)

For ($vl_LineNr;1;Size of array:C274($at_Lines))
	
	  // Tokenize the method line
	$vl_Error:=API Tokenize ($at_Lines{$vl_LineNr};$vx_LineTokens)
	If ($vl_Error#0)  // Bail out of the loop
		$vl_LineNr:=Size of array:C274($at_Lines)
	End if 
	  // Add the tokenized method to the CC4D resource
	$vl_Offset:=BLOB size:C605($vx_Resource)
	
	  // Get logical size of the tokens
	$vl_TokenOffset:=34
	$vl_TokenSize:=BLOB to integer:C549($vx_LineTokens;Native byte ordering:K22:1;$vl_TokenOffset)
	
	  // Add the CC4D token header
	INTEGER TO BLOB:C548($vl_TokenSize+16;$vx_Resource;Native byte ordering:K22:1;$vl_Offset)  // LineSize = $vl_TokenSize + sizeof (header)
	INTEGER TO BLOB:C548(0;$vx_Resource;Native byte ordering:K22:1;$vl_Offset)  // NextLine (only used for flowcharts)
	INTEGER TO BLOB:C548($vl_TokenSize;$vx_Resource;Native byte ordering:K22:1;$vl_Offset)  // Logical line size
	INTEGER TO BLOB:C548(0;$vx_Resource;Native byte ordering:K22:1;$vl_Offset)  // True line (only used for flowcharts)
	INTEGER TO BLOB:C548(0;$vx_Resource;Native byte ordering:K22:1;$vl_Offset)  // Unknown
	INTEGER TO BLOB:C548(0;$vx_Resource;Native byte ordering:K22:1;$vl_Offset)  // Object position (only used for flowcharts)
	INTEGER TO BLOB:C548(0;$vx_Resource;Native byte ordering:K22:1;$vl_Offset)
	INTEGER TO BLOB:C548(0;$vx_Resource;Native byte ordering:K22:1;$vl_Offset)
	INTEGER TO BLOB:C548(0;$vx_Resource;Native byte ordering:K22:1;$vl_Offset)
	COPY BLOB:C558($vx_LineTokens;$vx_Resource;48;$vl_Offset;$vl_TokenSize)  // Tokens
	
End for 

  // Save the modified resource
If ($vl_Error=0)
	$vl_Error:=API Set Resource ("CC4D";$vl_ResID;"";$vx_Resource)
End if 

  // Add the new method to the method list
If ($vb_IsNewMethod & ($vl_Error=0))
	
	$vl_Error:=API Get Resource ("TP4D";0;$vx_Resource)  // Get the list of methods
	If ($vl_Error=0)
		$vl_Offset:=BLOB size:C605($vx_Resource)  // Get the current size
		SET BLOB SIZE:C606($vx_Resource;$vl_Offset+44;0)  // Add a new entry for the new method
		TEXT TO BLOB:C554($vs40_MethodName;$vx_Resource;Mac Pascal string:K22:8;$vl_Offset)  // Insert the method name
		$vl_Offset:=BLOB size:C605($vx_Resource)-44+32
		INTEGER TO BLOB:C548($vl_ResID;$vx_Resource;Native byte ordering:K22:1;$vl_Offset)
		$vl_Error:=API Set Resource ("TP4D";0;"";$vx_Resource)
		
		ALERT:C41("Re-open the structure file to see the changes applied.")
	End if 
	
End if 