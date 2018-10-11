vMsg:=""
If (Self:C308->#"")
	  //20121217 RCH Para que no se peguen caracteres extraños...
	ST_LimpiaTexto (Self:C308)
	$oldValue:=[ACT_Terceros:138]Codigo_Interno:29
	[ACT_Terceros:138]Codigo_Interno:29:=Self:C308->
	If (KRL_RecordExists (->[ACT_Terceros:138]Codigo_Interno:29))
		BEEP:C151
		vMsg:=__ ("Error. Ya existe un Tercero con el mismo Código Interno.")
		Self:C308->:=$oldValue
		[ACT_Terceros:138]Codigo_Interno:29:=$oldValue
		GOTO OBJECT:C206(Self:C308->)
	End if 
End if 