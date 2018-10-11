Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vMsg:=""
	: (Form event:C388=On Data Change:K2:15)
		If (vsPST_Persona="mother")
			$oldRUT:=vsPST_RUTMOTHER
			$NoPersona:=vlPST_IDMOTHER
		Else 
			$oldRUT:=vsPST_RUTFATHER
			$NoPersona:=vlPST_IDFATHER
		End if 
		vMsg:=""
		Case of 
			: (<>vtXS_CountryCode="cl")
				If (Self:C308->#"")
					Self:C308->:=ST_Uppercase (Self:C308->)
					Self:C308->:=CTRY_CL_VerifRUT (Self:C308->;False:C215)
					If (Self:C308->#"")
						SET QUERY LIMIT:C395(1)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
						QUERY:C277([Personas:7];[Personas:7]RUT:6=Self:C308->;*)
						QUERY:C277([Personas:7]; & ;[Personas:7]No:1#$NoPersona)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						SET QUERY LIMIT:C395(0)
						If ($recs>0)
							BEEP:C151
							vMsg:="Error: Ya existe una persona con "+<>at_IDNacional_Names{1}+" "+Self:C308->+"."
							OK:=0
							Self:C308->:=$oldRUT
							GOTO OBJECT:C206(Self:C308->)
						End if 
					Else 
						Self:C308->:=$oldRUT
						GOTO OBJECT:C206(Self:C308->)
						vMsg:=<>at_IDNacional_Names{1}+" incorrecto."
					End if 
				End if 
			Else 
				Self:C308->:=ST_Uppercase (Self:C308->)
		End case 
End case 