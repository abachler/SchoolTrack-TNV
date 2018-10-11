  //Case of 
  //: (g1_Mail=1)
$cond:=((SN3_MailAddress#"") & ((cb_FormatoXLS=1) | (cb_FormatoPDF=1)))
  //: (g2_Directo=1)
  //$cond:=((cb_FormatoXLS=1) | (cb_FormatoPDF=1))
  //End case 
IT_SetButtonState ($cond;->bSend)