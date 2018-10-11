[ACT_Terceros:138]RUT:4:=CTRY_CL_VerifRUT ([ACT_Terceros:138]RUT:4)
If ([ACT_Terceros:138]RUT:4#"")
	If (KRL_RecordExists (->[ACT_Terceros:138]RUT:4))
		CD_Dlog (0;__ ("Ya existe una persona con este RUT."))
		[ACT_Terceros:138]RUT:4:=""
		GOTO OBJECT:C206([ACT_Terceros:138]RUT:4)
	End if 
Else 
	GOTO OBJECT:C206([ACT_Terceros:138]RUT:4)
End if 
If (Not:C34([ACT_Terceros:138]Es_empresa:2))
	ACTter_SetIdentificador 
Else 
	  //If (Num(Substring([ACT_Terceros]RUT;1;Length([ACT_Terceros]RUT)-1))>0)
	  //20121105 RCH
	If ((Num:C11(Substring:C12([ACT_Terceros:138]RUT:4;1;Length:C16([ACT_Terceros:138]RUT:4)-1))>0) & (<>gCountryCode="cl"))
		OBJECT SET FORMAT:C236([ACT_Terceros:138]RUT:4;"###.###.###-#")
	Else 
		OBJECT SET FORMAT:C236([ACT_Terceros:138]RUT:4;"")
	End if 
End if 