
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vMsg:=""
	: (Form event:C388=On Data Change:K2:15)
		$oldRUT:=[ADT_Contactos:95]RUT:11
		vMsg:=""
		Case of 
			: (<>vtXS_CountryCode="cl")
				If (Self:C308->#"")
					[ADT_Contactos:95]RUT:11:=ST_Uppercase (Self:C308->)
					If ([ADT_Contactos:95]RUT:11#"")
						[ADT_Contactos:95]RUT:11:=CTRY_CL_VerifRUT ([ADT_Contactos:95]RUT:11;False:C215)
						If ([ADT_Contactos:95]RUT:11#"")
							If (KRL_RecordExists (->[ADT_Contactos:95]RUT:11))
								BEEP:C151
								vMsg:="Error: Ya existe un contacto con "+<>at_IDNacional_Names{1}+" "+Self:C308->+"."
								OK:=0
								[ADT_Contactos:95]RUT:11:=$oldRUT
								Self:C308->:=$oldRUT
								GOTO OBJECT:C206(Self:C308->)
							Else 
								Self:C308->:=[ADT_Contactos:95]RUT:11
							End if 
						Else 
							[ADT_Contactos:95]RUT:11:=$oldRUT
							Self:C308->:=$oldRUT
							GOTO OBJECT:C206(Self:C308->)
							vMsg:=<>at_IDNacional_Names{1}+" incorrecto."
						End if 
					Else 
						  //SET FORMAT(Self->;"")
					End if 
				End if 
			Else 
				[ADT_Contactos:95]RUT:11:=ST_Uppercase (Self:C308->)
		End case 
End case 