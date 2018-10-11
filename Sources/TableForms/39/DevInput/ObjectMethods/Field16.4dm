If ([xShell_List:39]DefaultValues:10#"")
	ARRAY TEXT:C222($tempTextArray;0)
	AT_Text2Array (->$tempTextArray;[xShell_List:39]DefaultValues:10;"\r")
	For ($i;1;Size of array:C274($tempTextArray))
		If (Find in array:C230(<>aListValues;$tempTextArray{$i})=-1)
			AT_Insert (1;1;-><>aListValues)
			<>aListValues{1}:=$tempTextArray{$i}
		End if 
	End for 
	BLOB_Variables2Blob (->[xShell_List:39]Contents:9;0;-><>aListValues)
End if 
