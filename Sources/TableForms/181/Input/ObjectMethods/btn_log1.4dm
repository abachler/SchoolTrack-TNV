Case of 
	: (<>gCountryCode="ar")
		If ([ACT_Boletas:181]AR_RespuestaWS:50#"")
			vt_msg:=[ACT_Boletas:181]AR_RespuestaWS:50
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"CMT_Console";-1;4;__ ("XML respuesta"))
			DIALOG:C40([xxSTR_Constants:1];"CMT_Console")
			CLOSE WINDOW:C154
		End if 
		
	Else 
		
		If ([ACT_Boletas:181]DTE_log:26#"")
			vt_msg:=[ACT_Boletas:181]DTE_log:26
			WDW_OpenFormWindow (->[xxSTR_Constants:1];"CMT_Console";-1;4;__ ("Log"))
			DIALOG:C40([xxSTR_Constants:1];"CMT_Console")
			CLOSE WINDOW:C154
		End if 
End case 