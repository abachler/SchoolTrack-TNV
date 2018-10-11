
  //vMsg:=""
  //If (Self->#"")
  //  //20121217 RCH Para que no se peguen caracteres extraños...
  //ST_LimpiaTexto (Self)
  //$oldValue:=[Personas]Codigo_interno
  //[Personas]Codigo_interno:=Self->
  //If (KRL_RecordExists (->[Personas]Codigo_interno))
  //BEEP
  //vMsg:="Error. Ya existe una persona con el mismo Código Interno."
  //Self->:=$oldValue
  //[Personas]Codigo_interno:=$oldValue
  //GOTO OBJECT(Self->)
  //End if 
  //End if 

  // ASM 20130816 ticket 124346
vMsg:=""
Case of 
	: (Form event:C388=On Data Change:K2:15)
		ST_LimpiaTexto (Self:C308)
		$oldValue:=[Personas:7]Codigo_interno:22
		[Personas:7]Codigo_interno:22:=Self:C308->
		If ([Personas:7]Codigo_interno:22#"")
			If (KRL_RecordExists (->[Personas:7]Codigo_interno:22))
				BEEP:C151
				vMsg:="Error. Ya existe una persona con el mismo Código Interno."
				Self:C308->:=$oldValue
				[Personas:7]Codigo_interno:22:=$oldValue
				GOTO OBJECT:C206(Self:C308->)
			End if 
		End if 
End case 