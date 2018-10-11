Case of 
	: (Form event:C388=On After Edit:K2:43)
		$mail:=Get edited text:C655
		$mail:=SMTP_VerifyEmailAddress ($mail;False:C215)
		OBJECT SET ENABLED:C1123(bSend;($mail#""))
	: (Form event:C388=On Data Change:K2:15)
		Self:C308->:=SMTP_VerifyEmailAddress (Self:C308->)
		OBJECT SET ENABLED:C1123(bSend;(Self:C308->#""))
End case 