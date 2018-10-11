C_LONGINT:C283($table;$field)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		
		
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($source;$sourceElement;$srcProcess)
		RESOLVE POINTER:C394($source;$sourceVarName;$table;$field)
		
		If ($sourceVarName="lbObligatorias")
			$string:=aPCAsgName{aPCAsgName}
			
			
			If (Find in array:C230(aPEAsgName;$string)=-1)
				$insertAt:=Drop position:C608
				If ($insertAt=-1)
					$insertAt:=Size of array:C274(aPEAsgName)+1
				End if 
				
				INSERT IN ARRAY:C227(aPEAsgName;$insertAt)
				INSERT IN ARRAY:C227(aPEAsgPos;$insertAt)
				aPEAsgName{$insertAt}:=$string
				
				If (Not:C34(Shift down:C543))
					DELETE FROM ARRAY:C228(aPCAsgName;$sourceElement)
					DELETE FROM ARRAY:C228(aPCAsgPos;$sourceElement)
				End if 
				
				For ($i;1;Size of array:C274(aPEAsgName))
					aPEAsgPos{$i}:=$i
				End for 
				
				For ($i;1;Size of array:C274(aPCAsgName))
					aPCAsgPos{$i}:=$i
				End for 
			Else 
				
				BEEP:C151
			End if 
			
		Else 
			
			
			$string:=aPEAsgName{aPEAsgName}
			DELETE FROM ARRAY:C228(aPEAsgName;$sourceElement)
			
			$insertAt:=Drop position:C608
			If ($insertAt=-1)
				$insertAt:=Size of array:C274(aPEAsgName)+1
			End if 
			
			INSERT IN ARRAY:C227(aPEAsgName;$insertAt)
			aPEAsgName{$insertAt}:=$string
			
			For ($i;1;Size of array:C274(aPEAsgName))
				aPEAsgPos{$i}:=$i
			End for 
			
		End if 
End case 