If (<>vtXS_CountryCode="cl")
	Self:C308->:=Replace string:C233(Self:C308->;".";"")
	Self:C308->:=Replace string:C233(Self:C308->;"-";"")
	Self:C308->:=CTRY_CL_VerifRUT (Self:C308->)
	OBJECT SET FORMAT:C236([Colegio:31]RepresentanteLegal_RUN:40;"###.###.###-#")
Else 
	OBJECT SET FORMAT:C236([Colegio:31]RepresentanteLegal_RUN:40;"")
End if 