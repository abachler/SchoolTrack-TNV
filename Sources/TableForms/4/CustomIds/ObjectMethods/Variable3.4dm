vMsg:=""
If (Self:C308->#"")
	$oldValue:=[Profesores:4]IDNacional_3:43
	[Profesores:4]IDNacional_3:43:=Self:C308->
	If (KRL_RecordExists (->[Profesores:4]IDNacional_3:43))
		BEEP:C151
		vMsg:="Error. Ya existe un profesor con el mismo "+<>at_IDNacional_Names{3}+"."
		Self:C308->:=$oldValue
		[Profesores:4]IDNacional_3:43:=$oldValue
		GOTO OBJECT:C206(Self:C308->)
	End if 
End if 