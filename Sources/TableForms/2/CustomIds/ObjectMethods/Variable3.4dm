If (Form event:C388=On Losing Focus:K2:8)
	vMsg:=""
	If (Self:C308->#"")
		  //20121217 RCH Para que no se peguen caracteres extraños...
		ST_LimpiaTexto (Self:C308)
		$oldValue:=[Alumnos:2]IDNacional_3:70
		[Alumnos:2]IDNacional_3:70:=Self:C308->
		If (KRL_RecordExists (->[Alumnos:2]IDNacional_3:70))
			BEEP:C151
			vMsg:=__ ("Error. Ya existe un alumno con el mismo ")+<>at_IDNacional_Names{3}+"."
			Self:C308->:=$oldValue
			[Alumnos:2]IDNacional_3:70:=$oldValue
			GOTO OBJECT:C206(Self:C308->)
		End if 
	End if 
End if 