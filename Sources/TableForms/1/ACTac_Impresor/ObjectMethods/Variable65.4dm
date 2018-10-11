If (bPDF2Mail=1)
	
	PREF_Set (0;"ACT_EnvioPDFAC_AC";String:C10(r_opMail1_AC))
	PREF_Set (0;"ACT_EnvioPDFAC_AA";String:C10(r_opMail2_AA))
	PREF_Set (0;"ACT_EnvioPDFAC_Ambos";String:C10(r_opMail3_Ambos))
	
	PREF_Set (0;"ACT_EnvioPDFAC_AC_Casilla";String:C10(cs_opMail1_AC))
	PREF_Set (0;"ACT_EnvioPDFAC_AA_Casilla";String:C10(cs_opMail2_AA))
	PREF_Set (0;"ACT_EnvioPDFAC_AResponsable";String:C10(cs_opMail3Responsable))
	
End if 