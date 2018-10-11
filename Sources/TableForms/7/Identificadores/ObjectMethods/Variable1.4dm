
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vMsg:=""
	: (Form event:C388=On Data Change:K2:15)
		$oldRUT:=[Personas:7]RUT:6
		vMsg:=""
		Case of 
			: ((<>vtXS_CountryCode="cl") | (<>vtXS_CountryCode="uy"))  //20170611 RCH
				If (Self:C308->#"")
					[Personas:7]RUT:6:=ST_Uppercase (Self:C308->)
					If ([Personas:7]RUT:6#"")
						[Personas:7]RUT:6:=CTRY_CL_VerifRUT ([Personas:7]RUT:6;False:C215)
						If ([Personas:7]RUT:6#"")
							If (KRL_RecordExists (->[Personas:7]RUT:6))
								BEEP:C151
								vMsg:=__ ("Error: Ya existe una relación familiar con ")+<>at_IDNacional_Names{1}+" "+Self:C308->+"."
								OK:=0
								[Personas:7]RUT:6:=$oldRUT
								Self:C308->:=$oldRUT
								GOTO OBJECT:C206(Self:C308->)
							Else 
								Self:C308->:=[Personas:7]RUT:6
							End if 
						Else 
							[Personas:7]RUT:6:=$oldRUT
							Self:C308->:=$oldRUT
							GOTO OBJECT:C206(Self:C308->)
							vMsg:=<>at_IDNacional_Names{1}+__ (" incorrecto.")
						End if 
					Else 
						  //SET FORMAT(Self->;"")
					End if 
				End if 
			Else 
				If (KRL_RecordExists (->[Personas:7]RUT:6))
					BEEP:C151
					vMsg:=__ ("Error: Ya existe una relación familiar con ")+<>at_IDNacional_Names{1}+" "+Self:C308->+"."
					OK:=0
					[Personas:7]RUT:6:=$oldRUT
					Self:C308->:=$oldRUT
					GOTO OBJECT:C206(Self:C308->)
				Else 
					Self:C308->:=ST_Uppercase (Self:C308->)
				End if 
		End case 
End case 