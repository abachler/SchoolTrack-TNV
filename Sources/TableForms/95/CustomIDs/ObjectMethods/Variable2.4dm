
vMsg:=""
If (Self:C308->#"")
	$oldValue:=[ADT_Contactos:95]IDNacional_2:14
	[ADT_Contactos:95]IDNacional_2:14:=Self:C308->
	If (KRL_RecordExists (->[ADT_Contactos:95]IDNacional_2:14))
		BEEP:C151
		vMsg:="Error. Ya existe un contacto con el mismo "+<>at_IDNacional_Names{2}+"."
		Self:C308->:=$oldValue
		[ADT_Contactos:95]IDNacional_2:14:=$oldValue
		GOTO OBJECT:C206(Self:C308->)
	End if 
End if 