//%attributes = {}
  //ACTwiz_ConfiguraCamposTf

If (USR_GetUserID <0)
	C_TEXT:C284($vt_accion)
	If (Count parameters:C259>=1)
		$vt_accion:=$1
	End if 
	Case of 
		: ($vt_accion="")
			WDW_OpenFormWindow (->[xxACT_TransferenciaBancaria:131];"ACT_CFG_BankTransferFile";-1;4;__ ("Asistentes"))
			DIALOG:C40([xxACT_TransferenciaBancaria:131];"ACT_CFG_BankTransferFile")
			CLOSE WINDOW:C154
			
		: ($vt_accion="TransferenciaCMT")
			CMT_Transferencia 
			
	End case 
End if 