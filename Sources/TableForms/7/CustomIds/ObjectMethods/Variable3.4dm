  //vMsg:=""
  //If (Self->#"")
  //  //20121217 RCH Para que no se peguen caracteres extraños...
  //ST_LimpiaTexto (Self)
  //$oldValue:=[Personas]IDNacional_3
  //[Personas]IDNacional_3:=Self->
  //If (KRL_RecordExists (->[Personas]IDNacional_3))
  //BEEP
  //vMsg:="Error. Ya existe una persona con el mismo "+<>at_IDNacional_Names{3}+"."
  //Self->:=$oldValue
  //[Personas]IDNacional_3:=$oldValue
  //GOTO OBJECT(Self->)
  //End if 
  //End if 

  // ASM 20130816 ticket 124346
vMsg:=""
Case of 
	: (Form event:C388=On Data Change:K2:15)
		ST_LimpiaTexto (Self:C308)
		$oldValue:=[Personas:7]IDNacional_3:38
		[Personas:7]IDNacional_3:38:=Self:C308->
		If ([Personas:7]IDNacional_3:38#"")
			If (KRL_RecordExists (->[Personas:7]IDNacional_3:38))
				BEEP:C151
				vMsg:="Error. Ya existe una persona con el mismo "+<>at_IDNacional_Names{3}+"."
				Self:C308->:=$oldValue
				[Personas:7]IDNacional_3:38:=$oldValue
				GOTO OBJECT:C206(Self:C308->)
			End if 
		End if 
End case 