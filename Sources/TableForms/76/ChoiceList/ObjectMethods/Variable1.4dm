
$s:=CD_Request (__ ("Nuevo valor:");__ ("Aceptar");__ ("");__ (""))
If ($s#"")
	If (<>aUFvalues=0)
		INSERT IN ARRAY:C227(<>aUFvalues;Size of array:C274(<>aUFvalues)+1)
		<>aUFvalues:=Size of array:C274(<>aUFvalues)
	Else 
		INSERT IN ARRAY:C227(<>aUFvalues;<>aUFvalues)
	End if 
	<>aUFvalues{<>aUFvalues}:=$s
	BLOB_Variables2Blob (->[xShell_Userfields:76]xListOfValues:9;0;-><>aUFValues)
	SAVE RECORD:C53([xShell_Userfields:76])
	ACCEPT:C269
End if 

