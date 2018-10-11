If (Size of array:C274(atACT_MAtrixNameCopy)<=50)
	$choice:=Pop up menu:C542(vt_Matrices)
	If ($choice>2)
		vsACT_AsignedMatrix:=atACT_MatrixNameCopy{$choice-2}
		atACT_MatrixNameCopy:=$choice-2
	Else 
		If ($choice>0)
			vsACT_AsignedMatrix:="Ninguna"
		End if 
	End if 
Else 
	ARRAY POINTER:C280(<>aChoicePtrs;0)
	ARRAY POINTER:C280(<>aChoicePtrs;1)
	<>aChoicePtrs{1}:=->atACTcc_MatrixName
	TBL_ShowChoiceList (1;"Seleccione la Matriz";1;->vsACT_AsignedMatrix)
	If (ok=1)
		vsACT_AsignedMatrix:=atACTcc_MatrixName{choiceIdx}
	End if 
End if 