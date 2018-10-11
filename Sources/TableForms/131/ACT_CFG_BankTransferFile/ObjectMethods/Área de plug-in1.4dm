If (alProEvt=1)
	$col:=AL_GetColumn (Self:C308->)
	$line:=AL_GetLine (Self:C308->)
	Case of 
		: ($col=2)
			ab_EnPATAL{$line}:=Not:C34(ab_EnPATAL{$line})
			ab_EnPAT{al_PosicionAL{$line}}:=ab_EnPATAL{$line}
		: ($col=3)
			ab_EnPACAL{$line}:=Not:C34(ab_EnPACAL{$line})
			ab_EnPAC{al_PosicionAL{$line}}:=ab_EnPACAL{$line}
		: ($col=4)
			ab_EnCUPONERAAL{$line}:=Not:C34(ab_EnCUPONERAAL{$line})
			ab_EnCUPONERA{al_PosicionAL{$line}}:=ab_EnCUPONERAAL{$line}
		: ($col=5)
			ab_EnCONTABILIDADAL{$line}:=Not:C34(ab_EnCONTABILIDADAL{$line})
			ab_EnCONTABILIDAD{al_PosicionAL{$line}}:=ab_EnCONTABILIDADAL{$line}
	End case 
	AL_UpdateArrays (Self:C308->;-1)
End if 