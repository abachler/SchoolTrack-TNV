
vMsg:=""
If (Self:C308->#"")
	$oldValue:=[Profesores:4]IDNacional_2:42
	[Profesores:4]IDNacional_2:42:=Self:C308->
	If (KRL_RecordExists (->[Profesores:4]IDNacional_2:42))
		BEEP:C151
		vMsg:="Error. Ya existe un profesor con el mismo "+<>at_IDNacional_Names{2}+"."
		Self:C308->:=$oldValue
		[Profesores:4]IDNacional_2:42:=$oldValue
		GOTO OBJECT:C206(Self:C308->)
	End if 
End if 