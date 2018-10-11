If (Form event:C388=On Data Change:K2:15)
	vbSpell_StopChecking:=True:C214
End if 

If (<>vtXS_CountryCode="cl")
	Self:C308->:=Replace string:C233(Self:C308->;".";"")
	Self:C308->:=Replace string:C233(Self:C308->;"-";"")
	Self:C308->:=CTRY_CL_VerifRUT (Self:C308->)
	OBJECT SET FORMAT:C236([Colegio:31]Director_RUN:28;"###.###.###-#")
Else 
	OBJECT SET FORMAT:C236([Colegio:31]Director_RUN:28;"")
End if 