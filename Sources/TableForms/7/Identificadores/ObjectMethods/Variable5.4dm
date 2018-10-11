vMsg:=""
If (Self:C308->#"")
	$oldValue:=[Personas:7]Codigo_interno:22
	[Personas:7]Codigo_interno:22:=Self:C308->
	If (KRL_RecordExists (->[Personas:7]Codigo_interno:22))
		BEEP:C151
		vMsg:=__ ("Error. Ya existe una relacion familiar con el mismo código interno.")
		Self:C308->:=$oldValue
		[Personas:7]Codigo_interno:22:=$oldValue
		GOTO OBJECT:C206(Self:C308->)
	End if 
End if 