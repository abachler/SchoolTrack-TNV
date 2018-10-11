
vMsg:=""
If (Self:C308->#"")
	$oldValue:=[Personas:7]IDNacional_3:38
	[Personas:7]IDNacional_3:38:=Self:C308->
	If (KRL_RecordExists (->[Personas:7]IDNacional_3:38))
		BEEP:C151
		vMsg:=__ ("Error. Ya existe una relación familiar con el mismo ")+<>at_IDNacional_Names{3}+"."
		Self:C308->:=$oldValue
		[Personas:7]IDNacional_3:38:=$oldValue
		GOTO OBJECT:C206(Self:C308->)
	End if 
End if 