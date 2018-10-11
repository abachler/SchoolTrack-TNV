Case of 
	: ((Self:C308->=1) & (vr_MinimoExRecuperatorio=-10))
		vr_MinimoExRecuperatorio:=rPctMinimum
		vs_MinimoExRecuperatorio:=NTA_PercentValue2StringValue (vr_MinimoExRecuperatorio)
		
	: ((Self:C308->=1) & (vr_MinimoExRecuperatorio>=vrNTA_MinimoEscalaReferencia))
		vs_MinimoExRecuperatorio:=NTA_PercentValue2StringValue (vr_MinimoExRecuperatorio)
		
	: (Self:C308->=0)
		vr_MinimoExRecuperatorio:=-10
		vs_MinimoExRecuperatorio:=""
		
		
End case 

