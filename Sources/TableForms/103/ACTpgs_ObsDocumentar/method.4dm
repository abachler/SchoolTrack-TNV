Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		C_BOOLEAN:C305(vb_validaObsVacia)
		C_TEXT:C284(vt_Dlog)
		XS_SetInterface 
	: (Form event:C388=On Outside Call:K2:11)
		XS_SetInterface 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 