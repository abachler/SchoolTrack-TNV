Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		ARRAY TEXT:C222(atACT_CtaColegioCod;0)
		ARRAY TEXT:C222(atACT_CtaColegioBanco;0)
		ARRAY TEXT:C222(atACT_CtaColegioCta;0)
		SET BLOB SIZE:C606(xBlob;0)
		BLOB_Variables2Blob (->xBlob;0;->atACT_CtaColegioCod;->atACT_CtaColegioBanco;->atACT_CtaColegioCta)
		xBlob:=PREF_fGetBlob (0;"ACT_CtasColegio";xBlob)
		cb_UtilizarCtas:=Num:C11(PREF_fGet (0;"ACT_UsarCtas";"0"))
		BLOB_Blob2Vars (->xBlob;0;->atACT_CtaColegioCod;->atACT_CtaColegioBanco;->atACT_CtaColegioCta)
		ALP_DefaultColSettings (xALP_CtasBancarias;1;"atACT_CtaColegioBanco";__ ("Banco");200)
		ALP_DefaultColSettings (xALP_CtasBancarias;2;"atACT_CtaColegioCta";__ ("Cuenta");150;"";0;0;1)
		ALP_DefaultColSettings (xALP_CtasBancarias;3;"atACT_CtaColegioCod";"")
		AL_SetEnterable (xALP_CtasBancarias;1;2;atACT_BankName)
		
		  //general options
		ALP_SetDefaultAppareance (xALP_CtasBancarias;9;1;6;1;8)
		AL_SetColOpts (xALP_CtasBancarias;1;1;1;1;0)
		AL_SetRowOpts (xALP_CtasBancarias;0;1;0;0;1;0)
		AL_SetMiscOpts (xALP_CtasBancarias;0;0;"\\";0;1)
		AL_SetMainCalls (xALP_CtasBancarias;"";"")
		AL_SetCallbacks (xALP_CtasBancarias;"";"xALCB_EX_CtasBancarias")
		AL_SetScroll (xALP_CtasBancarias;0;-3)
		AL_SetEntryOpts (xALP_CtasBancarias;3;0;0;0;0;".";1)
		AL_SetDrgOpts (xALP_CtasBancarias;0;30;0)
		AL_SetLine (xALP_CtasBancarias;0)
		_O_DISABLE BUTTON:C193(bDelFP)
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 