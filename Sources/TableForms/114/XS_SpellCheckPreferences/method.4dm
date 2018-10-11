

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vi_AutoSpellCheck:=Num:C11(PREF_fGet (USR_GetUserID ;"AutoSpellCheck";"1"))
		vi_SpellTextFieldsOnly:=Num:C11(PREF_fGet (USR_GetUserID ;"SpellCheck_TextFieldsOnly";"1"))
		<>vl_Langage:=Num:C11(PREF_fGet (USR_GetUserID ;"SpellCheck_LANGAGE"))
		
		OBJECT SET FONT STYLE:C166(*;"langage@";0)
		Case of 
			: ((<>vl_Langage>=65536) & (<>vl_Langage<=69632))  //ENGLISH
				b2_English:=1
				OBJECT SET FONT STYLE:C166(*;"langage_english";1)
			: ((<>vl_Langage>=196608) & (<>vl_Langage<=197121))  //SPANISH
				b1_Spanish:=1
				OBJECT SET FONT STYLE:C166(*;"langage_spanish";1)
			: ((<>vl_Langage>=262144) & (<>vl_Langage<=262288))  //FRENCH
				b3_French:=1
				OBJECT SET FONT STYLE:C166(*;"langage_french";1)
			: ((<>vl_Langage>=Use PicRef:K28:4) & (<>vl_Langage<=131616))  //GERMAN
				b4_German:=1
				OBJECT SET FONT STYLE:C166(*;"langage_german";1)
		End case 
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		OBJECT SET FONT STYLE:C166(*;"langage@";0)
		Case of 
			: ((<>vl_Langage>=65536) & (<>vl_Langage<=69632))  //ENGLISH
				b2_English:=1
				OBJECT SET FONT STYLE:C166(*;"langage_english";1)
			: ((<>vl_Langage>=196608) & (<>vl_Langage<=197121))  //SPANISH
				b1_Spanish:=1
				OBJECT SET FONT STYLE:C166(*;"langage_spanish";1)
			: ((<>vl_Langage>=262144) & (<>vl_Langage<=262288))  //FRENCH
				b3_French:=1
				OBJECT SET FONT STYLE:C166(*;"langage_french";1)
			: ((<>vl_Langage>=Use PicRef:K28:4) & (<>vl_Langage<=131616))  //GERMAN
				b4_German:=1
				OBJECT SET FONT STYLE:C166(*;"langage_german";1)
		End case 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 