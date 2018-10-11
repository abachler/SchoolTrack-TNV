//%attributes = {}
  //TBL_SetListApparence

ARRAY TEXT:C222(at_g1;0)
AT_Text2Array (->at_g1;[xShell_List:39]DefaultValues:10;"\r")
If (Size of array:C274(at_g1)>0)
	For ($i;1;Size of array:C274(at_g1))
		$pos:=Find in array:C230(sElements;at_g1{$i})
		If ($pos>0)
			AL_SetRowStyle (xALP_Tables;$pos;2)
		End if 
	End for 
End if 

AL_UpdateArrays (xALP_Tables;-2)