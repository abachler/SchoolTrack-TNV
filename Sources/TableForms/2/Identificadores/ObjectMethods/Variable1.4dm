
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vMsg:=""
	: (Form event:C388=On Data Change:K2:15)
		$oldRUT:=[Alumnos:2]RUT:5
		vMsg:=""
		Case of 
			: ((<>vtXS_CountryCode="cl") | (<>vtXS_CountryCode="uy"))  //20170611 RCH
				If (Self:C308->#"")
					[Alumnos:2]RUT:5:=ST_Uppercase (Self:C308->)
					If ([Alumnos:2]RUT:5#"")
						[Alumnos:2]RUT:5:=CTRY_CL_VerifRUT ([Alumnos:2]RUT:5;False:C215)
						If ([Alumnos:2]RUT:5#"")
							If (KRL_RecordExists (->[Alumnos:2]RUT:5))
								BEEP:C151
								vMsg:=__ ("Error: Ya existe un alumno con ")+<>at_IDNacional_Names{1}+" "+Self:C308->+"."
								OK:=0
								[Alumnos:2]RUT:5:=$oldRUT
								Self:C308->:=$oldRUT
								GOTO OBJECT:C206(Self:C308->)
							Else 
								Self:C308->:=[Alumnos:2]RUT:5
							End if 
						Else 
							[Alumnos:2]RUT:5:=$oldRUT
							Self:C308->:=$oldRUT
							GOTO OBJECT:C206(Self:C308->)
							vMsg:=<>at_IDNacional_Names{1}+__ (" incorrecto.")
						End if 
					Else 
						  //SET FORMAT(Self->;"")
					End if 
				End if 
			Else 
				If (KRL_RecordExists (->[Alumnos:2]RUT:5))
					BEEP:C151
					vMsg:=__ ("Error: Ya existe un alumno con ")+<>at_IDNacional_Names{1}+" "+Self:C308->+"."
					OK:=0
					[Alumnos:2]RUT:5:=$oldRUT
					Self:C308->:=$oldRUT
					GOTO OBJECT:C206(Self:C308->)
				Else 
					Self:C308->:=ST_Uppercase (Self:C308->)
				End if 
		End case 
End case 