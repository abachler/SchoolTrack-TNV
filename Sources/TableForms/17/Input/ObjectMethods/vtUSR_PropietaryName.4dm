IT_Clairvoyance (Self:C308;-><>atUSR_UserNames)
If ((Form event:C388=On Losing Focus:K2:8) | (Form event:C388=On Data Change:K2:15))
	$el:=Find in array:C230(<>atUSR_UserNames;Self:C308->)
	If ($el>0)
		[xShell_UserGroups:17]Propietary:3:=<>alUSR_UserIds{$el}
	Else 
		[xShell_UserGroups:17]Propietary:3:=0
		[xShell_UserGroups:17]PropietaryName:9:=""
		GOTO OBJECT:C206([xShell_UserGroups:17]PropietaryName:9)
		BEEP:C151
	End if 
End if 