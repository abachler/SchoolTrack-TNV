vMsg:=""
If (Self:C308->#"")
	$oldValue:=[Profesores:4]Codigo_interno:30
	[Profesores:4]Codigo_interno:30:=Self:C308->
	If (KRL_RecordExists (->[Profesores:4]Codigo_interno:30))
		BEEP:C151
		vMsg:="Error. Ya existe un profesor con el mismo Código Interno."
		Self:C308->:=$oldValue
		[Profesores:4]Codigo_interno:30:=$oldValue
		GOTO OBJECT:C206(Self:C308->)
	End if 
End if 