//%attributes = {}
  //WIZ_ACT_GeneracionArchContables

If (USR_GetMethodAcces (Current method name:C684))
	vlNextCCID:=1
	ACTcbl_InitArrays 
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_Asistente_Contables";-1;4;__ ("Asistentes"))
	DIALOG:C40([xxSTR_Constants:1];"ACT_Asistente_Contables")
	CLOSE WINDOW:C154
	If (ok=1)
		ACTcfg_LoadConfigData (9)
		C_LONGINT:C283(vl_indiceTrf)
		vl_indiceTrf:=Find in array:C230(aSoftwares;vSoftware)
		If (al_idsArchivosContables{vl_indiceTrf}=0)  //softland antiguo
			If (cbFacturacion=1)
				If (td1=1)
					ACTwiz_GenerarXAvisos 
				Else 
					ACTwiz_GenerarXDTs 
				End if 
			End if 
			If (cbRecaudacion=1)
				ACTwiz_GenerarRecaudacion 
			End if 
		Else 
			If (cbFacturacion=1)
				If (td2=1)
					ACTwiz_GenerarXDTsWTrf 
				Else 
					If ((td1=1) | (td3=1))
						ACTwiz_GenerarXAvisosPagosWTrf 
					End if 
				End if 
			End if 
			If (cbRecaudacion=1)
				ACTwiz_GenerarXAvisosPagosWTrf 
			End if 
		End if 
		AT_Initialize (->acampo1;->acampo2;->acampo3;->acampo4;->acampo5;->acampo6;->acampo7;->acampo8;->acampo9;->acampo10;->acampo11;->acampo12;->acampo13;->acampo14;->acampo15;->acampo16;->acampo17;->acampo18;->acampo19;->acampo20;->acampo21;->acampo22;->acampo23;->acampo24;->acampo25;->acampo26;->acampo27;->acampo28;->acampo29;->acampo30;->acampo31;->acampo32;->acampo33;->acampo34;->acampo35;->acampo36;->acampo37;->acampo38;->acampo39;->aenccuenta;->aID;->alACT_IdsBoletas)
		AT_Initialize (->acampocc1;->acampocc2;->acampocc3;->acampocc4;->acampocc5;->acampocc6;->acampocc7;->acampocc8;->acampocc9;->acampocc10;->acampocc11;->acampocc12;->acampocc13;->acampocc14;->acampocc15;->acampocc16;->acampocc17;->acampocc18;->acampocc19;->acampocc20;->acampocc21;->acampocc22;->acampocc23;->acampocc24;->acampocc25;->acampocc26;->acampocc27;->acampocc28;->acampocc29;->acampocc30;->acampocc31;->acampocc32;->acampocc33;->acampocc34;->acampocc35;->acampocc36;->acampocc37;->acampocc38;->acampocc39;->aCCID)
		AT_Initialize (->aHeadersCbl)
	End if 
End if 