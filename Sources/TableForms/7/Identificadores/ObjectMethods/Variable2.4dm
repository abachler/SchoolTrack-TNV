
vMsg:=""
If (Self:C308->#"")
	$oldValue:=[Personas:7]IDNacional_2:37
	[Personas:7]IDNacional_2:37:=Self:C308->
	If (KRL_RecordExists (->[Personas:7]IDNacional_2:37))
		BEEP:C151
		vMsg:=__ ("Error. Ya existe una relación familiar con el mismo ")+<>at_IDNacional_Names{2}+"."
		Self:C308->:=$oldValue
		[Personas:7]IDNacional_2:37:=$oldValue
		GOTO OBJECT:C206(Self:C308->)
	End if 
End if 