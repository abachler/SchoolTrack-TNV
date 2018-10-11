
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vMsg:=""
	: (Form event:C388=On Data Change:K2:15)
		$oldRUT:=[Profesores:4]RUT:27
		vMsg:=""
		Case of 
			: ((<>vtXS_CountryCode="cl") | (<>vtXS_CountryCode="uy"))  //20170611 RCH
				If (Self:C308->#"")
					[Profesores:4]RUT:27:=ST_Uppercase (Self:C308->)
					If ([Profesores:4]RUT:27#"")
						[Profesores:4]RUT:27:=CTRY_CL_VerifRUT ([Profesores:4]RUT:27;False:C215)
						If ([Profesores:4]RUT:27#"")
							If (KRL_RecordExists (->[Profesores:4]RUT:27))
								BEEP:C151
								vMsg:="Error: Ya existe un profesor con "+<>at_IDNacional_Names{1}+" "+Self:C308->+"."
								OK:=0
								[Profesores:4]RUT:27:=$oldRUT
								Self:C308->:=$oldRUT
								GOTO OBJECT:C206(Self:C308->)
							Else 
								Self:C308->:=[Profesores:4]RUT:27
							End if 
						Else 
							[Profesores:4]RUT:27:=$oldRUT
							Self:C308->:=$oldRUT
							GOTO OBJECT:C206(Self:C308->)
							vMsg:=<>at_IDNacional_Names{1}+" incorrecto."
						End if 
					Else 
						  //SET FORMAT(Self->;"")
					End if 
				End if 
			Else 
				[Profesores:4]RUT:27:=ST_Uppercase (Self:C308->)
		End case 
End case 