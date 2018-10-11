C_TEXT:C284($string)
C_LONGINT:C283($table;$field)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		
		
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($source;$sourceElement;$srcProcess)
		RESOLVE POINTER:C394($source;$sourceVarName;$table;$field)
		If ($sourceVarName="lbElectivas")
			$string:=aPEAsgName{aPEAsgName}
			
			
			If (Find in array:C230(aPCAsgName;$string)=-1)
				$insertAt:=Drop position:C608
				If ($insertAt=-1)
					$insertAt:=Size of array:C274(aPCAsgName)+1
				End if 
				
				INSERT IN ARRAY:C227(aPCAsgName;$insertAt)
				INSERT IN ARRAY:C227(aPCAsgPos;$insertAt)
				aPCAsgName{$insertAt}:=$string
				
				If (Not:C34(Shift down:C543))
					DELETE FROM ARRAY:C228(aPEAsgName;$sourceElement)
					DELETE FROM ARRAY:C228(aPEAsgPos;$sourceElement)
				End if 
				
				For ($i;1;Size of array:C274(aPCAsgName))
					aPCAsgPos{$i}:=$i
				End for 
				
				For ($i;1;Size of array:C274(aPEAsgName))
					aPEAsgPos{$i}:=$i
				End for 
				
			Else 
				
				BEEP:C151
			End if 
			
		Else 
			
			$string:=aPCAsgName{aPCAsgName}
			DELETE FROM ARRAY:C228(aPCAsgName;$sourceElement)
			DELETE FROM ARRAY:C228(aPCAsgPos;$sourceElement)
			$insertAt:=Drop position:C608
			If ($insertAt=-1)
				$insertAt:=Size of array:C274(aPCAsgName)+1
			End if 
			
			INSERT IN ARRAY:C227(aPCAsgName;$insertAt)
			aPCAsgName{$insertAt}:=$string
			
			For ($i;1;Size of array:C274(aPCAsgName))
				aPCAsgPos{$i}:=$i
			End for 
		End if 
		
End case 