Case of 
	: (b1=1)
		For ($i;1;Size of array:C274(aSetsDT))
			If (abDoPrint{$i})
				ACTbol_PrintBoletasVR (aSetsDT{$i};True:C214;alIDDT{$i};False:C215;False:C215;aDesdeDT{$i})
				SET_ClearSets (aSetsDT{$i})
			End if 
		End for 
	: (b2=1)
		For ($i;1;Size of array:C274(aSetsDT))
			If (abDoPrint{$i})
				ACTbol_PrintBoletasVR (aSetsDT{$i};True:C214;alIDDT{$i};True:C214;False:C215;aDesdeDT{$i})
				SET_ClearSets (aSetsDT{$i})
			End if 
		End for 
	: (b3=1)
		
End case 