If (<>aListValues>0)
	If ([xShell_List:39]DefaultValues:10="")
		[xShell_List:39]DefaultValues:10:=<>aListValues{<>aListValues}
	Else 
		[xShell_List:39]DefaultValues:10:=[xShell_List:39]DefaultValues:10+"\r"+<>aListValues{<>aListValues}
	End if 
End if 