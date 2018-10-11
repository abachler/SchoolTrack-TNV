If (Form event:C388=On After Keystroke:K2:26)
	If (SMTP_VerifyEmailAddress (Get edited text:C655;False:C215)#"")
		Self:C308->:=Get edited text:C655
		  //Case of 
		  //: (g1_Mail=1)
		$cond:=((SN3_MailAddress#"") & ((cb_FormatoXLS=1) | (cb_FormatoPDF=1)))
		  //: (g2_Directo=1)
		  //$cond:=(((cb_Imprimir=1) | (cb_Guardar=1)) & ((cb_FormatoXLS=1) | (cb_FormatoPDF=1)))
		  //End case 
		IT_SetButtonState ($cond;->bSend)
	Else 
		_O_DISABLE BUTTON:C193(bSend)
	End if 
End if 