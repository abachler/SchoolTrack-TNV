If (Self:C308->#"")
	If (KRL_RecordExists (Self:C308))
		$ignore:=CD_Dlog (0;__ ("Ya existe una asignatura con el mismo código interno."))
		Self:C308->:=""
		GOTO OBJECT:C206(Self:C308->)
	End if 
End if 