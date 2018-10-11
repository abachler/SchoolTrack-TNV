Case of 
	: (FORM Get current page:C276=6)
		$admissionTrackIsInitialized:=Num:C11(PREF_fGet (0;"ADT_Inicializado";"0"))
		$recs:=Records in table:C83([ADT_Candidatos:49])
		If (($admissionTrackIsInitialized=0) | ($recs=0))
			FORM NEXT PAGE:C248
		End if 
End case 
FORM NEXT PAGE:C248
POST KEY:C465(Character code:C91("+");256)