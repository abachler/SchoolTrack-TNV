Case of 
	: (Form event:C388=On Data Change:K2:15)
		Self:C308->:=ST_Uppercase (Self:C308->)
		Self:C308->:=CTRY_CL_VerifRUT (Self:C308->)
		If (Self:C308->#"")
			If (KRL_RecordExists (Self:C308))
				$resp:=CD_Dlog (0;__ ("Ya existe un registro con este RUT.")+"\r\r"+__ ("¿Desea mantenerlo?");"";__ ("Si");__ ("No"))
				If ($resp=2)
					Self:C308->:=""
					GOTO OBJECT:C206(Self:C308->)
				End if 
			End if 
		End if 
End case 