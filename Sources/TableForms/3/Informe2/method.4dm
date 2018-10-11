If (Form event:C388=On Printing Detail:K2:18)
	$err:=PL_SetArraysNam (xPL_Dest;1;2;"aDest";"aAvg")
	PL_SetWidths (xPL_Dest;1;2;500;50)
	PL_SetHdrOpts (xPL_Dest;2)
	PL_SetHeight (xPL_Dest;1;1;0;0)
	PL_SetHdrStyle (xPL_Dest;0;"Tahoma";9;1)
	PL_SetStyle (xPL_Dest;0;"Tahoma";9;0)
	PL_SetFormat (xPL_Dest;1;"";1;2)
	PL_SetFormat (xPL_Dest;2;"";2;2)
	PL_SetHeaders (xPL_Dest;1;2;"Alumno";"Promedio")
	PL_SetDividers (xPL_Dest;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFrame (xPL_Dest;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetSort (xPL_Dest;-2)
	
	
	For ($i;1;Size of array:C274(aAvgInsuf))
		aAvgInsuf{$i}:=Replace string:C233(aAvgInsuf{$i};Char:C90(0);"")
	End for 
	
	$err:=PL_SetArraysNam (xPL_Insuf;1;3;"aInsuf";"aAvgInsuf";"aAsgInsuf")
	PL_SetWidths (xPL_Insuf;1;3;200;100;250)
	PL_SetHdrOpts (xPL_Insuf;2)
	PL_SetHeight (xPL_Insuf;1;1;0;10)
	PL_SetHdrStyle (xPL_Insuf;0;"Tahoma";9;1)
	PL_SetStyle (xPL_Insuf;0;"Tahoma";9;0)
	PL_SetFormat (xPL_Insuf;1;"";1;2)
	PL_SetFormat (xPL_Insuf;2;"";2;2)
	PL_SetFormat (xPL_Insuf;3;"";1;2)
	PL_SetHeaders (xPL_Insuf;1;3;"Alumno";"Promedio General";"Promedios insuficientes")
	PL_SetDividers (xPL_Insuf;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetFrame (xPL_Insuf;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
	PL_SetSort (xPL_Insuf;2)
	
End if 
