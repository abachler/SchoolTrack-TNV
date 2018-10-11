Case of 
	: (Form event:C388=On Load:K2:1)
		WDW_SlideDrawer (->[ACT_Documentos_de_Pago:176];"ElegirCtaDeposito")
		XS_SetInterface 
		vdACT_FechaDeposito:=Current date:C33(*)
		vtACT_DepositadoPor:=<>tUSR_CurrentUser
		vtACT_compDeposito:=""
		ARRAY TEXT:C222(atACT_CtaColegioCod;0)
		ARRAY TEXT:C222(atACT_CtaColegioBanco;0)
		ARRAY TEXT:C222(atACT_CtaColegioCta;0)
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->atACT_CtaColegioCod;->atACT_CtaColegioBanco;->atACT_CtaColegioCta)
		xBlob:=PREF_fGetBlob (0;"ACT_CtasColegio";xBlob)
		BLOB_Blob2Vars (->xBlob;0;->atACT_CtaColegioCod;->atACT_CtaColegioBanco;->atACT_CtaColegioCta)
		ALP_DefaultColSettings (xALP_CtasBancarias;1;"atACT_CtaColegioBanco";__ ("Banco");200)
		ALP_DefaultColSettings (xALP_CtasBancarias;2;"atACT_CtaColegioCta";__ ("Cuenta");150)
		ALP_DefaultColSettings (xALP_CtasBancarias;3;"atACT_CtaColegioCod";"")
		
		  //general options
		ALP_SetDefaultAppareance (xALP_CtasBancarias;9;1;6;1;8)
		AL_SetColOpts (xALP_CtasBancarias;1;1;1;1;0)
		AL_SetRowOpts (xALP_CtasBancarias;0;1;0;0;1;0)
		AL_SetMiscOpts (xALP_CtasBancarias;0;0;"\\";0;1)
		AL_SetMainCalls (xALP_CtasBancarias;"";"")
		AL_SetScroll (xALP_CtasBancarias;0;-3)
		AL_SetEntryOpts (xALP_CtasBancarias;3;0;0;0;0;".";1)
		AL_SetDrgOpts (xALP_CtasBancarias;0;30;0)
		AL_SetLine (xALP_CtasBancarias;0)
		$usarCtas:=Num:C11(PREF_fGet (0;"ACT_UsarCtas";"0"))
		If ((Size of array:C274(atACT_CtaColegioBanco)=0) | ($usarCtas=0))
			_O_ENABLE BUTTON:C192(bOK)
		Else 
			If (Size of array:C274(atACT_CtaColegioBanco)=0)
				_O_ENABLE BUTTON:C192(bOK)
			Else 
				_O_DISABLE BUTTON:C193(bOK)
			End if 
		End if 
		ARRAY TEXT:C222(atACT_Depositadores;0)
		READ ONLY:C145([ACT_Documentos_de_Pago:176])
		ALL RECORDS:C47([ACT_Documentos_de_Pago:176])
		DISTINCT VALUES:C339([ACT_Documentos_de_Pago:176]Depositado_Por:43;atACT_Depositadores)
		If ($usarCtas=1)
			OBJECT SET VISIBLE:C603(*;"Config";True:C214)
			OBJECT SET VISIBLE:C603(*;"NoConfig";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"Config";False:C215)
			OBJECT SET VISIBLE:C603(*;"NoConfig";True:C214)
		End if 
		vlACT_SelectedCta:=-1
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
End case 
