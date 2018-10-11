If (Self:C308->#"")
	Self:C308->:=SMTP_VerifyEmailAddress (Self:C308->)
	If (Self:C308->="")
		GOTO OBJECT:C206(Self:C308->)
	End if 
End if 