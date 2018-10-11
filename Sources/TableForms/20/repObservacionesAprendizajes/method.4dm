If (Form event:C388=On Load:K2:1)
	$err:=PL_SetArraysNam (xPL_PrintArea;1;1;"aText1")
	PL_SetWidths (xPL_PrintArea;1;1;550)
	PL_SetHeight (xPL_PrintArea;0;0;0;4)
	PL_SetColOpts (xPL_PrintArea;0;0)
	PL_SetHdrOpts (xPL_PrintArea;0;0)
	PL_SetStyle (xPL_PrintArea;0;"Tahoma";9;0)
	PL_SetFrame (xPL_PrintArea;1;"Black";"Black";0;0.25;"Gray";"Black";0)
	PL_SetDividers (xPL_PrintArea;1;"Black";"Black";0;0.25;"Gray";"Black";0)
	
	For ($i;1;Size of array:C274(aText1))
		If (aLong1{$i}=0)
			PL_SetRowColor (xPL_PrintArea;$i;"";16;"";16*15+2)
			PL_SetRowStyle (xPL_PrintArea;$i;1;"";9)
		Else 
			PL_SetRowColor (xPL_PrintArea;$i;"";16;"";1)
			PL_SetRowStyle (xPL_PrintArea;$i;0;"";7)
		End if 
	End for 
End if 

