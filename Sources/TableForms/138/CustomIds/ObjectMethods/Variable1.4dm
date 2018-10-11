
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vMsg:=""
	: (Form event:C388=On Data Change:K2:15)
		$oldRUT:=[ACT_Terceros:138]RUT:4
		vMsg:=""
		Case of 
				  //: (<>vtXS_CountryCode="cl")
			: ((<>vtXS_CountryCode="cl") | (<>vtXS_CountryCode="uy"))  //20170619 RCH
				If (Self:C308->#"")
					  //20121217 RCH Para que no se peguen caracteres extraños...
					ST_LimpiaTexto (Self:C308)
					[ACT_Terceros:138]RUT:4:=ST_Uppercase (Self:C308->)
					If ([ACT_Terceros:138]RUT:4#"")
						[ACT_Terceros:138]RUT:4:=CTRY_CL_VerifRUT ([ACT_Terceros:138]RUT:4;False:C215)
						If ([ACT_Terceros:138]RUT:4#"")
							If (KRL_RecordExists (->[ACT_Terceros:138]RUT:4))
								BEEP:C151
								vMsg:=__ ("Error: Ya existe un Tercero con el mismo ")+<>at_IDNacional_Names{1}+" "+Self:C308->+"."
								OK:=0
								[ACT_Terceros:138]RUT:4:=$oldRUT
								Self:C308->:=$oldRUT
								GOTO OBJECT:C206(Self:C308->)
							Else 
								Self:C308->:=[ACT_Terceros:138]RUT:4
							End if 
						Else 
							[ACT_Terceros:138]RUT:4:=$oldRUT
							Self:C308->:=$oldRUT
							GOTO OBJECT:C206(Self:C308->)
							vMsg:=__ ("Error. Ya existe un Tercero con el mismo ")+<>at_IDNacional_Names{1}+"."
						End if 
					Else 
						  //SET FORMAT(Self->;"")
					End if 
				End if 
			Else 
				[ACT_Terceros:138]RUT:4:=ST_Uppercase (Self:C308->)
		End case 
End case 