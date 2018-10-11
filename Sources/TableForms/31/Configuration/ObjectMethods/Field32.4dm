If (<>vtXS_CountryCode="cl")
	Self:C308->:=Replace string:C233(Self:C308->;".";"")
	Self:C308->:=Replace string:C233(Self:C308->;"-";"")
	Self:C308->:=CTRY_CL_VerifRUT (Self:C308->)
	OBJECT SET FORMAT:C236([Colegio:31]RUT:2;"###.###.###-#")
Else 
	OBJECT SET FORMAT:C236([Colegio:31]RUT:2;"")
End if 