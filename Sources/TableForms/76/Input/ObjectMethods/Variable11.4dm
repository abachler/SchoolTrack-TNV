IT_MODIFIERS 
$sel:=<>aUFvalues{<>aUFvalues}
If (<>Option)
	SORT ARRAY:C229(<>aUFvalues;<>aUFOcc;<)
Else 
	SORT ARRAY:C229(<>aUFvalues;<>aUFOcc;>)
End if 
key:=0
If (<>aUFvalues#0)
	<>aUFvalues:=Find in array:C230(<>aUFvalues;$sel)
End if 
<>aUFOcc:=<>aUFValues
[xShell_Userfields:76]UserFieldName:1:=[xShell_Userfields:76]UserFieldName:1