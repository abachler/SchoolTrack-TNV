If (sUFValue#"")
	If (<>aUFvalues=0)
		INSERT IN ARRAY:C227(<>aUFvalues;Size of array:C274(<>aUFvalues)+1)
		INSERT IN ARRAY:C227(<>aUFOcc;Size of array:C274(<>aUFvalues)+1)
		<>aUFvalues{Size of array:C274(<>aUFOcc)}:=sUFvalue
		<>aUFvalues:=0
	Else 
		<>aUFvalues{<>aUFvalues}:=sUFValue
		<>aUFvalues:=0
	End if 
	sUFvalue:=""
	[xShell_Userfields:76]UserFieldName:1:=[xShell_Userfields:76]UserFieldName:1
End if 