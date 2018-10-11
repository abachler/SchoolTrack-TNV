vMsg:=""
If (Self:C308->#"")
	  //20121217 RCH Para que no se peguen caracteres extraños...
	ST_LimpiaTexto (Self:C308)
	$oldValue:=[ACT_Terceros:138]Identificador_Nacional3:21
	[ACT_Terceros:138]Identificador_Nacional3:21:=Self:C308->
	If (KRL_RecordExists (->[ACT_Terceros:138]Identificador_Nacional3:21))
		BEEP:C151
		vMsg:=__ ("Error. Ya existe un Tercero con el mismo ")+<>at_IDNacional_Names{3}+"."
		Self:C308->:=$oldValue
		[ACT_Terceros:138]Identificador_Nacional3:21:=$oldValue
		GOTO OBJECT:C206(Self:C308->)
	End if 
End if 